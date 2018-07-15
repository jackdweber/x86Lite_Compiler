{-# OPTIONS_GHC -w #-}
module Clike.Parser where

import Clike.Language
import Clike.Lexer
import qualified Data.Array as Happy_Data_Array
import qualified Data.Bits as Bits
import Control.Applicative(Applicative(..))
import Control.Monad (ap)

-- parser produced by Happy Version 1.19.9

data HappyAbsSyn 
	= HappyTerminal (Token)
	| HappyErrorToken Int
	| HappyAbsSyn4 ([TopDecl])
	| HappyAbsSyn5 (Type)
	| HappyAbsSyn6 ([(Type, String)])
	| HappyAbsSyn7 (Expr)
	| HappyAbsSyn14 (Operand)
	| HappyAbsSyn16 ([Expr])
	| HappyAbsSyn17 ([Stmt])
	| HappyAbsSyn19 (Stmt)
	| HappyAbsSyn20 (TopDecl)

{- to allow type-synonyms as our monads (likely
 - with explicitly-specified bind and return)
 - in Haskell98, it seems that with
 - /type M a = .../, then /(HappyReduction M)/
 - is not allowed.  But Happy is a
 - code-generator that can just substitute it.
type HappyReduction m = 
	   Int 
	-> (Token)
	-> HappyState (Token) (HappyStk HappyAbsSyn -> m HappyAbsSyn)
	-> [HappyState (Token) (HappyStk HappyAbsSyn -> m HappyAbsSyn)] 
	-> HappyStk HappyAbsSyn 
	-> m HappyAbsSyn
-}

action_0,
 action_1,
 action_2,
 action_3,
 action_4,
 action_5,
 action_6,
 action_7,
 action_8,
 action_9,
 action_10,
 action_11,
 action_12,
 action_13,
 action_14,
 action_15,
 action_16,
 action_17,
 action_18,
 action_19,
 action_20,
 action_21,
 action_22,
 action_23,
 action_24,
 action_25,
 action_26,
 action_27,
 action_28,
 action_29,
 action_30,
 action_31,
 action_32,
 action_33,
 action_34,
 action_35,
 action_36,
 action_37,
 action_38,
 action_39,
 action_40,
 action_41,
 action_42,
 action_43,
 action_44,
 action_45,
 action_46,
 action_47,
 action_48,
 action_49,
 action_50,
 action_51,
 action_52,
 action_53,
 action_54,
 action_55,
 action_56,
 action_57,
 action_58,
 action_59,
 action_60,
 action_61,
 action_62,
 action_63,
 action_64,
 action_65,
 action_66,
 action_67,
 action_68,
 action_69,
 action_70,
 action_71,
 action_72,
 action_73,
 action_74,
 action_75,
 action_76,
 action_77,
 action_78,
 action_79,
 action_80,
 action_81,
 action_82,
 action_83,
 action_84,
 action_85,
 action_86,
 action_87,
 action_88,
 action_89,
 action_90,
 action_91,
 action_92,
 action_93,
 action_94,
 action_95,
 action_96,
 action_97,
 action_98,
 action_99,
 action_100,
 action_101,
 action_102,
 action_103,
 action_104,
 action_105,
 action_106,
 action_107,
 action_108,
 action_109,
 action_110,
 action_111,
 action_112,
 action_113 :: () => Int -> ({-HappyReduction (Alex) = -}
	   Int 
	-> (Token)
	-> HappyState (Token) (HappyStk HappyAbsSyn -> (Alex) HappyAbsSyn)
	-> [HappyState (Token) (HappyStk HappyAbsSyn -> (Alex) HappyAbsSyn)] 
	-> HappyStk HappyAbsSyn 
	-> (Alex) HappyAbsSyn)

happyReduce_1,
 happyReduce_2,
 happyReduce_3,
 happyReduce_4,
 happyReduce_5,
 happyReduce_6,
 happyReduce_7,
 happyReduce_8,
 happyReduce_9,
 happyReduce_10,
 happyReduce_11,
 happyReduce_12,
 happyReduce_13,
 happyReduce_14,
 happyReduce_15,
 happyReduce_16,
 happyReduce_17,
 happyReduce_18,
 happyReduce_19,
 happyReduce_20,
 happyReduce_21,
 happyReduce_22,
 happyReduce_23,
 happyReduce_24,
 happyReduce_25,
 happyReduce_26,
 happyReduce_27,
 happyReduce_28,
 happyReduce_29,
 happyReduce_30,
 happyReduce_31,
 happyReduce_32,
 happyReduce_33,
 happyReduce_34,
 happyReduce_35,
 happyReduce_36,
 happyReduce_37,
 happyReduce_38,
 happyReduce_39,
 happyReduce_40,
 happyReduce_41,
 happyReduce_42,
 happyReduce_43,
 happyReduce_44,
 happyReduce_45,
 happyReduce_46,
 happyReduce_47,
 happyReduce_48,
 happyReduce_49,
 happyReduce_50,
 happyReduce_51,
 happyReduce_52,
 happyReduce_53,
 happyReduce_54,
 happyReduce_55 :: () => ({-HappyReduction (Alex) = -}
	   Int 
	-> (Token)
	-> HappyState (Token) (HappyStk HappyAbsSyn -> (Alex) HappyAbsSyn)
	-> [HappyState (Token) (HappyStk HappyAbsSyn -> (Alex) HappyAbsSyn)] 
	-> HappyStk HappyAbsSyn 
	-> (Alex) HappyAbsSyn)

happyExpList :: Happy_Data_Array.Array Int Int
happyExpList = Happy_Data_Array.listArray (0,368) ([0,0,24576,0,0,0,96,0,0,0,32,0,0,0,0,0,0,0,16384,0,0,0,0,0,0,0,0,96,0,0,0,0,0,0,96,0,16,0,0,0,0,96,0,0,0,32,32768,8,0,0,0,0,0,0,0,96,0,0,0,0,8192,8,0,0,64,0,0,0,0,8192,0,0,0,0,20480,40960,32480,0,0,0,32,0,16,0,0,0,0,0,0,0,2,0,0,256,0,0,4032,0,0,0,7168,0,0,12288,0,0,8448,0,0,0,16384,0,0,0,0,0,53248,40960,32480,0,0,0,0,4096,40960,24576,0,80,57504,126,4096,40960,24576,0,16,160,96,4096,0,0,0,16,0,0,0,16,0,0,4096,0,0,4096,40960,24576,0,16,0,0,0,0,0,0,16,160,96,0,16,0,0,0,0,0,0,0,0,0,16,160,96,4096,40960,24576,0,256,0,0,0,0,0,0,0,0,0,53248,40960,32480,0,32,0,0,0,0,0,0,0,0,0,4096,40960,24576,0,16,160,96,0,0,8192,0,16,160,96,4096,40960,24576,0,16,160,96,4096,40960,24576,0,16,160,96,4096,40960,24576,0,16,160,96,4096,40960,24576,0,16,160,96,4096,40960,24576,0,16,160,96,4096,40960,24576,0,16,160,96,4096,40960,24576,0,16,160,96,0,0,0,0,4096,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,32,0,0,8192,0,0,0,0,0,0,0,0,0,0,2080,0,0,0,0,0,0,16,160,96,20480,40960,32480,0,80,57504,126,0,0,0,0,0,0,0,0,0,0,0,80,57504,126,0,0,0,0
	])

{-# NOINLINE happyExpListPerState #-}
happyExpListPerState st =
    token_strs_expected
  where token_strs = ["error","%dummy","%start_parse","prog","typ","params","asgne","ore","ande","compe","shifte","adde","mule","path","atome","args","block","stmts","stmt","fundecl","'('","')'","'{'","'}'","'.'","'?'","':'","','","';'","'='","'=='","'!='","'<'","'<='","'>'","'>='","'+'","'-'","'*'","'~'","'&'","'|'","'<<'","'>>'","'>>>'","'int'","'struct'","'if'","'else'","'while'","'break'","'continue'","'return'","id","number","%eof"]
        bit_start = st * 56
        bit_end = (st + 1) * 56
        read_bit = readArrayBit happyExpList
        bits = map read_bit [bit_start..bit_end - 1]
        bits_indexed = zip bits [0..55]
        token_strs_expected = concatMap f bits_indexed
        f (False, _) = []
        f (True, nr) = [token_strs !! nr]

action_0 (46) = happyShift action_4
action_0 (47) = happyShift action_5
action_0 (4) = happyGoto action_6
action_0 (5) = happyGoto action_2
action_0 (20) = happyGoto action_7
action_0 _ = happyFail (happyExpListPerState 0)

action_1 (46) = happyShift action_4
action_1 (47) = happyShift action_5
action_1 (5) = happyGoto action_2
action_1 (20) = happyGoto action_3
action_1 _ = happyFail (happyExpListPerState 1)

action_2 (54) = happyShift action_10
action_2 _ = happyFail (happyExpListPerState 2)

action_3 _ = happyFail (happyExpListPerState 3)

action_4 _ = happyReduce_3

action_5 (23) = happyShift action_9
action_5 _ = happyFail (happyExpListPerState 5)

action_6 (56) = happyAccept
action_6 _ = happyFail (happyExpListPerState 6)

action_7 (46) = happyShift action_4
action_7 (47) = happyShift action_5
action_7 (4) = happyGoto action_8
action_7 (5) = happyGoto action_2
action_7 (20) = happyGoto action_7
action_7 _ = happyReduce_1

action_8 _ = happyReduce_2

action_9 (46) = happyShift action_4
action_9 (47) = happyShift action_5
action_9 (5) = happyGoto action_12
action_9 (6) = happyGoto action_13
action_9 _ = happyReduce_7

action_10 (21) = happyShift action_11
action_10 _ = happyFail (happyExpListPerState 10)

action_11 (46) = happyShift action_4
action_11 (47) = happyShift action_5
action_11 (5) = happyGoto action_12
action_11 (6) = happyGoto action_17
action_11 _ = happyReduce_7

action_12 (54) = happyShift action_16
action_12 _ = happyFail (happyExpListPerState 12)

action_13 (24) = happyShift action_14
action_13 (28) = happyShift action_15
action_13 _ = happyFail (happyExpListPerState 13)

action_14 _ = happyReduce_4

action_15 (46) = happyShift action_4
action_15 (47) = happyShift action_5
action_15 (5) = happyGoto action_19
action_15 _ = happyFail (happyExpListPerState 15)

action_16 _ = happyReduce_6

action_17 (22) = happyShift action_18
action_17 (28) = happyShift action_15
action_17 _ = happyFail (happyExpListPerState 17)

action_18 (23) = happyShift action_21
action_18 _ = happyFail (happyExpListPerState 18)

action_19 (54) = happyShift action_20
action_19 _ = happyFail (happyExpListPerState 19)

action_20 _ = happyReduce_5

action_21 (21) = happyShift action_35
action_21 (23) = happyShift action_36
action_21 (38) = happyShift action_37
action_21 (40) = happyShift action_38
action_21 (46) = happyShift action_4
action_21 (47) = happyShift action_5
action_21 (48) = happyShift action_39
action_21 (50) = happyShift action_40
action_21 (51) = happyShift action_41
action_21 (52) = happyShift action_42
action_21 (53) = happyShift action_43
action_21 (54) = happyShift action_44
action_21 (55) = happyShift action_45
action_21 (5) = happyGoto action_22
action_21 (7) = happyGoto action_23
action_21 (8) = happyGoto action_24
action_21 (9) = happyGoto action_25
action_21 (10) = happyGoto action_26
action_21 (11) = happyGoto action_27
action_21 (12) = happyGoto action_28
action_21 (13) = happyGoto action_29
action_21 (14) = happyGoto action_30
action_21 (15) = happyGoto action_31
action_21 (17) = happyGoto action_32
action_21 (18) = happyGoto action_33
action_21 (19) = happyGoto action_34
action_21 _ = happyFail (happyExpListPerState 21)

action_22 (54) = happyShift action_78
action_22 _ = happyFail (happyExpListPerState 22)

action_23 (29) = happyShift action_77
action_23 _ = happyFail (happyExpListPerState 23)

action_24 _ = happyReduce_9

action_25 (42) = happyShift action_76
action_25 _ = happyReduce_11

action_26 (41) = happyShift action_75
action_26 _ = happyReduce_13

action_27 (31) = happyShift action_69
action_27 (32) = happyShift action_70
action_27 (33) = happyShift action_71
action_27 (34) = happyShift action_72
action_27 (35) = happyShift action_73
action_27 (36) = happyShift action_74
action_27 _ = happyReduce_20

action_28 (43) = happyShift action_66
action_28 (44) = happyShift action_67
action_28 (45) = happyShift action_68
action_28 _ = happyReduce_24

action_29 (37) = happyShift action_63
action_29 (38) = happyShift action_64
action_29 (42) = happyShift action_65
action_29 _ = happyReduce_28

action_30 (25) = happyShift action_61
action_30 (30) = happyShift action_62
action_30 _ = happyReduce_39

action_31 (39) = happyShift action_59
action_31 (41) = happyShift action_60
action_31 _ = happyReduce_31

action_32 _ = happyReduce_46

action_33 (21) = happyShift action_35
action_33 (23) = happyShift action_36
action_33 (24) = happyShift action_58
action_33 (38) = happyShift action_37
action_33 (40) = happyShift action_38
action_33 (46) = happyShift action_4
action_33 (47) = happyShift action_5
action_33 (48) = happyShift action_39
action_33 (50) = happyShift action_40
action_33 (51) = happyShift action_41
action_33 (52) = happyShift action_42
action_33 (53) = happyShift action_43
action_33 (54) = happyShift action_44
action_33 (55) = happyShift action_45
action_33 (5) = happyGoto action_22
action_33 (7) = happyGoto action_23
action_33 (8) = happyGoto action_24
action_33 (9) = happyGoto action_25
action_33 (10) = happyGoto action_26
action_33 (11) = happyGoto action_27
action_33 (12) = happyGoto action_28
action_33 (13) = happyGoto action_29
action_33 (14) = happyGoto action_30
action_33 (15) = happyGoto action_31
action_33 (17) = happyGoto action_32
action_33 (19) = happyGoto action_57
action_33 _ = happyFail (happyExpListPerState 33)

action_34 _ = happyReduce_45

action_35 (21) = happyShift action_35
action_35 (38) = happyShift action_37
action_35 (40) = happyShift action_38
action_35 (54) = happyShift action_44
action_35 (55) = happyShift action_45
action_35 (7) = happyGoto action_56
action_35 (8) = happyGoto action_24
action_35 (9) = happyGoto action_25
action_35 (10) = happyGoto action_26
action_35 (11) = happyGoto action_27
action_35 (12) = happyGoto action_28
action_35 (13) = happyGoto action_29
action_35 (14) = happyGoto action_30
action_35 (15) = happyGoto action_31
action_35 _ = happyFail (happyExpListPerState 35)

action_36 (21) = happyShift action_35
action_36 (23) = happyShift action_36
action_36 (38) = happyShift action_37
action_36 (40) = happyShift action_38
action_36 (46) = happyShift action_4
action_36 (47) = happyShift action_5
action_36 (48) = happyShift action_39
action_36 (50) = happyShift action_40
action_36 (51) = happyShift action_41
action_36 (52) = happyShift action_42
action_36 (53) = happyShift action_43
action_36 (54) = happyShift action_44
action_36 (55) = happyShift action_45
action_36 (5) = happyGoto action_22
action_36 (7) = happyGoto action_23
action_36 (8) = happyGoto action_24
action_36 (9) = happyGoto action_25
action_36 (10) = happyGoto action_26
action_36 (11) = happyGoto action_27
action_36 (12) = happyGoto action_28
action_36 (13) = happyGoto action_29
action_36 (14) = happyGoto action_30
action_36 (15) = happyGoto action_31
action_36 (17) = happyGoto action_32
action_36 (18) = happyGoto action_55
action_36 (19) = happyGoto action_34
action_36 _ = happyFail (happyExpListPerState 36)

action_37 (21) = happyShift action_35
action_37 (38) = happyShift action_37
action_37 (40) = happyShift action_38
action_37 (54) = happyShift action_44
action_37 (55) = happyShift action_45
action_37 (14) = happyGoto action_52
action_37 (15) = happyGoto action_54
action_37 _ = happyFail (happyExpListPerState 37)

action_38 (21) = happyShift action_35
action_38 (38) = happyShift action_37
action_38 (40) = happyShift action_38
action_38 (54) = happyShift action_44
action_38 (55) = happyShift action_45
action_38 (14) = happyGoto action_52
action_38 (15) = happyGoto action_53
action_38 _ = happyFail (happyExpListPerState 38)

action_39 (21) = happyShift action_51
action_39 _ = happyFail (happyExpListPerState 39)

action_40 (21) = happyShift action_50
action_40 _ = happyFail (happyExpListPerState 40)

action_41 (29) = happyShift action_49
action_41 _ = happyFail (happyExpListPerState 41)

action_42 (29) = happyShift action_48
action_42 _ = happyFail (happyExpListPerState 42)

action_43 (21) = happyShift action_35
action_43 (38) = happyShift action_37
action_43 (40) = happyShift action_38
action_43 (54) = happyShift action_44
action_43 (55) = happyShift action_45
action_43 (7) = happyGoto action_47
action_43 (8) = happyGoto action_24
action_43 (9) = happyGoto action_25
action_43 (10) = happyGoto action_26
action_43 (11) = happyGoto action_27
action_43 (12) = happyGoto action_28
action_43 (13) = happyGoto action_29
action_43 (14) = happyGoto action_30
action_43 (15) = happyGoto action_31
action_43 _ = happyFail (happyExpListPerState 43)

action_44 (21) = happyShift action_46
action_44 _ = happyReduce_33

action_45 _ = happyReduce_38

action_46 (21) = happyShift action_35
action_46 (38) = happyShift action_37
action_46 (40) = happyShift action_38
action_46 (54) = happyShift action_44
action_46 (55) = happyShift action_45
action_46 (7) = happyGoto action_103
action_46 (8) = happyGoto action_24
action_46 (9) = happyGoto action_25
action_46 (10) = happyGoto action_26
action_46 (11) = happyGoto action_27
action_46 (12) = happyGoto action_28
action_46 (13) = happyGoto action_29
action_46 (14) = happyGoto action_30
action_46 (15) = happyGoto action_31
action_46 (16) = happyGoto action_104
action_46 _ = happyReduce_42

action_47 (29) = happyShift action_102
action_47 _ = happyFail (happyExpListPerState 47)

action_48 _ = happyReduce_51

action_49 _ = happyReduce_50

action_50 (21) = happyShift action_35
action_50 (38) = happyShift action_37
action_50 (40) = happyShift action_38
action_50 (54) = happyShift action_44
action_50 (55) = happyShift action_45
action_50 (7) = happyGoto action_101
action_50 (8) = happyGoto action_24
action_50 (9) = happyGoto action_25
action_50 (10) = happyGoto action_26
action_50 (11) = happyGoto action_27
action_50 (12) = happyGoto action_28
action_50 (13) = happyGoto action_29
action_50 (14) = happyGoto action_30
action_50 (15) = happyGoto action_31
action_50 _ = happyFail (happyExpListPerState 50)

action_51 (21) = happyShift action_35
action_51 (38) = happyShift action_37
action_51 (40) = happyShift action_38
action_51 (54) = happyShift action_44
action_51 (55) = happyShift action_45
action_51 (7) = happyGoto action_100
action_51 (8) = happyGoto action_24
action_51 (9) = happyGoto action_25
action_51 (10) = happyGoto action_26
action_51 (11) = happyGoto action_27
action_51 (12) = happyGoto action_28
action_51 (13) = happyGoto action_29
action_51 (14) = happyGoto action_30
action_51 (15) = happyGoto action_31
action_51 _ = happyFail (happyExpListPerState 51)

action_52 (25) = happyShift action_61
action_52 _ = happyReduce_39

action_53 _ = happyReduce_36

action_54 _ = happyReduce_35

action_55 (21) = happyShift action_35
action_55 (23) = happyShift action_36
action_55 (24) = happyShift action_99
action_55 (38) = happyShift action_37
action_55 (40) = happyShift action_38
action_55 (46) = happyShift action_4
action_55 (47) = happyShift action_5
action_55 (48) = happyShift action_39
action_55 (50) = happyShift action_40
action_55 (51) = happyShift action_41
action_55 (52) = happyShift action_42
action_55 (53) = happyShift action_43
action_55 (54) = happyShift action_44
action_55 (55) = happyShift action_45
action_55 (5) = happyGoto action_22
action_55 (7) = happyGoto action_23
action_55 (8) = happyGoto action_24
action_55 (9) = happyGoto action_25
action_55 (10) = happyGoto action_26
action_55 (11) = happyGoto action_27
action_55 (12) = happyGoto action_28
action_55 (13) = happyGoto action_29
action_55 (14) = happyGoto action_30
action_55 (15) = happyGoto action_31
action_55 (17) = happyGoto action_32
action_55 (19) = happyGoto action_57
action_55 _ = happyFail (happyExpListPerState 55)

action_56 (22) = happyShift action_98
action_56 _ = happyFail (happyExpListPerState 56)

action_57 _ = happyReduce_44

action_58 _ = happyReduce_55

action_59 (21) = happyShift action_35
action_59 (38) = happyShift action_37
action_59 (40) = happyShift action_38
action_59 (54) = happyShift action_44
action_59 (55) = happyShift action_45
action_59 (13) = happyGoto action_97
action_59 (14) = happyGoto action_52
action_59 (15) = happyGoto action_31
action_59 _ = happyFail (happyExpListPerState 59)

action_60 (21) = happyShift action_35
action_60 (38) = happyShift action_37
action_60 (40) = happyShift action_38
action_60 (54) = happyShift action_44
action_60 (55) = happyShift action_45
action_60 (13) = happyGoto action_96
action_60 (14) = happyGoto action_52
action_60 (15) = happyGoto action_31
action_60 _ = happyFail (happyExpListPerState 60)

action_61 (54) = happyShift action_95
action_61 _ = happyFail (happyExpListPerState 61)

action_62 (21) = happyShift action_35
action_62 (38) = happyShift action_37
action_62 (40) = happyShift action_38
action_62 (54) = happyShift action_44
action_62 (55) = happyShift action_45
action_62 (7) = happyGoto action_94
action_62 (8) = happyGoto action_24
action_62 (9) = happyGoto action_25
action_62 (10) = happyGoto action_26
action_62 (11) = happyGoto action_27
action_62 (12) = happyGoto action_28
action_62 (13) = happyGoto action_29
action_62 (14) = happyGoto action_30
action_62 (15) = happyGoto action_31
action_62 _ = happyFail (happyExpListPerState 62)

action_63 (21) = happyShift action_35
action_63 (38) = happyShift action_37
action_63 (40) = happyShift action_38
action_63 (54) = happyShift action_44
action_63 (55) = happyShift action_45
action_63 (12) = happyGoto action_93
action_63 (13) = happyGoto action_29
action_63 (14) = happyGoto action_52
action_63 (15) = happyGoto action_31
action_63 _ = happyFail (happyExpListPerState 63)

action_64 (21) = happyShift action_35
action_64 (38) = happyShift action_37
action_64 (40) = happyShift action_38
action_64 (54) = happyShift action_44
action_64 (55) = happyShift action_45
action_64 (12) = happyGoto action_92
action_64 (13) = happyGoto action_29
action_64 (14) = happyGoto action_52
action_64 (15) = happyGoto action_31
action_64 _ = happyFail (happyExpListPerState 64)

action_65 (21) = happyShift action_35
action_65 (38) = happyShift action_37
action_65 (40) = happyShift action_38
action_65 (54) = happyShift action_44
action_65 (55) = happyShift action_45
action_65 (12) = happyGoto action_91
action_65 (13) = happyGoto action_29
action_65 (14) = happyGoto action_52
action_65 (15) = happyGoto action_31
action_65 _ = happyFail (happyExpListPerState 65)

action_66 (21) = happyShift action_35
action_66 (38) = happyShift action_37
action_66 (40) = happyShift action_38
action_66 (54) = happyShift action_44
action_66 (55) = happyShift action_45
action_66 (11) = happyGoto action_90
action_66 (12) = happyGoto action_28
action_66 (13) = happyGoto action_29
action_66 (14) = happyGoto action_52
action_66 (15) = happyGoto action_31
action_66 _ = happyFail (happyExpListPerState 66)

action_67 (21) = happyShift action_35
action_67 (38) = happyShift action_37
action_67 (40) = happyShift action_38
action_67 (54) = happyShift action_44
action_67 (55) = happyShift action_45
action_67 (11) = happyGoto action_89
action_67 (12) = happyGoto action_28
action_67 (13) = happyGoto action_29
action_67 (14) = happyGoto action_52
action_67 (15) = happyGoto action_31
action_67 _ = happyFail (happyExpListPerState 67)

action_68 (21) = happyShift action_35
action_68 (38) = happyShift action_37
action_68 (40) = happyShift action_38
action_68 (54) = happyShift action_44
action_68 (55) = happyShift action_45
action_68 (11) = happyGoto action_88
action_68 (12) = happyGoto action_28
action_68 (13) = happyGoto action_29
action_68 (14) = happyGoto action_52
action_68 (15) = happyGoto action_31
action_68 _ = happyFail (happyExpListPerState 68)

action_69 (21) = happyShift action_35
action_69 (38) = happyShift action_37
action_69 (40) = happyShift action_38
action_69 (54) = happyShift action_44
action_69 (55) = happyShift action_45
action_69 (10) = happyGoto action_87
action_69 (11) = happyGoto action_27
action_69 (12) = happyGoto action_28
action_69 (13) = happyGoto action_29
action_69 (14) = happyGoto action_52
action_69 (15) = happyGoto action_31
action_69 _ = happyFail (happyExpListPerState 69)

action_70 (21) = happyShift action_35
action_70 (38) = happyShift action_37
action_70 (40) = happyShift action_38
action_70 (54) = happyShift action_44
action_70 (55) = happyShift action_45
action_70 (10) = happyGoto action_86
action_70 (11) = happyGoto action_27
action_70 (12) = happyGoto action_28
action_70 (13) = happyGoto action_29
action_70 (14) = happyGoto action_52
action_70 (15) = happyGoto action_31
action_70 _ = happyFail (happyExpListPerState 70)

action_71 (21) = happyShift action_35
action_71 (38) = happyShift action_37
action_71 (40) = happyShift action_38
action_71 (54) = happyShift action_44
action_71 (55) = happyShift action_45
action_71 (10) = happyGoto action_85
action_71 (11) = happyGoto action_27
action_71 (12) = happyGoto action_28
action_71 (13) = happyGoto action_29
action_71 (14) = happyGoto action_52
action_71 (15) = happyGoto action_31
action_71 _ = happyFail (happyExpListPerState 71)

action_72 (21) = happyShift action_35
action_72 (38) = happyShift action_37
action_72 (40) = happyShift action_38
action_72 (54) = happyShift action_44
action_72 (55) = happyShift action_45
action_72 (10) = happyGoto action_84
action_72 (11) = happyGoto action_27
action_72 (12) = happyGoto action_28
action_72 (13) = happyGoto action_29
action_72 (14) = happyGoto action_52
action_72 (15) = happyGoto action_31
action_72 _ = happyFail (happyExpListPerState 72)

action_73 (21) = happyShift action_35
action_73 (38) = happyShift action_37
action_73 (40) = happyShift action_38
action_73 (54) = happyShift action_44
action_73 (55) = happyShift action_45
action_73 (10) = happyGoto action_83
action_73 (11) = happyGoto action_27
action_73 (12) = happyGoto action_28
action_73 (13) = happyGoto action_29
action_73 (14) = happyGoto action_52
action_73 (15) = happyGoto action_31
action_73 _ = happyFail (happyExpListPerState 73)

action_74 (21) = happyShift action_35
action_74 (38) = happyShift action_37
action_74 (40) = happyShift action_38
action_74 (54) = happyShift action_44
action_74 (55) = happyShift action_45
action_74 (10) = happyGoto action_82
action_74 (11) = happyGoto action_27
action_74 (12) = happyGoto action_28
action_74 (13) = happyGoto action_29
action_74 (14) = happyGoto action_52
action_74 (15) = happyGoto action_31
action_74 _ = happyFail (happyExpListPerState 74)

action_75 (21) = happyShift action_35
action_75 (38) = happyShift action_37
action_75 (40) = happyShift action_38
action_75 (54) = happyShift action_44
action_75 (55) = happyShift action_45
action_75 (9) = happyGoto action_81
action_75 (10) = happyGoto action_26
action_75 (11) = happyGoto action_27
action_75 (12) = happyGoto action_28
action_75 (13) = happyGoto action_29
action_75 (14) = happyGoto action_52
action_75 (15) = happyGoto action_31
action_75 _ = happyFail (happyExpListPerState 75)

action_76 (21) = happyShift action_35
action_76 (38) = happyShift action_37
action_76 (40) = happyShift action_38
action_76 (54) = happyShift action_44
action_76 (55) = happyShift action_45
action_76 (8) = happyGoto action_80
action_76 (9) = happyGoto action_25
action_76 (10) = happyGoto action_26
action_76 (11) = happyGoto action_27
action_76 (12) = happyGoto action_28
action_76 (13) = happyGoto action_29
action_76 (14) = happyGoto action_52
action_76 (15) = happyGoto action_31
action_76 _ = happyFail (happyExpListPerState 76)

action_77 _ = happyReduce_54

action_78 (29) = happyShift action_79
action_78 _ = happyFail (happyExpListPerState 78)

action_79 _ = happyReduce_53

action_80 _ = happyReduce_10

action_81 _ = happyReduce_12

action_82 _ = happyReduce_19

action_83 _ = happyReduce_18

action_84 _ = happyReduce_15

action_85 _ = happyReduce_14

action_86 _ = happyReduce_17

action_87 _ = happyReduce_16

action_88 _ = happyReduce_23

action_89 _ = happyReduce_22

action_90 _ = happyReduce_21

action_91 _ = happyReduce_27

action_92 _ = happyReduce_26

action_93 _ = happyReduce_25

action_94 _ = happyReduce_8

action_95 _ = happyReduce_32

action_96 _ = happyReduce_30

action_97 _ = happyReduce_29

action_98 _ = happyReduce_34

action_99 _ = happyReduce_43

action_100 (22) = happyShift action_108
action_100 _ = happyFail (happyExpListPerState 100)

action_101 (22) = happyShift action_107
action_101 _ = happyFail (happyExpListPerState 101)

action_102 _ = happyReduce_52

action_103 _ = happyReduce_41

action_104 (22) = happyShift action_105
action_104 (28) = happyShift action_106
action_104 _ = happyFail (happyExpListPerState 104)

action_105 _ = happyReduce_37

action_106 (21) = happyShift action_35
action_106 (38) = happyShift action_37
action_106 (40) = happyShift action_38
action_106 (54) = happyShift action_44
action_106 (55) = happyShift action_45
action_106 (7) = happyGoto action_111
action_106 (8) = happyGoto action_24
action_106 (9) = happyGoto action_25
action_106 (10) = happyGoto action_26
action_106 (11) = happyGoto action_27
action_106 (12) = happyGoto action_28
action_106 (13) = happyGoto action_29
action_106 (14) = happyGoto action_30
action_106 (15) = happyGoto action_31
action_106 _ = happyFail (happyExpListPerState 106)

action_107 (21) = happyShift action_35
action_107 (23) = happyShift action_36
action_107 (38) = happyShift action_37
action_107 (40) = happyShift action_38
action_107 (46) = happyShift action_4
action_107 (47) = happyShift action_5
action_107 (48) = happyShift action_39
action_107 (50) = happyShift action_40
action_107 (51) = happyShift action_41
action_107 (52) = happyShift action_42
action_107 (53) = happyShift action_43
action_107 (54) = happyShift action_44
action_107 (55) = happyShift action_45
action_107 (5) = happyGoto action_22
action_107 (7) = happyGoto action_23
action_107 (8) = happyGoto action_24
action_107 (9) = happyGoto action_25
action_107 (10) = happyGoto action_26
action_107 (11) = happyGoto action_27
action_107 (12) = happyGoto action_28
action_107 (13) = happyGoto action_29
action_107 (14) = happyGoto action_30
action_107 (15) = happyGoto action_31
action_107 (17) = happyGoto action_32
action_107 (19) = happyGoto action_110
action_107 _ = happyFail (happyExpListPerState 107)

action_108 (21) = happyShift action_35
action_108 (23) = happyShift action_36
action_108 (38) = happyShift action_37
action_108 (40) = happyShift action_38
action_108 (46) = happyShift action_4
action_108 (47) = happyShift action_5
action_108 (48) = happyShift action_39
action_108 (50) = happyShift action_40
action_108 (51) = happyShift action_41
action_108 (52) = happyShift action_42
action_108 (53) = happyShift action_43
action_108 (54) = happyShift action_44
action_108 (55) = happyShift action_45
action_108 (5) = happyGoto action_22
action_108 (7) = happyGoto action_23
action_108 (8) = happyGoto action_24
action_108 (9) = happyGoto action_25
action_108 (10) = happyGoto action_26
action_108 (11) = happyGoto action_27
action_108 (12) = happyGoto action_28
action_108 (13) = happyGoto action_29
action_108 (14) = happyGoto action_30
action_108 (15) = happyGoto action_31
action_108 (17) = happyGoto action_32
action_108 (19) = happyGoto action_109
action_108 _ = happyFail (happyExpListPerState 108)

action_109 (49) = happyShift action_112
action_109 _ = happyReduce_48

action_110 _ = happyReduce_49

action_111 _ = happyReduce_40

action_112 (21) = happyShift action_35
action_112 (23) = happyShift action_36
action_112 (38) = happyShift action_37
action_112 (40) = happyShift action_38
action_112 (46) = happyShift action_4
action_112 (47) = happyShift action_5
action_112 (48) = happyShift action_39
action_112 (50) = happyShift action_40
action_112 (51) = happyShift action_41
action_112 (52) = happyShift action_42
action_112 (53) = happyShift action_43
action_112 (54) = happyShift action_44
action_112 (55) = happyShift action_45
action_112 (5) = happyGoto action_22
action_112 (7) = happyGoto action_23
action_112 (8) = happyGoto action_24
action_112 (9) = happyGoto action_25
action_112 (10) = happyGoto action_26
action_112 (11) = happyGoto action_27
action_112 (12) = happyGoto action_28
action_112 (13) = happyGoto action_29
action_112 (14) = happyGoto action_30
action_112 (15) = happyGoto action_31
action_112 (17) = happyGoto action_32
action_112 (19) = happyGoto action_113
action_112 _ = happyFail (happyExpListPerState 112)

action_113 _ = happyReduce_47

happyReduce_1 = happySpecReduce_1  4 happyReduction_1
happyReduction_1 (HappyAbsSyn20  happy_var_1)
	 =  HappyAbsSyn4
		 ([happy_var_1]
	)
happyReduction_1 _  = notHappyAtAll 

happyReduce_2 = happySpecReduce_2  4 happyReduction_2
happyReduction_2 (HappyAbsSyn4  happy_var_2)
	(HappyAbsSyn20  happy_var_1)
	 =  HappyAbsSyn4
		 (happy_var_1 : happy_var_2
	)
happyReduction_2 _ _  = notHappyAtAll 

happyReduce_3 = happySpecReduce_1  5 happyReduction_3
happyReduction_3 _
	 =  HappyAbsSyn5
		 (Int
	)

happyReduce_4 = happyReduce 4 5 happyReduction_4
happyReduction_4 (_ `HappyStk`
	(HappyAbsSyn6  happy_var_3) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn5
		 (Struct (reverse happy_var_3)
	) `HappyStk` happyRest

happyReduce_5 = happyReduce 4 6 happyReduction_5
happyReduction_5 ((HappyTerminal (TokID happy_var_4)) `HappyStk`
	(HappyAbsSyn5  happy_var_3) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn6  happy_var_1) `HappyStk`
	happyRest)
	 = HappyAbsSyn6
		 ((happy_var_3, happy_var_4) : happy_var_1
	) `HappyStk` happyRest

happyReduce_6 = happySpecReduce_2  6 happyReduction_6
happyReduction_6 (HappyTerminal (TokID happy_var_2))
	(HappyAbsSyn5  happy_var_1)
	 =  HappyAbsSyn6
		 ([(happy_var_1, happy_var_2)]
	)
happyReduction_6 _ _  = notHappyAtAll 

happyReduce_7 = happySpecReduce_0  6 happyReduction_7
happyReduction_7  =  HappyAbsSyn6
		 ([]
	)

happyReduce_8 = happySpecReduce_3  7 happyReduction_8
happyReduction_8 (HappyAbsSyn7  happy_var_3)
	_
	(HappyAbsSyn14  happy_var_1)
	 =  HappyAbsSyn7
		 (Bin Assign (OpE happy_var_1) happy_var_3
	)
happyReduction_8 _ _ _  = notHappyAtAll 

happyReduce_9 = happySpecReduce_1  7 happyReduction_9
happyReduction_9 (HappyAbsSyn7  happy_var_1)
	 =  HappyAbsSyn7
		 (happy_var_1
	)
happyReduction_9 _  = notHappyAtAll 

happyReduce_10 = happySpecReduce_3  8 happyReduction_10
happyReduction_10 (HappyAbsSyn7  happy_var_3)
	_
	(HappyAbsSyn7  happy_var_1)
	 =  HappyAbsSyn7
		 (Bin Or happy_var_1 happy_var_3
	)
happyReduction_10 _ _ _  = notHappyAtAll 

happyReduce_11 = happySpecReduce_1  8 happyReduction_11
happyReduction_11 (HappyAbsSyn7  happy_var_1)
	 =  HappyAbsSyn7
		 (happy_var_1
	)
happyReduction_11 _  = notHappyAtAll 

happyReduce_12 = happySpecReduce_3  9 happyReduction_12
happyReduction_12 (HappyAbsSyn7  happy_var_3)
	_
	(HappyAbsSyn7  happy_var_1)
	 =  HappyAbsSyn7
		 (Bin And happy_var_1 happy_var_3
	)
happyReduction_12 _ _ _  = notHappyAtAll 

happyReduce_13 = happySpecReduce_1  9 happyReduction_13
happyReduction_13 (HappyAbsSyn7  happy_var_1)
	 =  HappyAbsSyn7
		 (happy_var_1
	)
happyReduction_13 _  = notHappyAtAll 

happyReduce_14 = happySpecReduce_3  10 happyReduction_14
happyReduction_14 (HappyAbsSyn7  happy_var_3)
	_
	(HappyAbsSyn7  happy_var_1)
	 =  HappyAbsSyn7
		 (Bin Lt  happy_var_1 happy_var_3
	)
happyReduction_14 _ _ _  = notHappyAtAll 

happyReduce_15 = happySpecReduce_3  10 happyReduction_15
happyReduction_15 (HappyAbsSyn7  happy_var_3)
	_
	(HappyAbsSyn7  happy_var_1)
	 =  HappyAbsSyn7
		 (Bin Lte happy_var_1 happy_var_3
	)
happyReduction_15 _ _ _  = notHappyAtAll 

happyReduce_16 = happySpecReduce_3  10 happyReduction_16
happyReduction_16 (HappyAbsSyn7  happy_var_3)
	_
	(HappyAbsSyn7  happy_var_1)
	 =  HappyAbsSyn7
		 (Bin Eq  happy_var_1 happy_var_3
	)
happyReduction_16 _ _ _  = notHappyAtAll 

happyReduce_17 = happySpecReduce_3  10 happyReduction_17
happyReduction_17 (HappyAbsSyn7  happy_var_3)
	_
	(HappyAbsSyn7  happy_var_1)
	 =  HappyAbsSyn7
		 (Bin Neq happy_var_1 happy_var_3
	)
happyReduction_17 _ _ _  = notHappyAtAll 

happyReduce_18 = happySpecReduce_3  10 happyReduction_18
happyReduction_18 (HappyAbsSyn7  happy_var_3)
	_
	(HappyAbsSyn7  happy_var_1)
	 =  HappyAbsSyn7
		 (Bin Gt  happy_var_1 happy_var_3
	)
happyReduction_18 _ _ _  = notHappyAtAll 

happyReduce_19 = happySpecReduce_3  10 happyReduction_19
happyReduction_19 (HappyAbsSyn7  happy_var_3)
	_
	(HappyAbsSyn7  happy_var_1)
	 =  HappyAbsSyn7
		 (Bin Gte happy_var_1 happy_var_3
	)
happyReduction_19 _ _ _  = notHappyAtAll 

happyReduce_20 = happySpecReduce_1  10 happyReduction_20
happyReduction_20 (HappyAbsSyn7  happy_var_1)
	 =  HappyAbsSyn7
		 (happy_var_1
	)
happyReduction_20 _  = notHappyAtAll 

happyReduce_21 = happySpecReduce_3  11 happyReduction_21
happyReduction_21 (HappyAbsSyn7  happy_var_3)
	_
	(HappyAbsSyn7  happy_var_1)
	 =  HappyAbsSyn7
		 (Bin Shl happy_var_1 happy_var_3
	)
happyReduction_21 _ _ _  = notHappyAtAll 

happyReduce_22 = happySpecReduce_3  11 happyReduction_22
happyReduction_22 (HappyAbsSyn7  happy_var_3)
	_
	(HappyAbsSyn7  happy_var_1)
	 =  HappyAbsSyn7
		 (Bin Lshr happy_var_1 happy_var_3
	)
happyReduction_22 _ _ _  = notHappyAtAll 

happyReduce_23 = happySpecReduce_3  11 happyReduction_23
happyReduction_23 (HappyAbsSyn7  happy_var_3)
	_
	(HappyAbsSyn7  happy_var_1)
	 =  HappyAbsSyn7
		 (Bin Ashr happy_var_1 happy_var_3
	)
happyReduction_23 _ _ _  = notHappyAtAll 

happyReduce_24 = happySpecReduce_1  11 happyReduction_24
happyReduction_24 (HappyAbsSyn7  happy_var_1)
	 =  HappyAbsSyn7
		 (happy_var_1
	)
happyReduction_24 _  = notHappyAtAll 

happyReduce_25 = happySpecReduce_3  12 happyReduction_25
happyReduction_25 (HappyAbsSyn7  happy_var_3)
	_
	(HappyAbsSyn7  happy_var_1)
	 =  HappyAbsSyn7
		 (Bin Plus happy_var_1 happy_var_3
	)
happyReduction_25 _ _ _  = notHappyAtAll 

happyReduce_26 = happySpecReduce_3  12 happyReduction_26
happyReduction_26 (HappyAbsSyn7  happy_var_3)
	_
	(HappyAbsSyn7  happy_var_1)
	 =  HappyAbsSyn7
		 (Bin Minus happy_var_1 happy_var_3
	)
happyReduction_26 _ _ _  = notHappyAtAll 

happyReduce_27 = happySpecReduce_3  12 happyReduction_27
happyReduction_27 (HappyAbsSyn7  happy_var_3)
	_
	(HappyAbsSyn7  happy_var_1)
	 =  HappyAbsSyn7
		 (Bin Or happy_var_1 happy_var_3
	)
happyReduction_27 _ _ _  = notHappyAtAll 

happyReduce_28 = happySpecReduce_1  12 happyReduction_28
happyReduction_28 (HappyAbsSyn7  happy_var_1)
	 =  HappyAbsSyn7
		 (happy_var_1
	)
happyReduction_28 _  = notHappyAtAll 

happyReduce_29 = happySpecReduce_3  13 happyReduction_29
happyReduction_29 (HappyAbsSyn7  happy_var_3)
	_
	(HappyAbsSyn7  happy_var_1)
	 =  HappyAbsSyn7
		 (Bin Times happy_var_1 happy_var_3
	)
happyReduction_29 _ _ _  = notHappyAtAll 

happyReduce_30 = happySpecReduce_3  13 happyReduction_30
happyReduction_30 (HappyAbsSyn7  happy_var_3)
	_
	(HappyAbsSyn7  happy_var_1)
	 =  HappyAbsSyn7
		 (Bin And happy_var_1 happy_var_3
	)
happyReduction_30 _ _ _  = notHappyAtAll 

happyReduce_31 = happySpecReduce_1  13 happyReduction_31
happyReduction_31 (HappyAbsSyn7  happy_var_1)
	 =  HappyAbsSyn7
		 (happy_var_1
	)
happyReduction_31 _  = notHappyAtAll 

happyReduce_32 = happySpecReduce_3  14 happyReduction_32
happyReduction_32 (HappyTerminal (TokID happy_var_3))
	_
	(HappyAbsSyn14  happy_var_1)
	 =  HappyAbsSyn14
		 (Dot happy_var_1 happy_var_3
	)
happyReduction_32 _ _ _  = notHappyAtAll 

happyReduce_33 = happySpecReduce_1  14 happyReduction_33
happyReduction_33 (HappyTerminal (TokID happy_var_1))
	 =  HappyAbsSyn14
		 (Var happy_var_1
	)
happyReduction_33 _  = notHappyAtAll 

happyReduce_34 = happySpecReduce_3  15 happyReduction_34
happyReduction_34 _
	(HappyAbsSyn7  happy_var_2)
	_
	 =  HappyAbsSyn7
		 (happy_var_2
	)
happyReduction_34 _ _ _  = notHappyAtAll 

happyReduce_35 = happySpecReduce_2  15 happyReduction_35
happyReduction_35 (HappyAbsSyn7  happy_var_2)
	_
	 =  HappyAbsSyn7
		 (Unary Negate happy_var_2
	)
happyReduction_35 _ _  = notHappyAtAll 

happyReduce_36 = happySpecReduce_2  15 happyReduction_36
happyReduction_36 (HappyAbsSyn7  happy_var_2)
	_
	 =  HappyAbsSyn7
		 (Unary Complement happy_var_2
	)
happyReduction_36 _ _  = notHappyAtAll 

happyReduce_37 = happyReduce 4 15 happyReduction_37
happyReduction_37 (_ `HappyStk`
	(HappyAbsSyn16  happy_var_3) `HappyStk`
	_ `HappyStk`
	(HappyTerminal (TokID happy_var_1)) `HappyStk`
	happyRest)
	 = HappyAbsSyn7
		 (Call happy_var_1 (reverse happy_var_3)
	) `HappyStk` happyRest

happyReduce_38 = happySpecReduce_1  15 happyReduction_38
happyReduction_38 (HappyTerminal (TokLiteral happy_var_1))
	 =  HappyAbsSyn7
		 (OpE (Const happy_var_1)
	)
happyReduction_38 _  = notHappyAtAll 

happyReduce_39 = happySpecReduce_1  15 happyReduction_39
happyReduction_39 (HappyAbsSyn14  happy_var_1)
	 =  HappyAbsSyn7
		 (OpE happy_var_1
	)
happyReduction_39 _  = notHappyAtAll 

happyReduce_40 = happySpecReduce_3  16 happyReduction_40
happyReduction_40 (HappyAbsSyn7  happy_var_3)
	_
	(HappyAbsSyn16  happy_var_1)
	 =  HappyAbsSyn16
		 (happy_var_3 : happy_var_1
	)
happyReduction_40 _ _ _  = notHappyAtAll 

happyReduce_41 = happySpecReduce_1  16 happyReduction_41
happyReduction_41 (HappyAbsSyn7  happy_var_1)
	 =  HappyAbsSyn16
		 ([happy_var_1]
	)
happyReduction_41 _  = notHappyAtAll 

happyReduce_42 = happySpecReduce_0  16 happyReduction_42
happyReduction_42  =  HappyAbsSyn16
		 ([]
	)

happyReduce_43 = happySpecReduce_3  17 happyReduction_43
happyReduction_43 _
	(HappyAbsSyn17  happy_var_2)
	_
	 =  HappyAbsSyn17
		 (reverse happy_var_2
	)
happyReduction_43 _ _ _  = notHappyAtAll 

happyReduce_44 = happySpecReduce_2  18 happyReduction_44
happyReduction_44 (HappyAbsSyn19  happy_var_2)
	(HappyAbsSyn17  happy_var_1)
	 =  HappyAbsSyn17
		 (happy_var_2 : happy_var_1
	)
happyReduction_44 _ _  = notHappyAtAll 

happyReduce_45 = happySpecReduce_1  18 happyReduction_45
happyReduction_45 (HappyAbsSyn19  happy_var_1)
	 =  HappyAbsSyn17
		 ([happy_var_1]
	)
happyReduction_45 _  = notHappyAtAll 

happyReduce_46 = happySpecReduce_1  19 happyReduction_46
happyReduction_46 (HappyAbsSyn17  happy_var_1)
	 =  HappyAbsSyn19
		 (Block happy_var_1
	)
happyReduction_46 _  = notHappyAtAll 

happyReduce_47 = happyReduce 7 19 happyReduction_47
happyReduction_47 ((HappyAbsSyn19  happy_var_7) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn19  happy_var_5) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn7  happy_var_3) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn19
		 (If happy_var_3 happy_var_5 happy_var_7
	) `HappyStk` happyRest

happyReduce_48 = happyReduce 5 19 happyReduction_48
happyReduction_48 ((HappyAbsSyn19  happy_var_5) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn7  happy_var_3) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn19
		 (If happy_var_3 happy_var_5 (Block [])
	) `HappyStk` happyRest

happyReduce_49 = happyReduce 5 19 happyReduction_49
happyReduction_49 ((HappyAbsSyn19  happy_var_5) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn7  happy_var_3) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn19
		 (While happy_var_3 happy_var_5
	) `HappyStk` happyRest

happyReduce_50 = happySpecReduce_2  19 happyReduction_50
happyReduction_50 _
	_
	 =  HappyAbsSyn19
		 (Break
	)

happyReduce_51 = happySpecReduce_2  19 happyReduction_51
happyReduction_51 _
	_
	 =  HappyAbsSyn19
		 (Continue
	)

happyReduce_52 = happySpecReduce_3  19 happyReduction_52
happyReduction_52 _
	(HappyAbsSyn7  happy_var_2)
	_
	 =  HappyAbsSyn19
		 (Return happy_var_2
	)
happyReduction_52 _ _ _  = notHappyAtAll 

happyReduce_53 = happySpecReduce_3  19 happyReduction_53
happyReduction_53 _
	(HappyTerminal (TokID happy_var_2))
	(HappyAbsSyn5  happy_var_1)
	 =  HappyAbsSyn19
		 (Decl happy_var_1 happy_var_2
	)
happyReduction_53 _ _ _  = notHappyAtAll 

happyReduce_54 = happySpecReduce_2  19 happyReduction_54
happyReduction_54 _
	(HappyAbsSyn7  happy_var_1)
	 =  HappyAbsSyn19
		 (ExpS happy_var_1
	)
happyReduction_54 _ _  = notHappyAtAll 

happyReduce_55 = happyReduce 8 20 happyReduction_55
happyReduction_55 (_ `HappyStk`
	(HappyAbsSyn17  happy_var_7) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn6  happy_var_4) `HappyStk`
	_ `HappyStk`
	(HappyTerminal (TokID happy_var_2)) `HappyStk`
	(HappyAbsSyn5  happy_var_1) `HappyStk`
	happyRest)
	 = HappyAbsSyn20
		 (FunDecl happy_var_1 happy_var_2 (reverse happy_var_4) (reverse happy_var_7)
	) `HappyStk` happyRest

