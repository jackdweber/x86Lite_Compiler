{-# OPTIONS_GHC -w #-}
module LL.Parser where

import LL.Lexer
import LL.Language
import qualified Data.Array as Happy_Data_Array
import qualified Data.Bits as Bits
import Control.Applicative(Applicative(..))
import Control.Monad (ap)

-- parser produced by Happy Version 1.19.9

data HappyAbsSyn 
	= HappyTerminal (Token)
	| HappyErrorToken Int
	| HappyAbsSyn4 (Prog)
	| HappyAbsSyn5 (Operator)
	| HappyAbsSyn6 (Condition)
	| HappyAbsSyn7 (Type)
	| HappyAbsSyn8 ([Type])
	| HappyAbsSyn9 (Operand)
	| HappyAbsSyn11 ([(Type, Operand)])
	| HappyAbsSyn13 (Instruction)
	| HappyAbsSyn14 (Terminator)
	| HappyAbsSyn15 ([Instruction])
	| HappyAbsSyn16 (([Instruction], Terminator))
	| HappyAbsSyn17 ([(String, Block)])
	| HappyAbsSyn18 (String)
	| HappyAbsSyn20 ((Type, String))
	| HappyAbsSyn21 ([(Type, String)])
	| HappyAbsSyn22 (Initializer)
	| HappyAbsSyn23 ([(Type, Initializer)])
	| HappyAbsSyn25 ((String, Type))
	| HappyAbsSyn26 ((String, Type, Initializer))
	| HappyAbsSyn27 ((String, Function))

{- to allow type-synonyms as our monads (likely
 - with explicitly-specified bind and return)
 - in Haskell98, it seems that with
 - /type M a = .../, then /(HappyReduction M)/
 - is not allowed.  But Happy is a
 - code-generator that can just substitute it.
type HappyReduction m = 
	   Int 
	-> (Token)
	-> HappyState (Token) (HappyStk HappyAbsSyn -> [(Token)] -> m HappyAbsSyn)
	-> [HappyState (Token) (HappyStk HappyAbsSyn -> [(Token)] -> m HappyAbsSyn)] 
	-> HappyStk HappyAbsSyn 
	-> [(Token)] -> m HappyAbsSyn
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
 action_113,
 action_114,
 action_115,
 action_116,
 action_117,
 action_118,
 action_119,
 action_120,
 action_121,
 action_122,
 action_123,
 action_124,
 action_125,
 action_126,
 action_127,
 action_128,
 action_129,
 action_130,
 action_131,
 action_132,
 action_133,
 action_134,
 action_135,
 action_136,
 action_137,
 action_138,
 action_139,
 action_140,
 action_141,
 action_142,
 action_143,
 action_144,
 action_145,
 action_146,
 action_147,
 action_148,
 action_149,
 action_150,
 action_151,
 action_152,
 action_153,
 action_154,
 action_155,
 action_156,
 action_157,
 action_158,
 action_159,
 action_160,
 action_161,
 action_162,
 action_163,
 action_164,
 action_165,
 action_166,
 action_167,
 action_168,
 action_169,
 action_170 :: () => Int -> ({-HappyReduction (HappyIdentity) = -}
	   Int 
	-> (Token)
	-> HappyState (Token) (HappyStk HappyAbsSyn -> [(Token)] -> (HappyIdentity) HappyAbsSyn)
	-> [HappyState (Token) (HappyStk HappyAbsSyn -> [(Token)] -> (HappyIdentity) HappyAbsSyn)] 
	-> HappyStk HappyAbsSyn 
	-> [(Token)] -> (HappyIdentity) HappyAbsSyn)

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
 happyReduce_55,
 happyReduce_56,
 happyReduce_57,
 happyReduce_58,
 happyReduce_59,
 happyReduce_60,
 happyReduce_61,
 happyReduce_62,
 happyReduce_63,
 happyReduce_64,
 happyReduce_65,
 happyReduce_66,
 happyReduce_67,
 happyReduce_68,
 happyReduce_69,
 happyReduce_70,
 happyReduce_71,
 happyReduce_72,
 happyReduce_73,
 happyReduce_74,
 happyReduce_75,
 happyReduce_76,
 happyReduce_77,
 happyReduce_78,
 happyReduce_79 :: () => ({-HappyReduction (HappyIdentity) = -}
	   Int 
	-> (Token)
	-> HappyState (Token) (HappyStk HappyAbsSyn -> [(Token)] -> (HappyIdentity) HappyAbsSyn)
	-> [HappyState (Token) (HappyStk HappyAbsSyn -> [(Token)] -> (HappyIdentity) HappyAbsSyn)] 
	-> HappyStk HappyAbsSyn 
	-> [(Token)] -> (HappyIdentity) HappyAbsSyn)

happyExpList :: Happy_Data_Array.Array Int Int
happyExpList = Happy_Data_Array.listArray (0,286) ([0,0,0,0,0,0,0,0,0,0,0,0,0,0,1536,3,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,640,23,0,64,0,1280,46,0,128,0,16384,0,0,0,0,32768,0,0,0,0,0,0,0,96,0,0,0,0,8,0,3072,0,0,8192,0,0,0,0,2048,0,32768,5890,0,16384,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,12,0,0,32,0,0,0,0,0,0,640,23,0,64,0,64,0,0,0,0,8384,0,0,0,0,8192,0,0,0,0,0,4,0,0,0,1024,0,0,0,0,40960,1472,0,4096,0,0,0,0,512,0,32768,5890,0,16384,0,24576,5,0,12288,1,0,23562,0,0,1,32768,1,0,0,0,0,28712,1,0,4,0,57424,2,0,8,0,0,0,0,0,0,33088,11,0,32,0,640,23,0,64,0,128,0,0,0,0,0,0,0,0,0,384,0,0,512,0,32768,0,0,0,0,2048,0,0,0,0,0,0,0,0,0,38912,0,0,0,0,16384,0,0,0,0,24576,0,0,0,0,0,0,0,0,0,0,47124,0,0,2,0,28712,1,0,4,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,688,0,0,152,0,2048,0,0,0,0,1024,0,0,0,0,0,0,0,0,0,0,0,0,0,0,16384,0,0,0,0,40960,1472,0,4096,0,0,0,0,0,0,0,0,0,0,0,0,0,0,32769,0,0,0,0,0,0,0,0,0,0,0,0,128,0,0,0,0,57424,2,0,8,0,0,0,32,16,0,0,0,6144,0,0,0,0,0,0,0,1280,46,0,128,0,16384,0,0,0,0,0,65024,31491,0,0,768,0,0,3328,0,0,0,0,1536,0,0,8,0,0,0,0,2,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,47124,0,0,2,0,8192,2,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,104,0,0,0,0,64,0,96,0,0,416,0,0,0,0,0,0,0,0,0,0,0,0,0,2048,1024,0,0,4,0,0,0,0,2,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,23562,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,10240,368,0,1024,0,20480,736,0,2048,0,0,0,2016,0,0,16384,2945,0,8192,0,32768,5890,0,16384,0,0,11781,0,32768,0,49152,32,0,0,0,32768,1,0,32768,6,0,3,0,0,8,0,57424,2,0,8,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,33536,0,0,0,0,1536,0,0,0,0,3072,0,0,13312,0,16384,2945,0,8192,0,0,0,32768,16384,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,128,0,0,0,0,0,4,0,0,0,0,0,0,0,0,24,0,0,104,0,2048,0,0,0,0,1280,46,0,128,0,192,0,0,832,0,256,0,0,0,0,0,8,0,0,0,20480,736,0,2048,0,3072,0,0,13312,0,16384,2945,0,8192,0,32768,7938,0,16384,0,0,16,0,0,0,49152,0,0,16384,3,0,0,0,32768,6,0,0,0,0,0,0,0,0,0,8,0,512,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,416,0,192,0,0,0,0,0,0,0,1664,0,0,0,0,0,0,2048,0,0,0,0,0,0,0,0,0,6144,0,0,0,0,0,8,0,0,0,0,15877,0,32768,0,0,0,0,0,0,0,64,0,0,0,0,0,0,0,0,0,0,4,0,0,0,0,0,0,16,0,33088,15,0,32,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	])

{-# NOINLINE happyExpListPerState #-}
happyExpListPerState st =
    token_strs_expected
  where token_strs = ["error","%dummy","%start_parse","prog","op","relation","ty","types","operand","argType","arguments","maybeArguments","instr","term","instrs","block","blocksRev","blockLabel","blocks","param","params","init","inits","decls","tdecl","gdecl","fdecl","edecl","'*'","'('","')'","'['","']'","'{'","'}'","','","'='","':'","X","TO","VOID","I1","I8","I32","I64","LABEL","ADD","SUB","MUL","SHL","LSHR","ASHR","AND","OR","XOR","EQ","NE","LT","LE","GT","GE","ALLOCA","LOAD","STORE","ICMP","CALL","BITCAST","GEP","RET","BR","TYPE","DEFINE","DECLARE","EXTERNAL","GLOBAL","NULL","NUMBER","ID","LID","GID","%eof"]
        bit_start = st * 81
        bit_end = (st + 1) * 81
        read_bit = readArrayBit happyExpList
        bits = map read_bit [bit_start..bit_end - 1]
        bits_indexed = zip bits [0..80]
        token_strs_expected = concatMap f bits_indexed
        f (False, _) = []
        f (True, nr) = [token_strs !! nr]

action_0 (4) = happyGoto action_3
action_0 (24) = happyGoto action_2
action_0 _ = happyReduce_70

action_1 (24) = happyGoto action_2
action_1 _ = happyFail (happyExpListPerState 1)

action_2 (72) = happyShift action_8
action_2 (73) = happyShift action_9
action_2 (79) = happyShift action_10
action_2 (80) = happyShift action_11
action_2 (25) = happyGoto action_4
action_2 (26) = happyGoto action_5
action_2 (27) = happyGoto action_6
action_2 (28) = happyGoto action_7
action_2 _ = happyReduce_1

action_3 (81) = happyAccept
action_3 _ = happyFail (happyExpListPerState 3)

action_4 _ = happyReduce_71

action_5 _ = happyReduce_72

action_6 _ = happyReduce_73

action_7 _ = happyReduce_74

action_8 (32) = happyShift action_15
action_8 (34) = happyShift action_16
action_8 (41) = happyShift action_17
action_8 (42) = happyShift action_18
action_8 (43) = happyShift action_19
action_8 (45) = happyShift action_20
action_8 (79) = happyShift action_21
action_8 (7) = happyGoto action_22
action_8 _ = happyFail (happyExpListPerState 8)

action_9 (32) = happyShift action_15
action_9 (34) = happyShift action_16
action_9 (41) = happyShift action_17
action_9 (42) = happyShift action_18
action_9 (43) = happyShift action_19
action_9 (45) = happyShift action_20
action_9 (79) = happyShift action_21
action_9 (7) = happyGoto action_14
action_9 _ = happyFail (happyExpListPerState 9)

action_10 (37) = happyShift action_13
action_10 _ = happyFail (happyExpListPerState 10)

action_11 (37) = happyShift action_12
action_11 _ = happyFail (happyExpListPerState 11)

action_12 (74) = happyShift action_31
action_12 (75) = happyShift action_32
action_12 _ = happyFail (happyExpListPerState 12)

action_13 (71) = happyShift action_30
action_13 _ = happyFail (happyExpListPerState 13)

action_14 (29) = happyShift action_23
action_14 (30) = happyShift action_24
action_14 (80) = happyShift action_29
action_14 _ = happyFail (happyExpListPerState 14)

action_15 (77) = happyShift action_28
action_15 _ = happyFail (happyExpListPerState 15)

action_16 (32) = happyShift action_15
action_16 (34) = happyShift action_16
action_16 (41) = happyShift action_17
action_16 (42) = happyShift action_18
action_16 (43) = happyShift action_19
action_16 (45) = happyShift action_20
action_16 (79) = happyShift action_21
action_16 (7) = happyGoto action_26
action_16 (8) = happyGoto action_27
action_16 _ = happyFail (happyExpListPerState 16)

action_17 _ = happyReduce_17

action_18 _ = happyReduce_18

action_19 _ = happyReduce_19

action_20 _ = happyReduce_20

action_21 _ = happyReduce_25

action_22 (29) = happyShift action_23
action_22 (30) = happyShift action_24
action_22 (80) = happyShift action_25
action_22 _ = happyFail (happyExpListPerState 22)

action_23 _ = happyReduce_21

action_24 (32) = happyShift action_15
action_24 (34) = happyShift action_16
action_24 (41) = happyShift action_17
action_24 (42) = happyShift action_18
action_24 (43) = happyShift action_19
action_24 (45) = happyShift action_20
action_24 (79) = happyShift action_21
action_24 (7) = happyGoto action_26
action_24 (8) = happyGoto action_41
action_24 _ = happyFail (happyExpListPerState 24)

action_25 (30) = happyShift action_40
action_25 _ = happyFail (happyExpListPerState 25)

action_26 (29) = happyShift action_23
action_26 (30) = happyShift action_24
action_26 (36) = happyShift action_39
action_26 _ = happyReduce_27

action_27 (35) = happyShift action_38
action_27 _ = happyFail (happyExpListPerState 27)

action_28 (39) = happyShift action_37
action_28 _ = happyFail (happyExpListPerState 28)

action_29 (30) = happyShift action_36
action_29 _ = happyFail (happyExpListPerState 29)

action_30 (32) = happyShift action_15
action_30 (34) = happyShift action_16
action_30 (41) = happyShift action_17
action_30 (42) = happyShift action_18
action_30 (43) = happyShift action_19
action_30 (45) = happyShift action_20
action_30 (79) = happyShift action_21
action_30 (7) = happyGoto action_35
action_30 _ = happyFail (happyExpListPerState 30)

action_31 (75) = happyShift action_34
action_31 _ = happyFail (happyExpListPerState 31)

action_32 (32) = happyShift action_15
action_32 (34) = happyShift action_16
action_32 (41) = happyShift action_17
action_32 (42) = happyShift action_18
action_32 (43) = happyShift action_19
action_32 (45) = happyShift action_20
action_32 (79) = happyShift action_21
action_32 (7) = happyGoto action_33
action_32 _ = happyFail (happyExpListPerState 32)

action_33 (29) = happyShift action_23
action_33 (30) = happyShift action_24
action_33 (32) = happyShift action_51
action_33 (34) = happyShift action_52
action_33 (76) = happyShift action_53
action_33 (77) = happyShift action_54
action_33 (80) = happyShift action_55
action_33 (22) = happyGoto action_50
action_33 _ = happyFail (happyExpListPerState 33)

action_34 (32) = happyShift action_15
action_34 (34) = happyShift action_16
action_34 (41) = happyShift action_17
action_34 (42) = happyShift action_18
action_34 (43) = happyShift action_19
action_34 (45) = happyShift action_20
action_34 (79) = happyShift action_21
action_34 (7) = happyGoto action_49
action_34 _ = happyFail (happyExpListPerState 34)

action_35 (29) = happyShift action_23
action_35 (30) = happyShift action_24
action_35 _ = happyReduce_75

action_36 (32) = happyShift action_15
action_36 (34) = happyShift action_16
action_36 (41) = happyShift action_17
action_36 (42) = happyShift action_18
action_36 (43) = happyShift action_19
action_36 (45) = happyShift action_20
action_36 (79) = happyShift action_21
action_36 (7) = happyGoto action_26
action_36 (8) = happyGoto action_48
action_36 _ = happyFail (happyExpListPerState 36)

action_37 (32) = happyShift action_15
action_37 (34) = happyShift action_16
action_37 (41) = happyShift action_17
action_37 (42) = happyShift action_18
action_37 (43) = happyShift action_19
action_37 (45) = happyShift action_20
action_37 (79) = happyShift action_21
action_37 (7) = happyGoto action_47
action_37 _ = happyFail (happyExpListPerState 37)

action_38 _ = happyReduce_23

action_39 (32) = happyShift action_15
action_39 (34) = happyShift action_16
action_39 (41) = happyShift action_17
action_39 (42) = happyShift action_18
action_39 (43) = happyShift action_19
action_39 (45) = happyShift action_20
action_39 (79) = happyShift action_21
action_39 (7) = happyGoto action_26
action_39 (8) = happyGoto action_46
action_39 _ = happyFail (happyExpListPerState 39)

action_40 (32) = happyShift action_15
action_40 (34) = happyShift action_16
action_40 (41) = happyShift action_17
action_40 (42) = happyShift action_18
action_40 (43) = happyShift action_19
action_40 (45) = happyShift action_20
action_40 (79) = happyShift action_21
action_40 (7) = happyGoto action_43
action_40 (20) = happyGoto action_44
action_40 (21) = happyGoto action_45
action_40 _ = happyReduce_59

action_41 (31) = happyShift action_42
action_41 _ = happyFail (happyExpListPerState 41)

action_42 _ = happyReduce_24

action_43 (29) = happyShift action_23
action_43 (30) = happyShift action_24
action_43 (79) = happyShift action_63
action_43 _ = happyFail (happyExpListPerState 43)

action_44 (36) = happyShift action_62
action_44 _ = happyReduce_60

action_45 (31) = happyShift action_61
action_45 _ = happyFail (happyExpListPerState 45)

action_46 _ = happyReduce_26

action_47 (29) = happyShift action_23
action_47 (30) = happyShift action_24
action_47 (33) = happyShift action_60
action_47 _ = happyFail (happyExpListPerState 47)

action_48 (31) = happyShift action_59
action_48 _ = happyFail (happyExpListPerState 48)

action_49 (29) = happyShift action_23
action_49 (30) = happyShift action_24
action_49 _ = happyReduce_79

action_50 _ = happyReduce_76

action_51 (32) = happyShift action_15
action_51 (34) = happyShift action_16
action_51 (41) = happyShift action_17
action_51 (42) = happyShift action_18
action_51 (43) = happyShift action_19
action_51 (45) = happyShift action_20
action_51 (79) = happyShift action_21
action_51 (7) = happyGoto action_56
action_51 (23) = happyGoto action_58
action_51 _ = happyReduce_67

action_52 (32) = happyShift action_15
action_52 (34) = happyShift action_16
action_52 (41) = happyShift action_17
action_52 (42) = happyShift action_18
action_52 (43) = happyShift action_19
action_52 (45) = happyShift action_20
action_52 (79) = happyShift action_21
action_52 (7) = happyGoto action_56
action_52 (23) = happyGoto action_57
action_52 _ = happyReduce_67

action_53 _ = happyReduce_62

action_54 _ = happyReduce_64

action_55 _ = happyReduce_63

action_56 (29) = happyShift action_23
action_56 (30) = happyShift action_24
action_56 (32) = happyShift action_51
action_56 (34) = happyShift action_52
action_56 (76) = happyShift action_53
action_56 (77) = happyShift action_54
action_56 (80) = happyShift action_55
action_56 (22) = happyGoto action_68
action_56 _ = happyFail (happyExpListPerState 56)

action_57 (35) = happyShift action_67
action_57 _ = happyFail (happyExpListPerState 57)

action_58 (33) = happyShift action_66
action_58 _ = happyFail (happyExpListPerState 58)

action_59 _ = happyReduce_78

action_60 _ = happyReduce_22

action_61 (34) = happyShift action_65
action_61 _ = happyFail (happyExpListPerState 61)

action_62 (32) = happyShift action_15
action_62 (34) = happyShift action_16
action_62 (41) = happyShift action_17
action_62 (42) = happyShift action_18
action_62 (43) = happyShift action_19
action_62 (45) = happyShift action_20
action_62 (79) = happyShift action_21
action_62 (7) = happyGoto action_43
action_62 (20) = happyGoto action_44
action_62 (21) = happyGoto action_64
action_62 _ = happyReduce_59

action_63 _ = happyReduce_58

action_64 _ = happyReduce_61

action_65 (64) = happyShift action_73
action_65 (79) = happyShift action_74
action_65 (13) = happyGoto action_70
action_65 (15) = happyGoto action_71
action_65 (16) = happyGoto action_72
action_65 _ = happyReduce_49

action_66 _ = happyReduce_65

action_67 _ = happyReduce_66

action_68 (36) = happyShift action_69
action_68 _ = happyReduce_68

action_69 (32) = happyShift action_15
action_69 (34) = happyShift action_16
action_69 (41) = happyShift action_17
action_69 (42) = happyShift action_18
action_69 (43) = happyShift action_19
action_69 (45) = happyShift action_20
action_69 (79) = happyShift action_21
action_69 (7) = happyGoto action_56
action_69 (23) = happyGoto action_86
action_69 _ = happyReduce_67

action_70 (64) = happyShift action_73
action_70 (79) = happyShift action_74
action_70 (13) = happyGoto action_70
action_70 (15) = happyGoto action_85
action_70 _ = happyReduce_49

action_71 (69) = happyShift action_83
action_71 (70) = happyShift action_84
action_71 (14) = happyGoto action_82
action_71 _ = happyFail (happyExpListPerState 71)

action_72 (77) = happyShift action_80
action_72 (78) = happyShift action_81
action_72 (17) = happyGoto action_77
action_72 (18) = happyGoto action_78
action_72 (19) = happyGoto action_79
action_72 _ = happyReduce_52

action_73 (32) = happyShift action_15
action_73 (34) = happyShift action_16
action_73 (41) = happyShift action_17
action_73 (42) = happyShift action_18
action_73 (43) = happyShift action_19
action_73 (45) = happyShift action_20
action_73 (79) = happyShift action_21
action_73 (7) = happyGoto action_76
action_73 _ = happyFail (happyExpListPerState 73)

action_74 (37) = happyShift action_75
action_74 _ = happyFail (happyExpListPerState 74)

action_75 (47) = happyShift action_99
action_75 (48) = happyShift action_100
action_75 (49) = happyShift action_101
action_75 (50) = happyShift action_102
action_75 (51) = happyShift action_103
action_75 (52) = happyShift action_104
action_75 (53) = happyShift action_105
action_75 (54) = happyShift action_106
action_75 (55) = happyShift action_107
action_75 (62) = happyShift action_108
action_75 (63) = happyShift action_109
action_75 (65) = happyShift action_110
action_75 (66) = happyShift action_111
action_75 (67) = happyShift action_112
action_75 (68) = happyShift action_113
action_75 (5) = happyGoto action_98
action_75 _ = happyFail (happyExpListPerState 75)

action_76 (29) = happyShift action_23
action_76 (30) = happyShift action_24
action_76 (77) = happyShift action_95
action_76 (79) = happyShift action_96
action_76 (80) = happyShift action_97
action_76 (9) = happyGoto action_94
action_76 _ = happyFail (happyExpListPerState 76)

action_77 (77) = happyShift action_80
action_77 (78) = happyShift action_81
action_77 (18) = happyGoto action_93
action_77 _ = happyReduce_57

action_78 (38) = happyShift action_92
action_78 _ = happyFail (happyExpListPerState 78)

action_79 (35) = happyShift action_91
action_79 _ = happyFail (happyExpListPerState 79)

action_80 _ = happyReduce_56

action_81 _ = happyReduce_55

action_82 _ = happyReduce_51

action_83 (32) = happyShift action_15
action_83 (34) = happyShift action_16
action_83 (41) = happyShift action_90
action_83 (42) = happyShift action_18
action_83 (43) = happyShift action_19
action_83 (45) = happyShift action_20
action_83 (79) = happyShift action_21
action_83 (7) = happyGoto action_89
action_83 _ = happyFail (happyExpListPerState 83)

action_84 (42) = happyShift action_87
action_84 (46) = happyShift action_88
action_84 _ = happyFail (happyExpListPerState 84)

action_85 _ = happyReduce_50

action_86 _ = happyReduce_69

action_87 (77) = happyShift action_95
action_87 (79) = happyShift action_96
action_87 (80) = happyShift action_97
action_87 (9) = happyGoto action_132
action_87 _ = happyFail (happyExpListPerState 87)

action_88 (79) = happyShift action_131
action_88 _ = happyFail (happyExpListPerState 88)

action_89 (29) = happyShift action_23
action_89 (30) = happyShift action_24
action_89 (77) = happyShift action_95
action_89 (79) = happyShift action_96
action_89 (80) = happyShift action_97
action_89 (9) = happyGoto action_130
action_89 _ = happyFail (happyExpListPerState 89)

action_90 (35) = happyReduce_45
action_90 (77) = happyReduce_45
action_90 (78) = happyReduce_45
action_90 _ = happyReduce_17

action_91 _ = happyReduce_77

action_92 (64) = happyShift action_73
action_92 (79) = happyShift action_74
action_92 (13) = happyGoto action_70
action_92 (15) = happyGoto action_71
action_92 (16) = happyGoto action_129
action_92 _ = happyReduce_49

action_93 (38) = happyShift action_128
action_93 _ = happyFail (happyExpListPerState 93)

action_94 (36) = happyShift action_127
action_94 _ = happyFail (happyExpListPerState 94)

action_95 _ = happyReduce_28

action_96 _ = happyReduce_29

action_97 _ = happyReduce_30

action_98 (32) = happyShift action_15
action_98 (34) = happyShift action_16
action_98 (41) = happyShift action_17
action_98 (42) = happyShift action_18
action_98 (43) = happyShift action_19
action_98 (45) = happyShift action_20
action_98 (79) = happyShift action_21
action_98 (7) = happyGoto action_126
action_98 _ = happyFail (happyExpListPerState 98)

action_99 _ = happyReduce_2

action_100 _ = happyReduce_3

action_101 _ = happyReduce_4

action_102 _ = happyReduce_5

action_103 _ = happyReduce_6

action_104 _ = happyReduce_7

action_105 _ = happyReduce_8

action_106 _ = happyReduce_9

action_107 _ = happyReduce_10

action_108 (32) = happyShift action_15
action_108 (34) = happyShift action_16
action_108 (41) = happyShift action_17
action_108 (42) = happyShift action_18
action_108 (43) = happyShift action_19
action_108 (45) = happyShift action_20
action_108 (79) = happyShift action_21
action_108 (7) = happyGoto action_125
action_108 _ = happyFail (happyExpListPerState 108)

action_109 (32) = happyShift action_15
action_109 (34) = happyShift action_16
action_109 (41) = happyShift action_17
action_109 (42) = happyShift action_18
action_109 (43) = happyShift action_19
action_109 (45) = happyShift action_20
action_109 (79) = happyShift action_21
action_109 (7) = happyGoto action_124
action_109 _ = happyFail (happyExpListPerState 109)

action_110 (56) = happyShift action_118
action_110 (57) = happyShift action_119
action_110 (58) = happyShift action_120
action_110 (59) = happyShift action_121
action_110 (60) = happyShift action_122
action_110 (61) = happyShift action_123
action_110 (6) = happyGoto action_117
action_110 _ = happyFail (happyExpListPerState 110)

action_111 (32) = happyShift action_15
action_111 (34) = happyShift action_16
action_111 (41) = happyShift action_17
action_111 (42) = happyShift action_18
action_111 (43) = happyShift action_19
action_111 (45) = happyShift action_20
action_111 (79) = happyShift action_21
action_111 (7) = happyGoto action_116
action_111 _ = happyFail (happyExpListPerState 111)

action_112 (32) = happyShift action_15
action_112 (34) = happyShift action_16
action_112 (41) = happyShift action_17
action_112 (42) = happyShift action_18
action_112 (43) = happyShift action_19
action_112 (45) = happyShift action_20
action_112 (79) = happyShift action_21
action_112 (7) = happyGoto action_115
action_112 _ = happyFail (happyExpListPerState 112)

action_113 (32) = happyShift action_15
action_113 (34) = happyShift action_16
action_113 (41) = happyShift action_17
action_113 (42) = happyShift action_18
action_113 (43) = happyShift action_19
action_113 (45) = happyShift action_20
action_113 (79) = happyShift action_21
action_113 (7) = happyGoto action_114
action_113 _ = happyFail (happyExpListPerState 113)

action_114 (29) = happyShift action_23
action_114 (30) = happyShift action_24
action_114 (36) = happyShift action_141
action_114 _ = happyFail (happyExpListPerState 114)

action_115 (29) = happyShift action_23
action_115 (30) = happyShift action_24
action_115 (77) = happyShift action_95
action_115 (79) = happyShift action_96
action_115 (80) = happyShift action_97
action_115 (9) = happyGoto action_140
action_115 _ = happyFail (happyExpListPerState 115)

action_116 (29) = happyShift action_23
action_116 (30) = happyShift action_24
action_116 (80) = happyShift action_139
action_116 _ = happyFail (happyExpListPerState 116)

action_117 (32) = happyShift action_15
action_117 (34) = happyShift action_16
action_117 (41) = happyShift action_17
action_117 (42) = happyShift action_18
action_117 (43) = happyShift action_19
action_117 (45) = happyShift action_20
action_117 (79) = happyShift action_21
action_117 (7) = happyGoto action_138
action_117 _ = happyFail (happyExpListPerState 117)

action_118 _ = happyReduce_11

action_119 _ = happyReduce_12

action_120 _ = happyReduce_13

action_121 _ = happyReduce_14

action_122 _ = happyReduce_15

action_123 _ = happyReduce_16

action_124 (29) = happyShift action_23
action_124 (30) = happyShift action_24
action_124 (36) = happyShift action_137
action_124 _ = happyFail (happyExpListPerState 124)

action_125 (29) = happyShift action_23
action_125 (30) = happyShift action_24
action_125 _ = happyReduce_38

action_126 (29) = happyShift action_23
action_126 (30) = happyShift action_24
action_126 (77) = happyShift action_95
action_126 (79) = happyShift action_96
action_126 (80) = happyShift action_97
action_126 (9) = happyGoto action_136
action_126 _ = happyFail (happyExpListPerState 126)

action_127 (32) = happyShift action_15
action_127 (34) = happyShift action_16
action_127 (41) = happyShift action_17
action_127 (42) = happyShift action_18
action_127 (43) = happyShift action_19
action_127 (45) = happyShift action_20
action_127 (79) = happyShift action_21
action_127 (7) = happyGoto action_135
action_127 _ = happyFail (happyExpListPerState 127)

action_128 (64) = happyShift action_73
action_128 (79) = happyShift action_74
action_128 (13) = happyGoto action_70
action_128 (15) = happyGoto action_71
action_128 (16) = happyGoto action_134
action_128 _ = happyReduce_49

action_129 _ = happyReduce_53

action_130 _ = happyReduce_46

action_131 _ = happyReduce_47

action_132 (36) = happyShift action_133
action_132 _ = happyFail (happyExpListPerState 132)

action_133 (46) = happyShift action_149
action_133 _ = happyFail (happyExpListPerState 133)

action_134 _ = happyReduce_54

action_135 (29) = happyShift action_23
action_135 (30) = happyShift action_24
action_135 (77) = happyShift action_95
action_135 (79) = happyShift action_96
action_135 (80) = happyShift action_97
action_135 (9) = happyGoto action_148
action_135 _ = happyFail (happyExpListPerState 135)

action_136 (36) = happyShift action_147
action_136 _ = happyFail (happyExpListPerState 136)

action_137 (32) = happyShift action_15
action_137 (34) = happyShift action_16
action_137 (41) = happyShift action_17
action_137 (42) = happyShift action_18
action_137 (43) = happyShift action_19
action_137 (45) = happyShift action_20
action_137 (79) = happyShift action_21
action_137 (7) = happyGoto action_146
action_137 _ = happyFail (happyExpListPerState 137)

action_138 (29) = happyShift action_23
action_138 (30) = happyShift action_24
action_138 (77) = happyShift action_95
action_138 (79) = happyShift action_96
action_138 (80) = happyShift action_97
action_138 (9) = happyGoto action_145
action_138 _ = happyFail (happyExpListPerState 138)

action_139 (30) = happyShift action_144
action_139 _ = happyFail (happyExpListPerState 139)

action_140 (40) = happyShift action_143
action_140 _ = happyFail (happyExpListPerState 140)

action_141 (32) = happyShift action_15
action_141 (34) = happyShift action_16
action_141 (41) = happyShift action_17
action_141 (42) = happyShift action_18
action_141 (43) = happyShift action_19
action_141 (45) = happyShift action_20
action_141 (79) = happyShift action_21
action_141 (7) = happyGoto action_142
action_141 _ = happyFail (happyExpListPerState 141)

action_142 (29) = happyShift action_23
action_142 (30) = happyShift action_24
action_142 (77) = happyShift action_95
action_142 (79) = happyShift action_96
action_142 (80) = happyShift action_97
action_142 (9) = happyGoto action_160
action_142 _ = happyFail (happyExpListPerState 142)

action_143 (32) = happyShift action_15
action_143 (34) = happyShift action_16
action_143 (41) = happyShift action_17
action_143 (42) = happyShift action_18
action_143 (43) = happyShift action_19
action_143 (45) = happyShift action_20
action_143 (79) = happyShift action_21
action_143 (7) = happyGoto action_159
action_143 _ = happyFail (happyExpListPerState 143)

action_144 (32) = happyShift action_15
action_144 (34) = happyShift action_16
action_144 (41) = happyShift action_17
action_144 (42) = happyShift action_18
action_144 (43) = happyShift action_19
action_144 (44) = happyShift action_158
action_144 (45) = happyShift action_20
action_144 (79) = happyShift action_21
action_144 (7) = happyGoto action_154
action_144 (10) = happyGoto action_155
action_144 (11) = happyGoto action_156
action_144 (12) = happyGoto action_157
action_144 _ = happyReduce_35

action_145 (36) = happyShift action_153
action_145 _ = happyFail (happyExpListPerState 145)

action_146 (29) = happyShift action_23
action_146 (30) = happyShift action_24
action_146 (77) = happyShift action_95
action_146 (79) = happyShift action_96
action_146 (80) = happyShift action_97
action_146 (9) = happyGoto action_152
action_146 _ = happyFail (happyExpListPerState 146)

action_147 (77) = happyShift action_95
action_147 (79) = happyShift action_96
action_147 (80) = happyShift action_97
action_147 (9) = happyGoto action_151
action_147 _ = happyFail (happyExpListPerState 147)

action_148 _ = happyReduce_40

action_149 (79) = happyShift action_150
action_149 _ = happyFail (happyExpListPerState 149)

action_150 (36) = happyShift action_165
action_150 _ = happyFail (happyExpListPerState 150)

action_151 _ = happyReduce_37

action_152 _ = happyReduce_39

action_153 (77) = happyShift action_95
action_153 (79) = happyShift action_96
action_153 (80) = happyShift action_97
action_153 (9) = happyGoto action_164
action_153 _ = happyFail (happyExpListPerState 153)

action_154 (29) = happyShift action_23
action_154 (30) = happyShift action_24
action_154 _ = happyReduce_32

action_155 (77) = happyShift action_95
action_155 (79) = happyShift action_96
action_155 (80) = happyShift action_97
action_155 (9) = happyGoto action_163
action_155 _ = happyFail (happyExpListPerState 155)

action_156 _ = happyReduce_36

action_157 (31) = happyShift action_162
action_157 _ = happyFail (happyExpListPerState 157)

action_158 _ = happyReduce_31

action_159 (29) = happyShift action_23
action_159 (30) = happyShift action_24
action_159 _ = happyReduce_43

action_160 (36) = happyShift action_161
action_160 _ = happyFail (happyExpListPerState 160)

action_161 (32) = happyShift action_15
action_161 (34) = happyShift action_16
action_161 (41) = happyShift action_17
action_161 (42) = happyShift action_18
action_161 (43) = happyShift action_19
action_161 (44) = happyShift action_158
action_161 (45) = happyShift action_20
action_161 (79) = happyShift action_21
action_161 (7) = happyGoto action_154
action_161 (10) = happyGoto action_155
action_161 (11) = happyGoto action_168
action_161 _ = happyFail (happyExpListPerState 161)

action_162 _ = happyReduce_42

action_163 (36) = happyShift action_167
action_163 _ = happyReduce_33

action_164 _ = happyReduce_41

action_165 (46) = happyShift action_166
action_165 _ = happyFail (happyExpListPerState 165)

action_166 (79) = happyShift action_170
action_166 _ = happyFail (happyExpListPerState 166)

action_167 (32) = happyShift action_15
action_167 (34) = happyShift action_16
action_167 (41) = happyShift action_17
action_167 (42) = happyShift action_18
action_167 (43) = happyShift action_19
action_167 (44) = happyShift action_158
action_167 (45) = happyShift action_20
action_167 (79) = happyShift action_21
action_167 (7) = happyGoto action_154
action_167 (10) = happyGoto action_155
action_167 (11) = happyGoto action_169
action_167 _ = happyFail (happyExpListPerState 167)

action_168 _ = happyReduce_44

action_169 _ = happyReduce_34

action_170 _ = happyReduce_48

happyReduce_1 = happySpecReduce_1  4 happyReduction_1
happyReduction_1 (HappyAbsSyn4  happy_var_1)
	 =  HappyAbsSyn4
		 (let p = happy_var_1 in P (reverse (types p)) (reverse (globals p)) (reverse (functions p)) (reverse (externs p))
	)
happyReduction_1 _  = notHappyAtAll 

happyReduce_2 = happySpecReduce_1  5 happyReduction_2
happyReduction_2 _
	 =  HappyAbsSyn5
		 (Add
	)

happyReduce_3 = happySpecReduce_1  5 happyReduction_3
happyReduction_3 _
	 =  HappyAbsSyn5
		 (Sub
	)

happyReduce_4 = happySpecReduce_1  5 happyReduction_4
happyReduction_4 _
	 =  HappyAbsSyn5
		 (Mul
	)

happyReduce_5 = happySpecReduce_1  5 happyReduction_5
happyReduction_5 _
	 =  HappyAbsSyn5
		 (Shl
	)

happyReduce_6 = happySpecReduce_1  5 happyReduction_6
happyReduction_6 _
	 =  HappyAbsSyn5
		 (Lshr
	)

happyReduce_7 = happySpecReduce_1  5 happyReduction_7
happyReduction_7 _
	 =  HappyAbsSyn5
		 (Ashr
	)

happyReduce_8 = happySpecReduce_1  5 happyReduction_8
happyReduction_8 _
	 =  HappyAbsSyn5
		 (And
	)

happyReduce_9 = happySpecReduce_1  5 happyReduction_9
happyReduction_9 _
	 =  HappyAbsSyn5
		 (Or
	)

happyReduce_10 = happySpecReduce_1  5 happyReduction_10
happyReduction_10 _
	 =  HappyAbsSyn5
		 (Xor
	)

happyReduce_11 = happySpecReduce_1  6 happyReduction_11
happyReduction_11 _
	 =  HappyAbsSyn6
		 (Eq
	)

happyReduce_12 = happySpecReduce_1  6 happyReduction_12
happyReduction_12 _
	 =  HappyAbsSyn6
		 (Neq
	)

happyReduce_13 = happySpecReduce_1  6 happyReduction_13
happyReduction_13 _
	 =  HappyAbsSyn6
		 (Lt
	)

happyReduce_14 = happySpecReduce_1  6 happyReduction_14
happyReduction_14 _
	 =  HappyAbsSyn6
		 (Le
	)

happyReduce_15 = happySpecReduce_1  6 happyReduction_15
happyReduction_15 _
	 =  HappyAbsSyn6
		 (Gt
	)

happyReduce_16 = happySpecReduce_1  6 happyReduction_16
happyReduction_16 _
	 =  HappyAbsSyn6
		 (Ge
	)

happyReduce_17 = happySpecReduce_1  7 happyReduction_17
happyReduction_17 _
	 =  HappyAbsSyn7
		 (Void
	)

happyReduce_18 = happySpecReduce_1  7 happyReduction_18
happyReduction_18 _
	 =  HappyAbsSyn7
		 (I1
	)

happyReduce_19 = happySpecReduce_1  7 happyReduction_19
happyReduction_19 _
	 =  HappyAbsSyn7
		 (I8
	)

happyReduce_20 = happySpecReduce_1  7 happyReduction_20
happyReduction_20 _
	 =  HappyAbsSyn7
		 (I64
	)

happyReduce_21 = happySpecReduce_2  7 happyReduction_21
happyReduction_21 _
	(HappyAbsSyn7  happy_var_1)
	 =  HappyAbsSyn7
		 (Ptr happy_var_1
	)
happyReduction_21 _ _  = notHappyAtAll 

happyReduce_22 = happyReduce 5 7 happyReduction_22
happyReduction_22 (_ `HappyStk`
	(HappyAbsSyn7  happy_var_4) `HappyStk`
	_ `HappyStk`
	(HappyTerminal (TokLiteral happy_var_2)) `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn7
		 (Array happy_var_2 happy_var_4
	) `HappyStk` happyRest

happyReduce_23 = happySpecReduce_3  7 happyReduction_23
happyReduction_23 _
	(HappyAbsSyn8  happy_var_2)
	_
	 =  HappyAbsSyn7
		 (Struct happy_var_2
	)
happyReduction_23 _ _ _  = notHappyAtAll 

happyReduce_24 = happyReduce 4 7 happyReduction_24
happyReduction_24 (_ `HappyStk`
	(HappyAbsSyn8  happy_var_3) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn7  happy_var_1) `HappyStk`
	happyRest)
	 = HappyAbsSyn7
		 (Fun happy_var_3 happy_var_1
	) `HappyStk` happyRest

happyReduce_25 = happySpecReduce_1  7 happyReduction_25
happyReduction_25 (HappyTerminal (TokLID happy_var_1))
	 =  HappyAbsSyn7
		 (Named happy_var_1
	)
happyReduction_25 _  = notHappyAtAll 

happyReduce_26 = happySpecReduce_3  8 happyReduction_26
happyReduction_26 (HappyAbsSyn8  happy_var_3)
	_
	(HappyAbsSyn7  happy_var_1)
	 =  HappyAbsSyn8
		 (happy_var_1 : happy_var_3
	)
happyReduction_26 _ _ _  = notHappyAtAll 

happyReduce_27 = happySpecReduce_1  8 happyReduction_27
happyReduction_27 (HappyAbsSyn7  happy_var_1)
	 =  HappyAbsSyn8
		 ([happy_var_1]
	)
happyReduction_27 _  = notHappyAtAll 

happyReduce_28 = happySpecReduce_1  9 happyReduction_28
happyReduction_28 (HappyTerminal (TokLiteral happy_var_1))
	 =  HappyAbsSyn9
		 (Const happy_var_1
	)
happyReduction_28 _  = notHappyAtAll 

happyReduce_29 = happySpecReduce_1  9 happyReduction_29
happyReduction_29 (HappyTerminal (TokLID happy_var_1))
	 =  HappyAbsSyn9
		 (Uid happy_var_1
	)
happyReduction_29 _  = notHappyAtAll 

happyReduce_30 = happySpecReduce_1  9 happyReduction_30
happyReduction_30 (HappyTerminal (TokGID happy_var_1))
	 =  HappyAbsSyn9
		 (Gid happy_var_1
	)
happyReduction_30 _  = notHappyAtAll 

happyReduce_31 = happySpecReduce_1  10 happyReduction_31
happyReduction_31 _
	 =  HappyAbsSyn7
		 (I32
	)

happyReduce_32 = happySpecReduce_1  10 happyReduction_32
happyReduction_32 (HappyAbsSyn7  happy_var_1)
	 =  HappyAbsSyn7
		 (happy_var_1
	)
happyReduction_32 _  = notHappyAtAll 

happyReduce_33 = happySpecReduce_2  11 happyReduction_33
happyReduction_33 (HappyAbsSyn9  happy_var_2)
	(HappyAbsSyn7  happy_var_1)
	 =  HappyAbsSyn11
		 ([(happy_var_1, happy_var_2)]
	)
happyReduction_33 _ _  = notHappyAtAll 

happyReduce_34 = happyReduce 4 11 happyReduction_34
happyReduction_34 ((HappyAbsSyn11  happy_var_4) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn9  happy_var_2) `HappyStk`
	(HappyAbsSyn7  happy_var_1) `HappyStk`
	happyRest)
	 = HappyAbsSyn11
		 ((happy_var_1, happy_var_2) : happy_var_4
	) `HappyStk` happyRest

happyReduce_35 = happySpecReduce_0  12 happyReduction_35
happyReduction_35  =  HappyAbsSyn11
		 ([]
	)

happyReduce_36 = happySpecReduce_1  12 happyReduction_36
happyReduction_36 (HappyAbsSyn11  happy_var_1)
	 =  HappyAbsSyn11
		 (happy_var_1
	)
happyReduction_36 _  = notHappyAtAll 

happyReduce_37 = happyReduce 7 13 happyReduction_37
happyReduction_37 ((HappyAbsSyn9  happy_var_7) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn9  happy_var_5) `HappyStk`
	(HappyAbsSyn7  happy_var_4) `HappyStk`
	(HappyAbsSyn5  happy_var_3) `HappyStk`
	_ `HappyStk`
	(HappyTerminal (TokLID happy_var_1)) `HappyStk`
	happyRest)
	 = HappyAbsSyn13
		 (Bin happy_var_1 happy_var_3 happy_var_4 happy_var_5 happy_var_7
	) `HappyStk` happyRest

happyReduce_38 = happyReduce 4 13 happyReduction_38
happyReduction_38 ((HappyAbsSyn7  happy_var_4) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	(HappyTerminal (TokLID happy_var_1)) `HappyStk`
	happyRest)
	 = HappyAbsSyn13
		 (Alloca happy_var_1 happy_var_4
	) `HappyStk` happyRest

happyReduce_39 = happyReduce 7 13 happyReduction_39
happyReduction_39 ((HappyAbsSyn9  happy_var_7) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn7  happy_var_4) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	(HappyTerminal (TokLID happy_var_1)) `HappyStk`
	happyRest)
	 = HappyAbsSyn13
		 (Load happy_var_1 happy_var_4 happy_var_7
	) `HappyStk` happyRest

happyReduce_40 = happyReduce 6 13 happyReduction_40
happyReduction_40 ((HappyAbsSyn9  happy_var_6) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn9  happy_var_3) `HappyStk`
	(HappyAbsSyn7  happy_var_2) `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn13
		 (Store happy_var_2 happy_var_3 happy_var_6
	) `HappyStk` happyRest

happyReduce_41 = happyReduce 8 13 happyReduction_41
happyReduction_41 ((HappyAbsSyn9  happy_var_8) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn9  happy_var_6) `HappyStk`
	(HappyAbsSyn7  happy_var_5) `HappyStk`
	(HappyAbsSyn6  happy_var_4) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	(HappyTerminal (TokLID happy_var_1)) `HappyStk`
	happyRest)
	 = HappyAbsSyn13
		 (Icmp happy_var_1 happy_var_4 happy_var_5 happy_var_6 happy_var_8
	) `HappyStk` happyRest

happyReduce_42 = happyReduce 8 13 happyReduction_42
happyReduction_42 (_ `HappyStk`
	(HappyAbsSyn11  happy_var_7) `HappyStk`
	_ `HappyStk`
	(HappyTerminal (TokGID happy_var_5)) `HappyStk`
	(HappyAbsSyn7  happy_var_4) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	(HappyTerminal (TokLID happy_var_1)) `HappyStk`
	happyRest)
	 = HappyAbsSyn13
		 (Call happy_var_1 happy_var_4 happy_var_5 happy_var_7
	) `HappyStk` happyRest

happyReduce_43 = happyReduce 7 13 happyReduction_43
happyReduction_43 ((HappyAbsSyn7  happy_var_7) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn9  happy_var_5) `HappyStk`
	(HappyAbsSyn7  happy_var_4) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	(HappyTerminal (TokLID happy_var_1)) `HappyStk`
	happyRest)
	 = HappyAbsSyn13
		 (Bitcast happy_var_1 happy_var_4 happy_var_5 happy_var_7
	) `HappyStk` happyRest

happyReduce_44 = happyReduce 9 13 happyReduction_44
happyReduction_44 ((HappyAbsSyn11  happy_var_9) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn9  happy_var_7) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn7  happy_var_4) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	(HappyTerminal (TokLID happy_var_1)) `HappyStk`
	happyRest)
	 = HappyAbsSyn13
		 (Gep happy_var_1 happy_var_4 happy_var_7 (map snd happy_var_9)
	) `HappyStk` happyRest

