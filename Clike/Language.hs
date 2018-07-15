module Clike.Language where

import Data.Int

data Type = Int | Struct [(Type, String)]
  deriving (Eq, Show)

data Operand = Var String | Const Int64 | Dot Operand String
  deriving (Eq, Show)

data Expr = OpE Operand | Bin BinOp Expr Expr | Unary UnaOp Expr | Call String [Expr]
  deriving (Eq, Show)

data BinOp = Plus | Minus | Times | And | Or | Xor | Shl | Lshr | Ashr
           | Eq | Neq | Lt | Lte | Gt | Gte
           | Assign
  deriving (Eq, Ord, Show)

data UnaOp = Negate | Complement
  deriving (Eq, Show)

data Stmt = ExpS Expr | Return Expr | Break | Continue
          | If Expr Stmt Stmt | While Expr Stmt
          | Block [Stmt] | Decl Type String
  deriving (Eq, Show)

data TopDecl = FunDecl Type String [(Type, String)] [Stmt]
  deriving (Eq, Show)

type Prog = [TopDecl]
