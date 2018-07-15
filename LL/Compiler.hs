module LL.Compiler where

import Data.Int
import Data.List
import Data.Maybe

import LL.Language as LL
import X86 as X86

import Text
import X86.Text
import Debug.Trace


compile :: LL.Prog -> X86.Prog
compile p =
    compileGlobals (types p) (globals p) ++
    compileFunctions (types p) (functions p)

sizeOf :: Types -> Type -> Int64
sizeOf _ Void                    = 0
sizeOf _ I1                      = 8
sizeOf _ I8                      = 8
sizeOf _ I32                     = 8
sizeOf _ I64                     = 8
sizeOf _ (Ptr _)                 = 8
sizeOf named (Struct ts)         = sum $ map (sizeOf named) ts
sizeOf _ (Array n I8)            = n
sizeOf named (Array n (Named s)) = sizeOf named (Array n (fromJust (lookup s named)))
sizeOf named (Array n t)         = n * sizeOf named t
sizeOf _ (Fun _ _)               = 0
sizeOf named (Named s)           = sizeOf named (fromJust (lookup s named))

compileGlobals :: Types -> Globals -> X86.Prog
compileGlobals named = map (compileGlobal named)

compileGlobal named (label, _, init) = (label, True, Data (compileInit init))
    where compileInit (INull) = [Word (Literal 0)]
          compileInit (IGid label) = [Word (Label label)]
          compileInit (IInt i) = [Word (Literal i)]
          compileInit (IString s) = [String s]
          compileInit (IArray inits) = concatMap compileInit (map snd inits)
          compileInit (IStruct inits) = concatMap compileInit (map snd inits)

compileFunctions :: Types -> Functions -> X86.Prog
compileFunctions named = concatMap (compileFunction named)

argumentRegisters = [RDI, RSI, RDX, RCX, R08, R09]
-- argumentRegisters = [RCX, RDX, R08, R09]

-- You may find the following function helpful in implementing operations on temporary storage
-- locations

type TemporaryMap = [(String, X86.SourceOperand)]
temporaries :: Cfg -> [String]
temporaries (first, rest) = concatMap inBlock (first : map snd rest)
    where inBlock (instrs, _) = concatMap definedIn instrs
          definedIn (Bin res _ _ _ _)   = [res]
          definedIn (Alloca res _)      = [res]
          definedIn (Load res _ _)      = [res]
          definedIn (Store {})          = []
          definedIn (Icmp res _ _ _ _)  = [res]
          definedIn (Call res _ _ _)    = [res]
          definedIn (Bitcast res _ _ _) = [res]
          definedIn (Gep res _ _ _)     = [res]