happyReduce_45 = happySpecReduce_2  14 happyReduction_45
happyReduction_45 _
	_
	 =  HappyAbsSyn14
		 (Ret Void Nothing
	)

happyReduce_46 = happySpecReduce_3  14 happyReduction_46
happyReduction_46 (HappyAbsSyn9  happy_var_3)
	(HappyAbsSyn7  happy_var_2)
	_
	 =  HappyAbsSyn14
		 (Ret happy_var_2 (Just happy_var_3)
	)
happyReduction_46 _ _ _  = notHappyAtAll 

happyReduce_47 = happySpecReduce_3  14 happyReduction_47
happyReduction_47 (HappyTerminal (TokLID happy_var_3))
	_
	_
	 =  HappyAbsSyn14
		 (Bra happy_var_3
	)
happyReduction_47 _ _ _  = notHappyAtAll 

happyReduce_48 = happyReduce 9 14 happyReduction_48
happyReduction_48 ((HappyTerminal (TokLID happy_var_9)) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	(HappyTerminal (TokLID happy_var_6)) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn9  happy_var_3) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn14
		 (CBr happy_var_3 happy_var_6 happy_var_9
	) `HappyStk` happyRest

happyReduce_49 = happySpecReduce_0  15 happyReduction_49
happyReduction_49  =  HappyAbsSyn15
		 ([]
	)