happyNewToken action sts stk
	= lexwrap(\tk -> 
	let cont i = action i i tk (HappyState action) sts stk in
	case tk of {
	TokEOF -> action 56 56 tk (HappyState action) sts stk;
	TokLParen -> cont 21;
	TokRParen -> cont 22;
	TokLBrace -> cont 23;
	TokRBrace -> cont 24;
	TokDot -> cont 25;
	TokQuestion -> cont 26;
	TokColon -> cont 27;
	TokComma -> cont 28;
	TokSemi -> cont 29;
	TokEquals -> cont 30;
	TokEqEq -> cont 31;
	TokBangEq -> cont 32;
	TokLt -> cont 33;
	TokLte -> cont 34;
	TokGt -> cont 35;
	TokGte -> cont 36;
	TokPlus -> cont 37;
	TokMinus -> cont 38;
	TokStar -> cont 39;
	TokTilde -> cont 40;
	TokAmp -> cont 41;
	TokBar -> cont 42;
	TokShl -> cont 43;
	TokLshr -> cont 44;
	TokAshr -> cont 45;
	TokInt -> cont 46;
	TokStruct -> cont 47;
	TokIf -> cont 48;
	TokElse -> cont 49;
	TokWhile -> cont 50;
	TokBreak -> cont 51;
	TokContinue -> cont 52;
	TokReturn -> cont 53;
	TokID happy_dollar_dollar -> cont 54;
	TokLiteral happy_dollar_dollar -> cont 55;
	_ -> happyError' (tk, [])
	})

