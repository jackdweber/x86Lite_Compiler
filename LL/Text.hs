{-# LANGUAGE FlexibleInstances #-}
{-# LANGUAGE TypeSynonymInstances #-}
module LL.Text (module LL.Text, Printable(..)) where

import Data.Char (toLower)
import Data.List (intercalate)
import System.Info (os)
import LL.Language

import Text

instance Printable Type
    where textOf Void        = "void"
          textOf I1          = "i1"
          textOf I8          = "i8"
          textOf I64         = "i64"
          textOf (Ptr t)     = textOf t ++ "*"
          textOf (Struct ts) = "{" ++ intercalate "," (map textOf ts) ++ "}"
          textOf (Array n t) = "[" ++ show n ++ " x " ++ textOf t ++ "]"
          textOf (Fun ts t)  = textOf t ++ "(" ++ intercalate "," (map textOf ts) ++ ")"
          textOf (Named s)   = "%" ++ s

instance Printable Operator
    where textOf = map toLower . show

instance Printable Operand
    where textOf (Const i) = show i
          textOf (Uid s)   = "%" ++ s
          textOf (Gid s)   = "@" ++ s

spaces = intercalate " "

llvmRel Eq = "eq"
llvmRel Neq = "neq"
llvmRel Gt = "sgt"
llvmRel Ge = "sge"
llvmRel Lt = "slt"
llvmRel Le = "sle"

instance Printable Instruction
    where textOf (Bin dst bop ty op1 op2) =
              spaces ['%' : dst, "=", textOf bop, textOf ty, textOf op1 ++ ",", textOf op2]
          textOf (Alloca dst ty) =
              spaces ['%' : dst, "=", "alloca", textOf ty]
          textOf (Load dst ty op) =
              spaces ['%' : dst, "=", "load", textOf ty ++ ",", textOf (Ptr ty), textOf op]
          textOf (Store ty op1 op2) =
              spaces ["store", textOf ty, textOf op1 ++ ",", textOf (Ptr ty), textOf op2]
          textOf (Icmp dst rel ty op1 op2) =
              spaces ['%' : dst, "=", "icmp", llvmRel rel, textOf ty, textOf op1 ++ ",", textOf op2]
          textOf (Call dst rty fun ops) =
              spaces ['%' : dst, "=", "call", textOf rty, '@' : fun ++ operands]
              where operands = "(" ++ intercalate ", " [textOf ty ++ ' ' : textOf op | (ty, op) <- ops] ++ ")"
          textOf (Bitcast dst srcty operand dstty) =
              spaces ['%' : dst, "=", "bitcast", textOf srcty, textOf operand, "to", textOf dstty]
          textOf (Gep dst (Ptr ty) op path) =
              spaces ['%' : dst, "=", "getelementptr", textOf ty ++ ",", textOf (Ptr ty), textOf op ++ ",", pathText]
              where pathText = intercalate ", " [ case op of
                                                    Const i -> "i32 " ++ show i
                                                    _ -> "i64 " ++ textOf op     | op <- path ]

instance Printable Terminator
    where textOf (Ret _ Nothing) = "ret void"
          textOf (Ret ty (Just op)) = spaces ["ret", textOf ty, textOf op]
          textOf (Bra label) = spaces ["br", "label", '%' : label]
          textOf (CBr op cons alt) = spaces ["br", "i1", textOf op ++ ",", "label", '%' : cons ++ ",", "label", '%' : alt]

instance Printable Block
    where textOf (instrs, term) = unlines (map textOf instrs ++ [textOf term])

instance Printable Cfg
    where textOf (start, rest) = concat (textOf start : [label ++ ":\n" ++ textOf block | (label, block) <- rest])

instance Printable Initializer
    where textOf INull = "null"
          textOf (IGid s) = '@' : s
          textOf (IInt i) = show i
          textOf (IString s) = "\"" ++ s ++ "\""
          textOf (IArray is) = "[" ++ intercalate "," (map (textOf . snd) is) ++ "]"
          textOf (IStruct is) = "{" ++ intercalate "," (map (textOf . snd) is) ++ "}"

instance Printable Prog
    where textOf p = concat [typeDecls, globalDecls, funDecls, externDecls]
              where typeDecls = unlines [ spaces [ '%' : typeName, "=", "type", textOf t] | (typeName, t) <- types p ]
                    globalDecls = unlines [ spaces [ '@' : name, "=", textOf init ] | (name, _, init) <- globals p ]
                    funDecls = unlines [ "define " ++ textOf rty ++ " @" ++ funName ++ paramText ++ "{\n" ++ textOf cfg ++ "}" |
                                         (funName, (params, rty, cfg)) <- functions p,
                                         let paramText = "(" ++ intercalate "," [spaces [textOf ty, '%' : arg] | (ty, arg) <- params] ++ ")" ]
                    externDecls = unlines (map externText (externs p))
                    externText (name, Fun argtys rty) =
                        "declare " ++ textOf rty ++ " @" ++ name ++ "(" ++ intercalate "," (map textOf argtys) ++ ")"
                    externText (name, ty) =
                        "@" ++ name ++ " = external global " ++ textOf ty