happyReduce_50 = happySpecReduce_2  15 happyReduction_50
happyReduction_50 (HappyAbsSyn15  happy_var_2)
	(HappyAbsSyn13  happy_var_1)
	 =  HappyAbsSyn15
		 (happy_var_1 : happy_var_2
	)
happyReduction_50 _ _  = notHappyAtAll 

happyReduce_51 = happySpecReduce_2  16 happyReduction_51
happyReduction_51 (HappyAbsSyn14  happy_var_2)
	(HappyAbsSyn15  happy_var_1)
	 =  HappyAbsSyn16
		 ((happy_var_1, happy_var_2)
	)
happyReduction_51 _ _  = notHappyAtAll 

happyReduce_52 = happySpecReduce_0  17 happyReduction_52
happyReduction_52  =  HappyAbsSyn17
		 ([]
	)

happyReduce_53 = happySpecReduce_3  17 happyReduction_53
happyReduction_53 (HappyAbsSyn16  happy_var_3)
	_
	(HappyAbsSyn18  happy_var_1)
	 =  HappyAbsSyn17
		 ([(happy_var_1, happy_var_3)]
	)
happyReduction_53 _ _ _  = notHappyAtAll 

happyReduce_54 = happyReduce 4 17 happyReduction_54
happyReduction_54 ((HappyAbsSyn16  happy_var_4) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn18  happy_var_2) `HappyStk`
	(HappyAbsSyn17  happy_var_1) `HappyStk`
	happyRest)
	 = HappyAbsSyn17
		 ((happy_var_2, happy_var_4) : happy_var_1
	) `HappyStk` happyRest

