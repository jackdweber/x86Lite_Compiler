{-# LANGUAGE FlexibleInstances #-}
{-# LANGUAGE TypeSynonymInstances #-}
{-# LANGUAGE TypeFamilies #-}
module X86 where

import Data.Array.IArray
import Data.Bits
import Data.Char
import Data.Int
import Data.Word

--------------------------------------------------------------------------------
-- Instructions
--------------------------------------------------------------------------------

data Immediate =
    Literal Int64
  | Label String
  deriving (Eq, Show)

data Register =
    RAX | RBX | RCX | RDX
  | RSI | RDI | RBP | RSP
  | R08 | R09 | R10 | R11 | R12 | R13 | R14 | R15
  deriving (Eq, Ix, Ord, Read, Show)

{-

We have enriched the structure of operands from when we first discussed it in
class.  When writing programs, we want to be able to use labels to abstract
physical addresses.  However, our machine simulator will not have any knowledge
of the labels present in source programs, and so should not see operands
containing labels.  To assure this invariant, we parameterize the `Operand` data
type over the form of immediates.  Source programs will use operands of type
`Operand Immediate`, allowing both literals and labels, while machine programs
will use operands of type `Operand Int64`, allowing only literal operands.

-}

data Operand imm =
    Imm imm                 -- $5
  | Reg Register            -- %rax
  | IndImm imm              -- (label)
  | IndReg Register         -- (%rax)
  | IndBoth Int64 Register  -- -4(%rax)
  deriving (Eq, Read, Show)

type SourceOperand = Operand Immediate
type MachineOperand = Operand Int64

data Condition = Eq | Neq | Gt | Ge | Lt | Le
  deriving (Eq, Read, Show)

data Operation =
    Movq | Pushq | Popq
  | Leaq
  | Incq | Decq | Negq | Notq
  | Addq | Subq | Imulq | Xorq | Orq | Andq
  | Shlq | Sarq | Shrq
  | Jmp | J Condition
  | Cmpq | Set Condition
  | Callq | Retq
  deriving (Eq, Read, Show)

type Instruction imm = (Operation, [Operand imm])
type SourceInstr = Instruction Immediate
type MachineInstr = Instruction Int64

--------------------------------------------------------------------------------
-- Data
--------------------------------------------------------------------------------

data Data = String [Char] | Word Immediate
  deriving (Eq, Show)

data Asm = Text [SourceInstr] | Data [Data]
  deriving (Eq, Show)

type Prog = [(String, Bool, Asm)]

--------------------------------------------------------------------------------
-- Convenience functions
--------------------------------------------------------------------------------


(~~) :: SourceInstr -> Operand Immediate -> SourceInstr
(~$) :: SourceInstr -> Int64 -> SourceInstr
(~$$) :: SourceInstr -> String -> SourceInstr
(~%) :: SourceInstr -> Register -> SourceInstr

(op, operands) ~~ operand = (op, operands ++ [operand])
instr ~$ i = instr ~~ Imm (Literal i)
instr ~$$ l = instr ~~ Imm (Label l)
instr ~% r = instr ~~ Reg r

class IndirectReference r
    where (~#) :: SourceInstr -> r -> SourceInstr

instance IndirectReference String
    where instr ~# l = instr ~~ IndImm (Label l)

instance IndirectReference Register
    where instr ~# r = instr ~~ IndReg r

instance a ~ Int64 => IndirectReference (a, Register)
    where instr ~# (i, r) = instr ~~ IndBoth i r

(~#$) :: SourceInstr -> Int64 -> SourceInstr
instr ~#$ i = instr ~~ IndImm (Literal i)

global, text :: String -> [SourceInstr] -> (String, Bool, Asm)
global l ops = (l, True, Text ops)
text l ops = (l, False, Text ops)

movq, pushq, popq, leaq, incq, decq, negq, notq, addq, subq, imulq, xorq, orq, andq,
   shlq, sarq, shrq, jmp, cmpq, callq, retq :: SourceInstr

makeInstr :: Operation -> SourceInstr
makeInstr op = (op, [])

movq  = makeInstr Movq
pushq = makeInstr Pushq
popq  = makeInstr Popq
leaq  = makeInstr Leaq
incq  = makeInstr Incq
decq  = makeInstr Decq
negq  = makeInstr Negq
notq  = makeInstr Notq
addq  = makeInstr Addq
subq  = makeInstr Subq
imulq = makeInstr Imulq
xorq  = makeInstr Xorq
orq   = makeInstr Orq
andq  = makeInstr Andq
shlq  = makeInstr Shlq
sarq  = makeInstr Sarq
shrq  = makeInstr Shrq
jmp   = makeInstr Jmp
cmpq  = makeInstr Cmpq
callq = makeInstr Callq
retq  = makeInstr Retq

j, set :: Condition -> SourceInstr
j   = makeInstr . J
set = makeInstr . Set
