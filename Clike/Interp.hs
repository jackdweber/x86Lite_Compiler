{-# LANGUAGE FlexibleContexts #-}
module Clike.Interp where

import Clike.Language

import Control.Monad.Reader
import Control.Monad.State
import Data.Bits
import Data.Int
import qualified Data.Map as Map
import Data.Maybe
import Data.Word

{-------------------------------------------------------------------------------

The Clike interpreter.  This should mostly be usable as a black box: generate
test cases, feed them to the interpreter, observe its response.  However,
studying the code may be useful in some cases if you are stuck with the
compiler.

-------------------------------------------------------------------------------}

{-------------------------------------------------------------------------------

Values are either numbers, structures, or uninitialized.  Your compiler doesn't
have to worry about uninitialized values... but Haskell makes us do something
with them.

-------------------------------------------------------------------------------}

data Value = Uninitialized | Num Int64 | StructV (Map.Map String Value)
  deriving (Eq, Show)

interp :: Prog -> Value
interp p = evalState (runReaderT (interpe (Call "main" [])) p) [Map.empty]

{-------------------------------------------------------------------------------

The model of evaluation.  We keep access to the list of function declarations,
for interpreting function calls, and a model of stack frames.

-------------------------------------------------------------------------------}

type EvalM t = ReaderT Prog (State [Map.Map String Value]) t

{-------------------------------------------------------------------------------

Primitive operations of the EvalM monad.

-------------------------------------------------------------------------------}

newVar x = modify (\(m : ms) -> Map.insert x Uninitialized m : ms)
getVar x = gets walkStack
    where walkStack [] = error $ "Unbound variable " ++ x
          walkStack (m : ms) = fromMaybe (walkStack ms) (Map.lookup x m)
putVar x v = modify walkStack
    where walkStack [] = error $ "Unbound variable " ++ x
          walkStack (m : ms) =
              case Map.lookup x m of
                Nothing -> m : walkStack ms
                Just _  -> Map.insert x v m : ms

function x = asks findFunction
    where findFunction [] = error ("Unbound function " ++ x)
          findFunction (FunDecl _ y args body : rest)
              | x == y = (map snd args, body)
              | otherwise = findFunction rest

{-------------------------------------------------------------------------------

As in my implementation of compiling statements, my interpreter for statements
keeps track of three possible ways for execution to proceed after each
statement: in case of a continue, in case of a break, or normally.

-------------------------------------------------------------------------------}

interps :: Stmt -> EvalM () -> EvalM () -> EvalM () -> EvalM ()
interps (ExpS e) continue break rest =
    do interpe e
       rest
interps (Decl _ x) continue break rest =
    do newVar x
       rest
interps (Return e) _ _ _ =
    do v <- interpe e
       modify (\(m:ms) -> Map.insert "" v m : ms)
       -- This is an unpleasant hack: to model the return value, I use a special
       -- entry in the stack frame.  The implementation of Call knows to look
       -- there.  This doesn't correspond to anything in the compiler.
interps (Block stmts) continue break rest'  =
    foldr (\s rest -> interps s continue break rest) rest' stmts
interps (If cond cons alt) continue break rest =
    do Num v <- interpe cond
       if v == 0
       then interps alt continue break rest
       else interps cons continue break rest
interps Break _ break _ =
    break
interps Continue continue _ _ =
    continue
interps (While cond body) continue break rest =
    do Num v <- interpe cond
       if v == 0
       then rest
       else interps body (interps (While cond body) continue break rest) rest (interps (While cond body) continue break rest)

{-------------------------------------------------------------------------------

Expressions can mostly be mapped directly to their Haskell equivalents.  The one
exception is assignment; here, we need to muddle with the state.

-------------------------------------------------------------------------------}

interpe :: Expr -> EvalM Value
interpe (OpE o) =
    interpo o
interpe (Bin Assign (OpE (Var x)) e) =
    do v <- interpe e
       putVar x v
       return v
interpe (Bin Assign (OpE p@(Dot _ _)) e) =
    do v <- interpe e
       w <- getVar x
       putVar x (updateStruct v ls w)
       return v
    where flattenPath (Var x) = (x, [])
          flattenPath (Const _) = error "Malformed path"
          flattenPath (Dot o l) = (v, ls ++ [l])
              where (v, ls) = flattenPath o
          (x, ls) = flattenPath p
          updateStruct v [l] (StructV m)    = StructV (Map.insert l v m)
          updateStruct v (l:ls) (StructV m) = StructV (Map.update (Just . updateStruct v ls) l m)
          updateStruct _ _ _                = error "Mistyped assignment"
interpe (Bin Assign _ _) =
    error "Malformed assignment"
interpe (Bin op e1 e2) =
    do Num v1 <- interpe e1
       Num v2 <- interpe e2
       return (Num (binary op v1 v2))
    where binary Plus = (+)
          binary Minus = (-)
          binary Times = (*)
          binary And = (.&.)
          binary Or = (.|.)
          binary Xor = xor
          binary Shl = \x y -> x `shiftL` fromIntegral y
          binary Ashr = \x y -> x `shiftR` fromIntegral y
          binary Lshr = \x y -> fromIntegral ((fromIntegral x :: Word64) `shiftR` fromIntegral y)
          binary Eq = toNum (==)
          binary Neq = toNum (/=)
          binary Lt = toNum (<)
          binary Lte = toNum (<=)
          binary Gt = toNum (>)
          binary Gte = toNum (>=)
          toNum pred x y = if pred x y then 1 else 0
interpe (Unary op e) =
    do Num v <- interpe e
       return (Num (unary op v))
    where unary Negate = negate
          unary Complement = complement
interpe (Call f args) =
    do args' <- mapM interpe args
       (params, body) <- function f
       modify (Map.fromList (zip params args') :)
       interps (Block body) undefined undefined undefined
       r <- getVar ""   -- this is horrible; see also return
       modify tail
       return r

interpo :: Operand -> EvalM Value
interpo (Var x) =
    getVar x
interpo (Const i) =
    return (Num i)
interpo (Dot o l) =
    do StructV vs <- interpo o
       case Map.lookup l vs of
         Just v -> return v
         Nothing -> error "Invalid field access"