happyError_ explist 56 tk = happyError' (tk, explist)
happyError_ explist _ tk = happyError' (tk, explist)

happyThen :: () => Alex a -> (a -> Alex b) -> Alex b
happyThen = (>>=)
happyReturn :: () => a -> Alex a
happyReturn = (return)
happyThen1 :: () => Alex a -> (a -> Alex b) -> Alex b
happyThen1 = happyThen
happyReturn1 :: () => a -> Alex a
happyReturn1 = happyReturn
happyError' :: () => ((Token), [String]) -> Alex a
happyError' tk = (\(tokens, _) -> (alexError . ("Parse error: " ++) . show) tokens) tk
parse = happySomeParser where
 happySomeParser = happyThen (happyParse action_0) (\x -> case x of {HappyAbsSyn4 z -> happyReturn z; _other -> notHappyAtAll })

happySeq = happyDontSeq



{-# LINE 1 "templates\GenericTemplate.hs" #-}
{-# LINE 1 "templates\\GenericTemplate.hs" #-}
{-# LINE 1 "<built-in>" #-}
{-# LINE 1 "<command-line>" #-}
{-# LINE 8 "<command-line>" #-}
{-# LINE 1 "C:\\Program Files\\ghc\\ghc-8.2.2\\lib/include\\ghcversion.h" #-}















{-# LINE 8 "<command-line>" #-}
{-# LINE 1 "C:\\Users\\Garrett\\AppData\\Local\\Temp\\ghc11504_0\\ghc_2.h" #-}










































































































































































































































{-# LINE 8 "<command-line>" #-}
{-# LINE 1 "templates\\GenericTemplate.hs" #-}
-- Id: GenericTemplate.hs,v 1.26 2005/01/14 14:47:22 simonmar Exp 









{-# LINE 43 "templates\\GenericTemplate.hs" #-}

data Happy_IntList = HappyCons Int Happy_IntList







{-# LINE 65 "templates\\GenericTemplate.hs" #-}

{-# LINE 75 "templates\\GenericTemplate.hs" #-}

{-# LINE 84 "templates\\GenericTemplate.hs" #-}

infixr 9 `HappyStk`
data HappyStk a = HappyStk a (HappyStk a)

-----------------------------------------------------------------------------
-- starting the parse

happyParse start_state = happyNewToken start_state notHappyAtAll notHappyAtAll

-----------------------------------------------------------------------------
-- Accepting the parse

-- If the current token is (1), it means we've just accepted a partial
-- parse (a %partial parser).  We must ignore the saved token on the top of
-- the stack in this case.
happyAccept (1) tk st sts (_ `HappyStk` ans `HappyStk` _) =
        happyReturn1 ans
happyAccept j tk st sts (HappyStk ans _) = 
         (happyReturn1 ans)

-----------------------------------------------------------------------------
-- Arrays only: do the next action

{-# LINE 137 "templates\\GenericTemplate.hs" #-}

{-# LINE 147 "templates\\GenericTemplate.hs" #-}
indexShortOffAddr arr off = arr Happy_Data_Array.! off


{-# INLINE happyLt #-}
happyLt x y = (x < y)






readArrayBit arr bit =
    Bits.testBit (indexShortOffAddr arr (bit `div` 16)) (bit `mod` 16)






-----------------------------------------------------------------------------
-- HappyState data type (not arrays)



newtype HappyState b c = HappyState
        (Int ->                    -- token number
         Int ->                    -- token number (yes, again)
         b ->                           -- token semantic value
         HappyState b c ->              -- current state
         [HappyState b c] ->            -- state stack
         c)



-----------------------------------------------------------------------------
-- Shifting a token

happyShift new_state (1) tk st sts stk@(x `HappyStk` _) =
     let i = (case x of { HappyErrorToken (i) -> i }) in
--     trace "shifting the error token" $
     new_state i i tk (HappyState (new_state)) ((st):(sts)) (stk)

happyShift new_state i tk st sts stk =
     happyNewToken new_state ((st):(sts)) ((HappyTerminal (tk))`HappyStk`stk)

-- happyReduce is specialised for the common cases.

happySpecReduce_0 i fn (1) tk st sts stk
     = happyFail [] (1) tk st sts stk
happySpecReduce_0 nt fn j tk st@((HappyState (action))) sts stk
     = action nt j tk st ((st):(sts)) (fn `HappyStk` stk)

happySpecReduce_1 i fn (1) tk st sts stk
     = happyFail [] (1) tk st sts stk
happySpecReduce_1 nt fn j tk _ sts@(((st@(HappyState (action))):(_))) (v1`HappyStk`stk')
     = let r = fn v1 in
       happySeq r (action nt j tk st sts (r `HappyStk` stk'))

happySpecReduce_2 i fn (1) tk st sts stk
     = happyFail [] (1) tk st sts stk
happySpecReduce_2 nt fn j tk _ ((_):(sts@(((st@(HappyState (action))):(_))))) (v1`HappyStk`v2`HappyStk`stk')
     = let r = fn v1 v2 in
       happySeq r (action nt j tk st sts (r `HappyStk` stk'))

happySpecReduce_3 i fn (1) tk st sts stk
     = happyFail [] (1) tk st sts stk
happySpecReduce_3 nt fn j tk _ ((_):(((_):(sts@(((st@(HappyState (action))):(_))))))) (v1`HappyStk`v2`HappyStk`v3`HappyStk`stk')
     = let r = fn v1 v2 v3 in
       happySeq r (action nt j tk st sts (r `HappyStk` stk'))

happyReduce k i fn (1) tk st sts stk
     = happyFail [] (1) tk st sts stk
happyReduce k nt fn j tk st sts stk
     = case happyDrop (k - ((1) :: Int)) sts of
         sts1@(((st1@(HappyState (action))):(_))) ->
                let r = fn stk in  -- it doesn't hurt to always seq here...
                happyDoSeq r (action nt j tk st1 sts1 r)

happyMonadReduce k nt fn (1) tk st sts stk
     = happyFail [] (1) tk st sts stk
happyMonadReduce k nt fn j tk st sts stk =
      case happyDrop k ((st):(sts)) of
        sts1@(((st1@(HappyState (action))):(_))) ->
          let drop_stk = happyDropStk k stk in
          happyThen1 (fn stk tk) (\r -> action nt j tk st1 sts1 (r `HappyStk` drop_stk))

happyMonad2Reduce k nt fn (1) tk st sts stk
     = happyFail [] (1) tk st sts stk
happyMonad2Reduce k nt fn j tk st sts stk =
      case happyDrop k ((st):(sts)) of
        sts1@(((st1@(HappyState (action))):(_))) ->
         let drop_stk = happyDropStk k stk





             _ = nt :: Int
             new_state = action

          in
          happyThen1 (fn stk tk) (\r -> happyNewToken new_state sts1 (r `HappyStk` drop_stk))

happyDrop (0) l = l
happyDrop n ((_):(t)) = happyDrop (n - ((1) :: Int)) t

happyDropStk (0) l = l
happyDropStk n (x `HappyStk` xs) = happyDropStk (n - ((1)::Int)) xs

-----------------------------------------------------------------------------
-- Moving to a new state after a reduction

{-# LINE 267 "templates\\GenericTemplate.hs" #-}
happyGoto action j tk st = action j j tk (HappyState action)


-----------------------------------------------------------------------------
-- Error recovery ((1) is the error token)

-- parse error if we are in recovery and we fail again
happyFail explist (1) tk old_st _ stk@(x `HappyStk` _) =
     let i = (case x of { HappyErrorToken (i) -> i }) in
--      trace "failing" $ 
        happyError_ explist i tk

{-  We don't need state discarding for our restricted implementation of
    "error".  In fact, it can cause some bogus parses, so I've disabled it
    for now --SDM

-- discard a state
happyFail  (1) tk old_st (((HappyState (action))):(sts)) 
                                                (saved_tok `HappyStk` _ `HappyStk` stk) =
--      trace ("discarding state, depth " ++ show (length stk))  $
        action (1) (1) tk (HappyState (action)) sts ((saved_tok`HappyStk`stk))
-}

-- Enter error recovery: generate an error token,
--                       save the old token and carry on.
happyFail explist i tk (HappyState (action)) sts stk =
--      trace "entering error recovery" $
        action (1) (1) tk (HappyState (action)) sts ( (HappyErrorToken (i)) `HappyStk` stk)

-- Internal happy errors:

notHappyAtAll :: a
notHappyAtAll = error "Internal Happy error\n"

-----------------------------------------------------------------------------
-- Hack to get the typechecker to accept our action functions







-----------------------------------------------------------------------------
-- Seq-ing.  If the --strict flag is given, then Happy emits 
--      happySeq = happyDoSeq
-- otherwise it emits
--      happySeq = happyDontSeq

happyDoSeq, happyDontSeq :: a -> b -> b
happyDoSeq   a b = a `seq` b
happyDontSeq a b = b

-----------------------------------------------------------------------------
-- Don't inline any functions from the template.  GHC has a nasty habit
-- of deciding to inline happyGoto everywhere, which increases the size of
-- the generated parser quite a bit.

{-# LINE 333 "templates\\GenericTemplate.hs" #-}
{-# NOINLINE happyShift #-}
{-# NOINLINE happySpecReduce_0 #-}
{-# NOINLINE happySpecReduce_1 #-}
{-# NOINLINE happySpecReduce_2 #-}
{-# NOINLINE happySpecReduce_3 #-}
{-# NOINLINE happyReduce #-}
{-# NOINLINE happyMonadReduce #-}
{-# NOINLINE happyGoto #-}
{-# NOINLINE happyFail #-}

-- end of Happy Template.