happyReduce_55 = happySpecReduce_1  18 happyReduction_55
happyReduction_55 (HappyTerminal (TokID happy_var_1))
	 =  HappyAbsSyn18
		 (happy_var_1
	)
happyReduction_55 _  = notHappyAtAll 

happyReduce_56 = happySpecReduce_1  18 happyReduction_56
happyReduction_56 (HappyTerminal (TokLiteral happy_var_1))
	 =  HappyAbsSyn18
		 (show happy_var_1
	)
happyReduction_56 _  = notHappyAtAll 

happyReduce_57 = happySpecReduce_1  19 happyReduction_57
happyReduction_57 (HappyAbsSyn17  happy_var_1)
	 =  HappyAbsSyn17
		 (reverse happy_var_1
	)
happyReduction_57 _  = notHappyAtAll 

happyReduce_58 = happySpecReduce_2  20 happyReduction_58
happyReduction_58 (HappyTerminal (TokLID happy_var_2))
	(HappyAbsSyn7  happy_var_1)
	 =  HappyAbsSyn20
		 ((happy_var_1, happy_var_2)
	)
happyReduction_58 _ _  = notHappyAtAll 

happyReduce_59 = happySpecReduce_0  21 happyReduction_59
happyReduction_59  =  HappyAbsSyn21
		 ([]
	)

