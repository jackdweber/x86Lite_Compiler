module Main where

import Compiler

import Clike.Interp
import Clike.Language as Clike
import Clike.Parser
import Clike.Lexer

import qualified LL.Compiler as LL
import LL.Language
import LL.Text

import X86 as X86
import X86.Text as X86
import X86.Loader as X86
import X86.Machine as X86
import X86.Simulator as X86
import X86.SimAsm as X86

import Control.Monad
import Data.List
import System.Environment

main = llToScreen =<< getArgs

interpNoArgs inputs =
    do contents <- unlines `fmap` mapM readFile inputs
       case runAlex contents parse of
         Left err -> error err
         Right p  -> putStrLn $ show $ interp (p ++ mainFunction)
    where mainFunction = [FunDecl Int "main" [] [Return (Clike.Call "function" [])]]

interpOneArg inputs arg =
    do contents <- unlines `fmap` mapM readFile inputs
       case runAlex contents parse of
         Left err -> error err
         Right p  -> putStrLn $ show $ interp (p ++ mainFunction)
    where mainFunction = [FunDecl Int "main" [] [Return (Clike.Call "function" [OpE (Clike.Const arg)])]]

doCompile inputs =
    do contents <- unlines `fmap` mapM readFile inputs
       case runAlex contents parse of
         Left err -> error err
         Right p  -> return (compileProgram p)

llToFile inputs output =
    do ll <- doCompile inputs
       writeFile output (textOf ll)

llToScreen inputs =
    do ll <- doCompile inputs
       putStrLn (textOf ll)

asmToFile inputs output =
    do ll <- doCompile inputs
       let asm = LL.compile ll
       writeFile output (textOf asm)

asmToScreen inputs =
    do ll <- doCompile inputs
       let asm = LL.compile ll
       putStrLn (textOf asm)

traceExec watchList m =
    do putStrLn ("<" ++ show (getRIP m) ++ "> " ++ pad 30 (textOf instr) ++ " " ++ intercalate ", " [textOf op ++ " = " ++ show (getOperand op m) | op <- filter (valid m) watchList])
       let m' = step m
       if getRIP m' == haltAddr
       then putStrLn ("Finished; RAX = " ++ show (getRegister RAX m'))
       else traceExec watchList m'
    where Inst instr = getMemory (getRIP m) m
          pad n s | length s >= n = s
                  | otherwise = s ++ replicate (n - length s) ' '
          valid m (Reg _) = True
          valid m (Imm _) = True
          valid m (IndReg r) = memoryFloor <= rVal && rVal <= memoryCeiling
              where rVal = getOperand (Reg r) m
          valid m (IndImm i) = memoryFloor <= i && i <= memoryCeiling
          valid m (IndBoth i r) = memoryFloor <= rVal && rVal <= memoryCeiling
              where rVal = getOperand (Reg r) m + i
