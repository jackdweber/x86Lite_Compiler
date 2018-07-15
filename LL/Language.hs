module LL.Language (module LL.Language, Condition(..)) where

import Data.Int

import X86(Condition(..))

--------------------------------------------------------------------------------
-- Types                                                                      --
--------------------------------------------------------------------------------

data Type = Void | I1 | I8 | I32 | I64
          | Ptr Type | Struct [Type] | Array Int64 Type
          | Fun [Type] Type | Named String
  deriving (Eq, Read, Show)

--------------------------------------------------------------------------------
-- Instructions                                                               --
--------------------------------------------------------------------------------

data Operator = Add | Sub | Mul | Shl | Lshr | Ashr | And | Or | Xor
  deriving (Eq, Read, Show)

data Operand = Const Int64 | Gid String | Uid String
  deriving (Eq, Read, Show)

data Instruction
    = Bin String Operator Type Operand Operand  -- %uid = binop t op, op
    | Alloca String Type                        -- %uid = alloca t
    | Load String Type Operand                  -- %uid = load t, t* op
    | Store Type Operand Operand                -- store t op1, t* op2
    | Icmp String Condition Type Operand Operand -- %uid = icmp rel t op1 op2
    | Call String Type String [(Type, Operand)] -- %uid = call ret_ty name(t1 op1, t2 op2, ...)
    | Bitcast String Type Operand Type          -- %uid = bitcast t1 op to t2
    | Gep String Type Operand [Operand]         -- %uid = getelementptr t op, i64 op1, i64 op2
                                                --    .. or i32, if accessing struct...
  deriving (Eq, Read, Show)

data Terminator
    = Ret Type (Maybe Operand)
    | Bra String
    | CBr Operand String String
  deriving (Eq, Read, Show)

--------------------------------------------------------------------------------
-- Programs                                                                   --
--------------------------------------------------------------------------------

type Block = ([Instruction], Terminator)

type Cfg = (Block, [(String, Block)])

type Function = ([(Type, String)], Type, Cfg)

data Initializer = INull | IGid String | IInt Int64 | IString String
                 | IArray [(Type, Initializer)] | IStruct [(Type, Initializer)]
  deriving (Eq, Read, Show)

type Types = [(String, Type)]
type Globals = [(String, Type, Initializer)]
type Functions = [(String, Function)]
type Externs = [(String, Type)]   -- This looks the same as Types, but it means something very
                                  -- different---the names are *variable* identifiers, with their
                                  -- associated types, not *type* identifiers with their meanings.

data Prog = P { types     :: Types
              , globals   :: Globals
              , functions :: Functions
              , externs   :: Externs }
  deriving (Eq, Read, Show)