happyReduce_60 = happySpecReduce_1  21 happyReduction_60
happyReduction_60 (HappyAbsSyn20  happy_var_1)
	 =  HappyAbsSyn21
		 ([happy_var_1]
	)
happyReduction_60 _  = notHappyAtAll 

happyReduce_61 = happySpecReduce_3  21 happyReduction_61
happyReduction_61 (HappyAbsSyn21  happy_var_3)
	_
	(HappyAbsSyn20  happy_var_1)
	 =  HappyAbsSyn21
		 (happy_var_1 : happy_var_3
	)
happyReduction_61 _ _ _  = notHappyAtAll 

happyReduce_62 = happySpecReduce_1  22 happyReduction_62
happyReduction_62 _
	 =  HappyAbsSyn22
		 (INull
	)

happyReduce_63 = happySpecReduce_1  22 happyReduction_63
happyReduction_63 (HappyTerminal (TokGID happy_var_1))
	 =  HappyAbsSyn22
		 (IGid happy_var_1
	)
happyReduction_63 _  = notHappyAtAll 

happyReduce_64 = happySpecReduce_1  22 happyReduction_64
happyReduction_64 (HappyTerminal (TokLiteral happy_var_1))
	 =  HappyAbsSyn22
		 (IInt happy_var_1
	)
