module X86.Loader where

import Data.Array.IArray
import Data.Char
import Data.Int
import Data.List
import Data.Maybe

import X86.Machine
import X86

--------------------------------------------------------------------------------
-- Executable images                                                          --
--------------------------------------------------------------------------------

data Executable = E { start, textAddr, dataAddr :: Int64
                    , textSegment, dataSegment :: [SByte] }

--------------------------------------------------------------------------------
-- Assembler                                                                  --
--------------------------------------------------------------------------------

assemble :: Prog -> Executable
assemble p = E { start = fromJust (lookup "main" labels)
               , textAddr = memoryFloor
               , dataAddr = dataStart
               , textSegment = concatMap (sbytesFromInstr . patch labels . snd) codeBlocks
               , dataSegment = concatMap (sbytesFromData labels . snd) dataBlocks }
    where (codeBlocks, dataBlocks) = foldr partitioner ([], []) p
              where partitioner (label, _, Text instrs) (codeBlocks, dataBlocks) = ((label, instrs) : codeBlocks, dataBlocks)
                    partitioner (label, _, Data bytes) (codeBlocks, dataBlocks) = (codeBlocks, (label, bytes) : dataBlocks)
          (labels, dataStart) = (finalLabelMap, dataStart)
              where codeLabels (i, labels) (label, instrs) = (i + blockLen, (label, i) : labels)
                        where blockLen = 4 * genericLength instrs
                    (dataStart, codeLabelMap) = foldl codeLabels (memoryFloor, []) codeBlocks
                    dataLabels (i, labels) (label, dataBlock) = (i + blockLen, (label, i) : labels)
                        where blockLen | rem == 0 = quotient * 4
                                       | otherwise = (quotient + 1) * 4
                                  where (quotient, rem) = sum (map datumLength dataBlock) `divMod` 4
                              datumLength (String cs) = genericLength cs + 1
                              datumLength (Word _)    = 8
                    (_, finalLabelMap) = foldl dataLabels (dataStart, codeLabelMap) dataBlocks
          patch labels = map (\(op, operands) -> (op, map (patchOperand labels) operands))
          patchOperand labels (Imm (Label l))    = Imm (fromJust (lookup l labels))
          patchOperand _ (Imm (Literal i))       = Imm i
          patchOperand _ (Reg r)                 = Reg r
          patchOperand labels (IndImm (Label l)) = IndImm (fromJust (lookup l labels))
          patchOperand _ (IndImm (Literal i))    = IndImm i
          patchOperand _ (IndReg r)              = IndReg r
          patchOperand _ (IndBoth i r)           = IndBoth i r
          sbytesFromInstr = concatMap (\i -> [Inst i, More, More, More])

          sbytesFromData labels dataBlock = concatMap (padToFour . sbytesFromDatum labels) dataBlock
          sbytesFromDatum _ (String cs) = map (Byte . fromIntegral . ord) cs ++ [Byte 0]
          sbytesFromDatum labels (Word (Label l)) = map Byte $ fromQuad (fromJust (lookup l labels))
          sbytesFromDatum labels (Word (Literal i)) = map Byte $ fromQuad i

          padToFour bs = bs ++ (replicate z $ Byte 0)
              where z = length bs `mod` 4

--------------------------------------------------------------------------------
-- Linker/loader                                                              --
--------------------------------------------------------------------------------

load :: Executable -> Machine
load e = zeroMachine{ mem = dataInMemory
                    , regs = regs zeroMachine // [(RSP, memoryCeiling)]
                    , rip = start e }
    where initialMem = mem zeroMachine
          codeInMemory = initialMem // zip [textAddr e..] (textSegment e)
          dataInMemory = codeInMemory // zip [dataAddr e..] (dataSegment e)