compileFunction :: Types -> (String, Function) -> X86.Prog
compileFunction named (fname, (args, rty, cfg@(first, rest))) =
    (fname, True, Text initialBlock) : [(label, False, Text compiledBlock) | (label, compiledBlock) <- zip (map fst rest) compiledRest ]
    where tempNames = temporaries cfg
          temps = [(name, IndBoth (negate i) RBP) | (name, i) <- zip (map snd args ++ tempNames) [16,24..]] :: TemporaryMap
          spillSpace = genericLength temps * 8
          storeRegisterArguments = [ movq ~%reg ~~loc | (reg, (_, loc)) <- zip argumentRegisters (take (length args) temps) ]
          storeStackArguments = concat [ [ movq ~#(i, RBP) ~%RAX, movq ~%RAX ~~loc ] | (i, (_, loc)) <- zip [8, 16..] (take (length args - length argumentRegisters) (drop (length argumentRegisters) temps)) ]
          (compiledFirst : compiledRest) = map (compileBlock named temps) (first : map snd rest)
          initialBlock = [ pushq ~%RBP
                         , movq ~%RSP ~%RBP
                         , subq ~$spillSpace ~%RSP ] ++
                         storeRegisterArguments ++
                         storeStackArguments ++
                         compiledFirst

compileBlock :: Types -> TemporaryMap -> Block -> [X86.SourceInstr]
compileBlock named temps (instrs, term) = concatMap (compileInstr named temps) instrs ++ compileTerm temps term

compileOperand :: TemporaryMap -> LL.Operand -> X86.SourceOperand
compileOperand _ (Const i)   = Imm (Literal i)
compileOperand temps (Uid s) = fromJust (lookup s temps)
compileOperand _ (Gid s)     = IndImm (Label s)

compileInstr :: Types -> TemporaryMap -> LL.Instruction -> [X86.SourceInstr]
compileInstr named temps = doInstr
    where cOp = compileOperand temps
          cRes = cOp . Uid
          doInstr (Bin result op _ arg1 arg2)
              | isShift op =
                  [ movq ~~(cOp arg1) ~%RAX
                  , binOp ~~(cOp arg2) ~%RAX -- arg2 had better be a constant....
                  , movq ~%RAX ~~(cRes result) ]
              | otherwise =
                  [ movq ~~(cOp arg1) ~%RAX
                  , movq ~~(cOp arg2) ~%R11
                  , binOp ~%R11 ~%RAX
                  , movq ~%RAX ~~(cRes result) ]
              where isShift Shl  = True
                    isShift Lshr = True
                    isShift Ashr = True
                    isShift _    = False
                    binOp = case op of
                              Add  -> addq
                              Sub  -> subq
                              Mul  -> imulq
                              Shl  -> shlq
                              Lshr -> shrq
                              Ashr -> sarq
                              And  -> andq
                              Or   -> orq
                              Xor  -> xorq
          doInstr (Alloca result t) =
              [ subq ~$(sizeOf named t) ~%RSP
              , movq ~%RSP ~~(cRes result) ]
          doInstr (Load result _ arg) =
              [ movq ~~(cOp arg) ~%RAX
              , movq ~#RAX ~%RAX
              , movq ~%RAX ~~(cRes result) ]
          doInstr (Store _ src dst) =
              [ movq ~~(compileOperand temps src) ~%RAX
              , movq ~~(compileOperand temps dst) ~%R11
              , movq ~%RAX ~#R11 ]
          doInstr (Icmp result rel _ arg1 arg2) =
              [ movq ~~(cOp arg1) ~%RAX
              , movq ~~(cOp arg2) ~%R11
              , movq ~$0 ~~(cRes result)
              , cmpq ~%R11 ~%RAX
              , set rel ~~(cRes result) ]
          doInstr (Call result _ fname args) =
              [ movq ~~(cOp arg) ~%reg | (reg, arg) <- zip argumentRegisters (map snd args) ] ++
              pushStackArguments ++
              [ callq ~$$fname
              , movq ~%RAX ~~(cRes result) ] ++
              cleanStackArguments
              where pushStackArguments | n <= 0 = []
                                       | otherwise = (subq ~$n ~%RSP) :
                                                     concat [[ movq ~~(cOp arg) ~%RAX, movq ~%RAX ~#(negate i, RSP) ]
                                                            | (i, (_, arg)) <- zip [8, 16..] (drop (length argumentRegisters) args)]
                        where n = 8 * (genericLength args - genericLength argumentRegisters)
                    cleanStackArguments | n <= 0 = []
                                        | otherwise = [addq ~$n ~%RSP]
                        where n = 8 * (genericLength args - genericLength argumentRegisters)
          doInstr (Bitcast result _ arg _) =
              [ movq ~~(cOp arg) ~%RAX
              , movq ~%RAX ~~(cRes result) ]     -- Can't move with two indirections
          doInstr (Gep result t start path) =
              [ movq ~~(cOp start) ~%RAX ] ++
              arrayStep t path ++
              [ movq ~%RAX ~~(cRes result)]
              where steps _ [] = []
                    steps (Ptr t) p = arrayStep t p
                    steps (Array _ t) p = arrayStep t p
                    steps (Named s) p =
                        case lookup s named of
                          Nothing -> error $ "Unknown named type " ++ s ++ " in GEP; known types are " ++ intercalate ", " (map fst named)
                          Just t  -> steps t p
                    steps (Struct ts) (Const i : ps) =
                       [ addq ~$(sum (map (sizeOf named) (take (fromIntegral i) ts))) ~%RAX ] ++
                       steps (ts !! fromIntegral i) ps
                    steps (Struct _) _ = error "GEP offset into struct must be a constant"
                    steps t _ = error $ "Not sure how to step into " ++ show t ++ " in GEP"
                    arrayStep t (Const i : ps) =
                        [ addq ~$(i * sizeOf named t) ~%RAX ] ++
                        steps t ps
                    arrayStep t (op : ps) =
                        [ movq ~~(cOp op) ~%R11
                        , imulq ~$(sizeOf named t) ~%R11
                        , addq ~%R11 ~%RAX ] ++
                        steps t ps



compileTerm :: TemporaryMap -> Terminator -> [X86.SourceInstr]
compileTerm temps (Ret Void Nothing) =
    [ movq ~%RBP ~%RSP
    , popq ~%RBP
    , retq ]
compileTerm temps (Ret _ (Just result)) =
    [ movq ~~(compileOperand temps result) ~%RAX
    , movq ~%RBP ~%RSP
    , popq ~%RBP
    , retq ]
compileTerm temps (Bra label) = [ jmp ~$$label ]
compileTerm temps (CBr cond cons alt) =
    [ movq ~~(compileOperand temps cond) ~%RAX
    , cmpq ~$1 ~%RAX
    , j Eq ~$$cons
    , jmp ~$$alt ]