happyReduction_64 _  = notHappyAtAll 

happyReduce_65 = happySpecReduce_3  22 happyReduction_65
happyReduction_65 _
	(HappyAbsSyn23  happy_var_2)
	_
	 =  HappyAbsSyn22
		 (IArray happy_var_2
	)
happyReduction_65 _ _ _  = notHappyAtAll 

happyReduce_66 = happySpecReduce_3  22 happyReduction_66
happyReduction_66 _
	(HappyAbsSyn23  happy_var_2)
	_
	 =  HappyAbsSyn22
		 (IStruct happy_var_2
	)
happyReduction_66 _ _ _  = notHappyAtAll 

happyReduce_67 = happySpecReduce_0  23 happyReduction_67
happyReduction_67  =  HappyAbsSyn23
		 ([]
	)

happyReduce_68 = happySpecReduce_2  23 happyReduction_68
happyReduction_68 (HappyAbsSyn22  happy_var_2)
	(HappyAbsSyn7  happy_var_1)
	 =  HappyAbsSyn23
		 ([(happy_var_1, happy_var_2)]
	)
happyReduction_68 _ _  = notHappyAtAll 

happyReduce_69 = happyReduce 4 23 happyReduction_69
happyReduction_69 ((HappyAbsSyn23  happy_var_4) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn22  happy_var_2) `HappyStk`
	(HappyAbsSyn7  happy_var_1) `HappyStk`
	happyRest)
	 = HappyAbsSyn23
		 ((happy_var_1, happy_var_2) : happy_var_4
	) `HappyStk` happyRest

