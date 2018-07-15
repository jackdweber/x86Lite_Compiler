module X86.Simulator where

import Data.Bits
import Data.Array.IArray
import Data.Int
import Data.Word
import X86.Machine
import X86

import Debug.Trace

--------------------------------------------------------------------------------
-- Simulator                                                                  --
--------------------------------------------------------------------------------

{-

Your task in this homework is to write a simulator for the core x86 instruction
set. At the high level, this will take the form of a function `step` which,
given a `Machine` value representing the current state of the machine, produces
a new `Machine` value representing the next state of the machine.

To do so, you will have to:

 1. Fetch the next instruction to execute (that is, the instruction pointed to
    by RIP), and increment the instruction pointer.

 2. Retrieve operands from memory, if necessary.

 3. Perform the instruction.

 4. Update memory and the flags with the results of the instruction, as
    appropriate.

You may find it helpful to structure your solution accordingly, defining helper
functions for moving Int64 values to and from memory, getting from or updating
operands, and performing individual operations.

You do not need to perform any error checking---you may assume that instructions
have the right number of operands, memory addresses are in range, and so forth.
You do not need to represent the more arcane restrictions of x86---such as the
limitation that at most one operand to may be indirect, or the limitations on
indirection in the `imul` instruction.

You may assume that the shift instructions (`shl`, `shr`, `sar`) never set the
overflow flag.  (In real x86, 1-bit shifts may set the overflow flag.)

Haskell provides functions `shiftL` and `shiftR` that do left and right
arithmetic shifts.  To get a right logical shift, it suffices to convert a
signed `Int64` value to it unsigned `Word64` equivalent, shift that value, and
then convert back to `Int64`.  The generic `fromIntegral` function can do both
conversions, so long as the result of the conversion is specified (in the
types).

-}

condition :: Condition -> Machine -> Bool
condition Eq m  = getZF m
condition Neq m = not (getZF m)
condition Gt m  = not (getZF m) && not (getSF m)
condition Ge m  = not (getSF m)
condition Lt m  = getSF m `xor` getOF m
condition Le m  = (getSF m `xor` getOF m) || getZF m

fetch :: Machine -> (MachineInstr, Machine)
fetch m0 =
    case [getMemory (getRIP m0 + i) m0 | i <- [0..3]] of
      [Inst i, More, More, More] -> (i, setRIP (getRIP m0 + 4) m0)
      _ -> error $ "Unable to interpret RIP (" ++ show (getRIP m0) ++ ") as an instruction"

getQuad :: Int64 -> Machine -> Int64
getQuad start m = fromBytes bytes
    where bytes = map byteFrom [getMemory (start + i) m | i <- [0..7]]
          byteFrom (Byte b) = b
          byteFrom _ = error "Unable to interpret memory location as bytes"

putQuad :: Int64 -> Int64 -> Machine -> Machine
putQuad addr val m = foldr f m (zip [0..] bytes)
    where bytes = fromQuad val
          f (j, b) = setMemory (addr + j) (Byte b)

getOperand :: Operand Int64 -> Machine -> Int64
getOperand (Imm i) _       = i
getOperand (Reg r) m       = getRegister r m
getOperand (IndImm i) m    = getQuad i m
getOperand (IndReg r) m    = getQuad (getRegister r m) m
getOperand (IndBoth i r) m = getQuad (getRegister r m + i) m

putOperand :: Operand Int64 -> Int64 -> Machine -> Machine
putOperand (Imm _) _ _         = error "Can't write to immediate"
putOperand (Reg r) val m       = setRegister r val m
putOperand (IndImm i) val m    = putQuad i val m
putOperand (IndReg r) val m    = putQuad (getRegister r m) val m
putOperand (IndBoth i r) val m = putQuad (getRegister r m + i) val m

unary :: (Int64 -> (Int64, Bool)) -> [Operand Int64] -> Machine -> Machine
unary op [arg] m = setFlags $ putOperand arg z $ clearFlags m
    where (z, overflow) = op (getOperand arg m)
          setFlags = setOF overflow .
                     setZF (z == 0) .
                     setSF (z < 0)
unary _ _ _ = error "Wrong number of operands for unary opcode"

(.+.), (.-.), (.*.) :: Int64 -> Int64 -> (Int64, Bool)
x .+. y = (z, (x > 0 && y > 0 && z < 0) || (x < 0 && y < 0 && z > 0))
    where z = x + y
x .-. y = (z, (x > y && y < 0 && z < 0) || (x < y && y > 0 && z > 0))
    where z = x - y
x .*. y = (z, (x > 0 && y > 0 && z < 0) || (x < 0 && y < 0 && z > 0))
    where z = x * y

