module Compiler where

import Clike.Language as Clike
import Clike.Text as Clike
import LL.Language as LL
import LL.Text as LL
import Text

import Data.List

import Debug.Trace

{-------------------------------------------------------------------------------

Entry point: compile Clike programs into LLVM programs.

Note: there is significant overlap of constructor names between the LLVM and
Clike syntax trees.  You should prefix constructors with LL. or Clike. to
distinguish them.

-------------------------------------------------------------------------------}

compileProgram :: Clike.Prog -> LL.Prog
compileProgram fdecls = P { types = [], globals = [], functions = map compileFunction fdecls, externs = [] }

{-------------------------------------------------------------------------------

Compiles Clike functions into LLVM functions.

This is the starting point of your implementation.  So long as this bit
corresponds to the results of the interpreter, you'll receive credit.

-------------------------------------------------------------------------------}

compileFunction :: Clike.TopDecl -> (String, LL.Function)
compileFunction (FunDecl typ name args stmts) = (name, ((map cleanArgs args), I64, (f))) where
    cleanArgs :: (Clike.Type, String) -> (LL.Type, String)
    cleanArgs (_, s) = (I64, s)
    f :: Cfg
    f = g $ compileStatements stmts [] [] [] 0
    g :: (([(String, LL.Block)], String), Int) -> (Block, [(String, Block)])
    g ((blocks, s), i) = ((getFirst blocks), (getRest blocks))
    getFirst :: [(String, LL.Block)] -> LL.Block
    getFirst ((_, b):xs) = b
    getRest :: [(String, LL.Block)] -> [(String, LL.Block)]
    getRest (x:xs) = xs