happyReduce_70 = happySpecReduce_0  24 happyReduction_70
happyReduction_70  =  HappyAbsSyn4
		 (P [] [] [] []
	)

happyReduce_71 = happySpecReduce_2  24 happyReduction_71
happyReduction_71 (HappyAbsSyn25  happy_var_2)
	(HappyAbsSyn4  happy_var_1)
	 =  HappyAbsSyn4
		 (let p = happy_var_1 in p { types = happy_var_2 : types p }
	)
happyReduction_71 _ _  = notHappyAtAll 

happyReduce_72 = happySpecReduce_2  24 happyReduction_72
happyReduction_72 (HappyAbsSyn26  happy_var_2)
	(HappyAbsSyn4  happy_var_1)
	 =  HappyAbsSyn4
		 (let p = happy_var_1 in p { globals = happy_var_2 : globals p }
	)
happyReduction_72 _ _  = notHappyAtAll 

happyReduce_73 = happySpecReduce_2  24 happyReduction_73
happyReduction_73 (HappyAbsSyn27  happy_var_2)
	(HappyAbsSyn4  happy_var_1)
	 =  HappyAbsSyn4
		 (let p = happy_var_1 in p { functions = happy_var_2 : functions p }
	)
happyReduction_73 _ _  = notHappyAtAll 