arithmetic :: (Int64 -> Int64 -> (Int64, Bool)) -> [Operand Int64] -> Machine -> Machine
arithmetic op [src, dst] m = setFlags $ putOperand dst z $ clearFlags m
    where (z, overflow) = op (getOperand src m) (getOperand dst m)
          setFlags = setOF overflow .
                     setZF (z == 0) .
                     setSF (z < 0)
arithmetic _ _ _ = error "Wrong number of operands for binary opcode"

binary :: (Int64 -> Int64 -> Int64) -> [Operand Int64] -> Machine -> Machine
binary op [src, dst] m = setFlags $ putOperand dst z $ clearFlags m
    where z = op (getOperand src m) (getOperand dst m)
          setFlags = setZF (z == 0) .
                     setSF (z < 0)
binary _ _ _ = error "Wrong number of operands for binary opcode"

logicalShiftL, arithmeticShiftR, logicalShiftR :: Int64 -> Int64 -> Int64
logicalShiftL shift val = val `shiftL` fromIntegral shift
arithmeticShiftR shift val = val `shiftR` fromIntegral shift
logicalShiftR shift val = fromIntegral (val' `shiftR` fromIntegral shift)
    where val' :: Word64
          val' = fromIntegral val


step :: Machine -> Machine
step m0 = op operands m1
    where ((opcode, operands), m1) = fetch m0
          op = case opcode of
                 Movq -> move
                 Pushq -> push
                 Popq -> pop
                 Leaq -> lea
                 Incq -> unary (1 .+.)
                 Decq -> unary (.-. 1)
                 Negq -> unary (cantOverflow negate)
                 Notq -> unary (cantOverflow complement)
                 Addq -> arithmetic (.+.)
                 Subq -> arithmetic (flip (.-.))
                 Imulq -> arithmetic (.*.)
                 Xorq -> binary xor
                 Orq -> binary (.|.)
                 Andq -> binary (.&.)
                 Shlq -> binary logicalShiftL
                 Sarq -> binary arithmeticShiftR
                 Shrq -> binary logicalShiftR
                 Jmp -> jmp
                 J c | condition c m0 -> jmp
                     | otherwise -> const id
                 Cmpq -> cmpq
                 Set c -> set (condition c m0)
                 Callq -> call
                 Retq -> ret

          cantOverflow f x = (f x, False)

          move [src, dst] m0 = putOperand dst (getOperand src m0) m0
          move _ _ = error "Wrong number of operands for move"

          push [src] m0 =
              putQuad (getRegister RSP m0 - 8) (getOperand src m0) $
              setRegister RSP (getRegister RSP m0 - 8) m0
          push _ _ = error "Wrong number of operands for push"

          pop [dst] m0 =
              putOperand dst (getQuad (getRegister RSP m0) m0) $
              setRegister RSP (getRegister RSP m0 + 8) m0
          pop _ _ =  error "Wrong number of operands for pop"

          lea [IndImm i, dst] m0 =
              putOperand dst i m0
          lea [IndReg r, dst] m0 =
              putOperand dst (getRegister r m0) m0
          lea [IndBoth i r, dst] m0 =
              putOperand dst (i + getRegister r m0) m0
          lea _ _ =
              error "Wrong arguments for lea"

          jmp [arg] m0 = setRIP (getOperand arg m0) m0
          jmp _ _ =
              error "Wrong number of operands for jump"

          cmpq [src1, src2] m = setFlags m
              where (z, overflow) = getOperand src2 m .-. getOperand src1 m
                    setFlags = setOF overflow .
                               setZF (z == 0) .
                               setSF (z < 0)

          set b [dst] m0 = putOperand dst w m0
              where v = getOperand dst m0
                    w = if b then v .&. (-1 `shiftL` 8) .|. 1 else v .&. (-1 `shiftL` 8)
          set _ _ _ = error "wrong number of operands for set"

          call [arg] m0 =
              setRIP (getOperand arg m0) $
              putQuad (getRegister RSP m0 - 8) (getRIP m0) $
              setRegister RSP (getRegister RSP m0 - 8) m0
          call _ _ =
              error "wrong number of operands for call"

          ret [] m0 =
              setRegister RSP (getRegister RSP m0 + 8) $
              setRIP (getQuad (getRegister RSP m0) m0) m0
          ret _ _ = error "wrong number of operands for ret"

{-

The `run` function loops your `step` function until the IP equals the pre-defined
halt value, returning the final machine state.

-}

run :: Machine -> Machine
run initial = until ((haltAddr ==) . getRIP) step initial

eval :: Machine -> Int64
eval initial = getRegister RAX (run initial)