compileStatements :: [Clike.Stmt] -> String -> String -> String -> Int -> (([(String, LL.Block)], String), Int)
compileStatements stmts continueLabel breakLabel nextBlockLabel i =
    foldr (\stmt ((blocks, nextBlockLabel), i) ->
               let ((blocks', entry), i') = compileStatement stmt continueLabel breakLabel nextBlockLabel i in
               ((blocks' ++ blocks, entry), i'))
          (([], nextBlockLabel), i)
          stmts

{-------------------------------------------------------------------------------

My compileStatement function has the following interpretation:

    compileStatement stmt continueLabel breakLabel nextBlockLabel i

`stmt` is the statement to be compiled.  `continueLabel` is the label to jump to
in case of a continue.  `breakLabel` is the label to jump to in case of a break.
`nextBlockLabel` is the label to jump to should control exit normally.  Finally,
`i` is an integer used to generate fresh names.

My compileStatement returns three things: a list of blocks generated, the label
to use to enter those blocks, and finally the updated integer after generating
fresh names.

-------------------------------------------------------------------------------}


compileStatement :: Clike.Stmt -> String -> String -> String -> Int -> (([(String, LL.Block)], String), Int)
compileStatement stmt continueLabel breakLabel nextBlockLabel i = compileStatement' stmt where

    compileStatement' :: Clike.Stmt -> (([(String, LL.Block)], String), Int)

    compileStatement' (ExpS e) = (([((generateName i), (instructions, terminator))], (generateName i)), (i+1)) where
        instructions :: [LL.Instruction]
        instructions = g $ compileExpression e (i+1) where
            g ((ls,_), _) = ls
        terminator :: LL.Terminator
        terminator = Bra nextBlockLabel

    compileStatement' (Return e) = (([((generateName i), (instructions, terminator))], (generateName i)), (i+1)) where
        instructions :: [LL.Instruction]
        instructions = g $ compileExpression e (i+1) where
            g ((ls,op), _) = ls
        terminator :: LL.Terminator
        terminator = g $ compileExpression e (i+1) where
            g ((ls,op), _) = Ret I64 (Just op)
    
    compileStatement' (Break) = (([((generateName i), (instructions, terminator))], (generateName i)), (i+1)) where
        instructions :: [LL.Instruction]
        instructions = []
        terminator :: LL.Terminator
        terminator = Bra breakLabel

    compileStatement' (Continue) = (([((generateName i), (instructions, terminator))], (generateName i)), (i+1)) where
        instructions :: [LL.Instruction]
        instructions = []
        terminator :: LL.Terminator
        terminator = Bra continueLabel

    --Hard stuff the if and while

    compileStatement' (If e s s2) = (( ([((generateName i), (instructions, terminator))] ++ gets1 ++ gets2 ++ exit ), (generateName i)), (i+1))  where
        gets1 :: [(String, LL.Block)]
        gets1 = f $ compileStatement s ("_exit_" ++ (show i)) ("_exit_" ++ (show i)) ("_exit_" ++ (show i)) (i+1) where 
            f ((ls, s'), i') = ls
        gets2 :: [(String, LL.Block)]
        gets2 = f $ compileStatement s2 ("_exit_" ++ (show i)) ("_exit_" ++ (show i)) ("_exit_" ++ (show i)) (i+2) where 
            f ((ls, s'), i') = ls
        exit = [(("_exit_" ++ (show i)), ([], (Bra nextBlockLabel)) )]
        instructions :: [LL.Instruction]
        instructions = g $ compileExpression e (i+2) where
            g ((ls,op), _) = ls
        terminator :: LL.Terminator
        terminator = g $ compileExpression e (i+1) where
            g ((ls,op), _) = CBr op (f $ compileStatement s ("_exit_" ++ (show i)) ("_exit_" ++ (show i)) ("_exit_" ++ (show i)) (i+1)) (f $ compileStatement s2 ("_exit_" ++ (show i)) ("_exit_" ++ (show i)) ("_exit_" ++ (show i)) (i+2)) where
                f ((ls, s'), i') = s'

    compileStatement' (While e s) = (( ([((generateName i), (instructions, terminator))] ++ gets1 ), (generateName i)), (i+1))  where
        gets1 :: [(String, LL.Block)]
        gets1 = f $ compileStatement s (generateName i) (generateName i) (generateName i) (i+1) where 
            f ((ls, s'), i') = ls
        instructions :: [LL.Instruction]
        instructions = g $ compileExpression e (i+1) where
            g ((ls,op), _) = ls
        terminator :: LL.Terminator
        terminator = g $ compileExpression e (i+1) where
            g ((ls,op), _) = CBr op (f $ compileStatement s (generateName i) (generateName i) (generateName i) (i+1)) nextBlockLabel where
                f ((ls, s'), i') = s'

    compileStatement' (Block stmts) = (( [((generateLabel i), ((concatMap f stmts), terminator))],  (generateLabel i) ), (i+1)) where
        f :: Clike.Stmt -> [LL.Instruction]
        f s = g $ compileStatement s (generateLabel i) (generateLabel i) (generateLabel i) i where
            g ((ls, s'), i') = concatMap h ls
            h (string, (inst, term)) = inst
        terminator :: LL.Terminator
        terminator = Bra continueLabel

    compileStatement' (Decl typ s) = (([((generateName i), (instructions, terminator))], (generateName i)), i) where
        instructions :: [LL.Instruction]
        instructions = [(Alloca s I64)]
        terminator :: LL.Terminator
        terminator = Bra nextBlockLabel



{-------------------------------------------------------------------------------

compileExpression is simpler than compileStatement, because you don't have to
worry about flow of control.  You do, however, have to worry about un-nesting
nested expressions.  In the type below, the Int argument is for generating fresh
names.  The result includes the sequence of instructions used to compute the
expression, the LLVM operand containing the result of the expression, and the
updated integer after generating fresh names.  For example, suppose you had:

    compileExpression (Bin Plus (Bin Times (OpE (Const 3))
                                           (OpE (Const 5)))
                                (OpE (Const 6))
                      4

I would expect this to produce results similar to:

    (([LL.Bin "__x4" LL.Times (LL.Const 3) (LL.Const 5),
       LL.Bin "__x5" LL.Times (LL.Uid "__x4") (LL.Const 6)],
      LL.Uid "__x5"),
     6)

-------------------------------------------------------------------------------}


compileExpression :: Clike.Expr -> Int -> (([LL.Instruction], LL.Operand), Int)

compileExpression (Clike.Bin binop e1 e2) i = (( (compileInstruction), (LL.Uid $ generateName i)), (snd (compileExpression' $ compileExpression e2 ( snd (compileExpression' $ compileExpression e1 (i+1))))) ) where
    compileInstruction :: [LL.Instruction]
    compileInstruction
        | (getBinopType binop) == 1 = [(LL.Bin (generateName i) (getLLb binop) I64 ( fst (compileExpression' $ compileExpression e1 (i+1)))  (fst (compileExpression' $ compileExpression e2 ( snd (compileExpression' $ compileExpression e1 (i+1))))) )]
        | (getBinopType binop) == 2 = [( LL.Icmp (generateName i) (getLLc binop) I64 (fst (compileExpression' $ compileExpression e1 (i+1))) (fst (compileExpression' $ compileExpression e2 ( snd (compileExpression' $ compileExpression e1 (i+1))))) )]
        | (getBinopType binop) == 3 = [(LL.Bin  (f $ fst (compileExpression' $ compileExpression e1 (i+1))) LL.Add I64 (LL.Const 0) (fst (compileExpression' $ compileExpression e2 (i+1))) )]
        | otherwise = error "Shouldn't get to here"

    f (Uid s) = s
    f _ = error "Not uid" 

    getLLb :: Clike.BinOp -> LL.Operator
    getLLb ( Clike.Plus) = LL.Add
    getLLb ( Clike.Minus) = LL.Sub
    getLLb ( Clike.Times) = LL.Mul
    getLLb ( Clike.And) = LL.And
    getLLb ( Clike.Or) = LL.Or
    getLLb ( Clike.Xor) = LL.Xor
    getLLb ( Clike.Shl) = LL.Shl
    getLLb ( Clike.Lshr) = LL.Lshr
    getLLb ( Clike.Ashr) = LL.Ashr
    
    getLLc :: Clike.BinOp -> LL.Condition
    getLLc ( Clike.Eq) = LL.Eq
    getLLc ( Clike.Neq) = LL.Neq
    getLLc ( Clike.Lt) = LL.Lt
    getLLc ( Clike.Lte) = LL.Le
    getLLc ( Clike.Gt) = LL.Gt
    getLLc ( Clike.Gte) = LL.Ge

    -- 1 == LL.Bin
    -- 2 == LL.Icmp
    getBinopType :: Clike.BinOp -> Int
    getBinopType ( Clike.Plus) =  1
    getBinopType ( Clike.Minus) =  1
    getBinopType ( Clike.Times) =      1
    getBinopType ( Clike.And) =  1
    getBinopType ( Clike.Or) = 1
    getBinopType ( Clike.Xor) =  1
    getBinopType ( Clike.Shl) =  1
    getBinopType ( Clike.Lshr) =  1
    getBinopType ( Clike.Ashr) =  1
    getBinopType ( Clike.Eq) = 2
    getBinopType ( Clike.Neq) =  2
    getBinopType ( Clike.Lt) = 2
    getBinopType ( Clike.Lte) = 2
    getBinopType ( Clike.Gt) = 2
    getBinopType ( Clike.Gte) = 2
    getBinopType (Clike.Assign) = 3


compileExpression (OpE operand) i = (([], f operand), i+1) where
    f :: Clike.Operand -> LL.Operand
    f (Clike.Var string) = LL.Uid string
    f (Clike.Const int) = LL.Const int
    f (Clike.Dot operand2 string) = error "non dot operand"

compileExpression (Unary unaop e) i = ( ((compileInstruction), (LL.Uid $ generateName i)),  (snd (compileExpression' $ compileExpression e (i+1))) ) where
    compileInstruction :: [Instruction]
    compileInstruction = error "non unary expression"

compileExpression (Clike.Call string ls) i = (([(LL.Call string I64 "function" (map f ls))], (LL.Uid $ generateName i)), i+1) where
    f e = (I64, g $ (compileExpression e i))
    g ((_, op), _) = op

compileExpression' :: (([LL.Instruction], LL.Operand), Int) -> (LL.Operand, Int)
compileExpression' ((_, op), i) = (op ,i)

{-------------------------------------------------------------------------------

compileOperand has identical behavior to compileExpression.  Note that, as Clike
variables support assignment, unlike LLVM temporaries, you will need to store
your Clike variables on the stack and use Store/Load to get to them.

-------------------------------------------------------------------------------}


compileOperand :: Clike.Operand -> Int -> (([LL.Instruction], LL.Operand), Int)
compileOperand o i = (((compileInner), (LL.Uid $ generateName $ compileInnterGetUid)), (compileInnterGetUid + 1)) where

    compileInner :: [LL.Instruction]
    compileInner = error "non op"

    compileInnterGetUid :: Int
    compileInnterGetUid = error "non op"


generateName :: Int -> String
generateName i = "__x" ++ (show i)

generateLabel i = "__label__x" ++ (show i)