happyReduce_74 = happySpecReduce_2  24 happyReduction_74
happyReduction_74 (HappyAbsSyn25  happy_var_2)
	(HappyAbsSyn4  happy_var_1)
	 =  HappyAbsSyn4
		 (let p = happy_var_1 in p { externs = happy_var_2 : externs p }
	)
happyReduction_74 _ _  = notHappyAtAll 

happyReduce_75 = happyReduce 4 25 happyReduction_75
happyReduction_75 ((HappyAbsSyn7  happy_var_4) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	(HappyTerminal (TokLID happy_var_1)) `HappyStk`
	happyRest)
	 = HappyAbsSyn25
		 ((happy_var_1, happy_var_4)
	) `HappyStk` happyRest

happyReduce_76 = happyReduce 5 26 happyReduction_76
happyReduction_76 ((HappyAbsSyn22  happy_var_5) `HappyStk`
	(HappyAbsSyn7  happy_var_4) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	(HappyTerminal (TokGID happy_var_1)) `HappyStk`
	happyRest)
	 = HappyAbsSyn26
		 ((happy_var_1, happy_var_4, happy_var_5)
	) `HappyStk` happyRest

happyReduce_77 = happyReduce 10 27 happyReduction_77
happyReduction_77 (_ `HappyStk`
	(HappyAbsSyn17  happy_var_9) `HappyStk`
	(HappyAbsSyn16  happy_var_8) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn21  happy_var_5) `HappyStk`
	_ `HappyStk`
	(HappyTerminal (TokGID happy_var_3)) `HappyStk`
	(HappyAbsSyn7  happy_var_2) `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn27
		 ((happy_var_3, (happy_var_5, happy_var_2, (happy_var_8, happy_var_9)))
	) `HappyStk` happyRest

happyReduce_78 = happyReduce 6 28 happyReduction_78
happyReduction_78 (_ `HappyStk`
	(HappyAbsSyn8  happy_var_5) `HappyStk`
	_ `HappyStk`
	(HappyTerminal (TokGID happy_var_3)) `HappyStk`
	(HappyAbsSyn7  happy_var_2) `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn25
		 ((happy_var_3, Fun happy_var_5 happy_var_2)
	) `HappyStk` happyRest

happyReduce_79 = happyReduce 5 28 happyReduction_79
happyReduction_79 ((HappyAbsSyn7  happy_var_5) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	(HappyTerminal (TokGID happy_var_1)) `HappyStk`
	happyRest)
	 = HappyAbsSyn25
		 ((happy_var_1, happy_var_5)
	) `HappyStk` happyRest

happyNewToken action sts stk [] =
	action 81 81 notHappyAtAll (HappyState action) sts stk []

happyNewToken action sts stk (tk:tks) =
	let cont i = action i i tk (HappyState action) sts stk tks in
	case tk of {
	TokStar -> cont 29;
	TokLParen -> cont 30;
	TokRParen -> cont 31;
	TokLBracket -> cont 32;
	TokRBracket -> cont 33;
	TokLBrace -> cont 34;
	TokRBrace -> cont 35;
	TokComma -> cont 36;
	TokEquals -> cont 37;
	TokColon -> cont 38;
	TokTimes -> cont 39;
	TokTo -> cont 40;
	TokVoid -> cont 41;
	TokI1 -> cont 42;
	TokI8 -> cont 43;
	TokI32 -> cont 44;
	TokI64 -> cont 45;
	TokLabel -> cont 46;
	TokAdd -> cont 47;
	TokSub -> cont 48;
	TokMul -> cont 49;
	TokShl -> cont 50;
	TokLshr -> cont 51;
	TokAshr -> cont 52;
	TokAnd -> cont 53;
	TokOr -> cont 54;
	TokXor -> cont 55;
	TokEq -> cont 56;
	TokNeq -> cont 57;
	TokLt -> cont 58;
	TokLe -> cont 59;
	TokGt -> cont 60;
	TokGe -> cont 61;
	TokAlloca -> cont 62;
	TokLoad -> cont 63;
	TokStore -> cont 64;
	TokIcmp -> cont 65;
	TokCall -> cont 66;
	TokBitcast -> cont 67;
	TokGep -> cont 68;
	TokRet -> cont 69;
	TokBr -> cont 70;
	TokType -> cont 71;
	TokDefine -> cont 72;
	TokDeclare -> cont 73;
	TokExternal -> cont 74;
	TokGlobal -> cont 75;
	TokNull -> cont 76;
	TokLiteral happy_dollar_dollar -> cont 77;
	TokID happy_dollar_dollar -> cont 78;
	TokLID happy_dollar_dollar -> cont 79;
	TokGID happy_dollar_dollar -> cont 80;
	_ -> happyError' ((tk:tks), [])
	}

happyError_ explist 81 tk tks = happyError' (tks, explist)
happyError_ explist _ tk tks = happyError' ((tk:tks), explist)

newtype HappyIdentity a = HappyIdentity a
happyIdentity = HappyIdentity
happyRunIdentity (HappyIdentity a) = a

instance Functor HappyIdentity where
    fmap f (HappyIdentity a) = HappyIdentity (f a)

instance Applicative HappyIdentity where
    pure  = HappyIdentity
    (<*>) = ap
instance Monad HappyIdentity where
    return = pure
    (HappyIdentity p) >>= q = q p

happyThen :: () => HappyIdentity a -> (a -> HappyIdentity b) -> HappyIdentity b
happyThen = (>>=)
happyReturn :: () => a -> HappyIdentity a
happyReturn = (return)
happyThen1 m k tks = (>>=) m (\a -> k a tks)
happyReturn1 :: () => a -> b -> HappyIdentity a
happyReturn1 = \a tks -> (return) a
happyError' :: () => ([(Token)], [String]) -> HappyIdentity a
happyError' = HappyIdentity . (\(tokens, _) -> (error . ("Parse error: " ++) . show) tokens)
parse tks = happyRunIdentity happySomeParser where
 happySomeParser = happyThen (happyParse action_0 tks) (\x -> case x of {HappyAbsSyn4 z -> happyReturn z; _other -> notHappyAtAll })

happySeq = happyDontSeq



{-# LINE 1 "templates\GenericTemplate.hs" #-}
{-# LINE 1 "templates\\GenericTemplate.hs" #-}
{-# LINE 1 "<built-in>" #-}
{-# LINE 1 "<command-line>" #-}
{-# LINE 8 "<command-line>" #-}
{-# LINE 1 "C:\\Program Files\\ghc\\ghc-8.2.2\\lib/include\\ghcversion.h" #-}















{-# LINE 8 "<command-line>" #-}
{-# LINE 1 "C:\\Users\\Garrett\\AppData\\Local\\Temp\\ghc12432_0\\ghc_2.h" #-}






































































































































































































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
