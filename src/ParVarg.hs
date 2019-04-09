{-# OPTIONS_GHC -w #-}
{-# OPTIONS_GHC -fno-warn-incomplete-patterns -fno-warn-overlapping-patterns #-}
module ParVarg where
import AbsVarg
import LexVarg
import ErrM
import qualified Data.Array as Happy_Data_Array
import qualified Data.Bits as Bits
import Control.Applicative(Applicative(..))
import Control.Monad (ap)

-- parser produced by Happy Version 1.19.9

data HappyAbsSyn 
	= HappyTerminal (Token)
	| HappyErrorToken Int
	| HappyAbsSyn4 (Integer)
	| HappyAbsSyn5 (Double)
	| HappyAbsSyn6 (UIdent)
	| HappyAbsSyn7 (LIdent)
	| HappyAbsSyn8 (MFun)
	| HappyAbsSyn9 (ProgramDef)
	| HappyAbsSyn10 ([ClassDef])
	| HappyAbsSyn11 (ImportDef)
	| HappyAbsSyn12 ([ImportDef])
	| HappyAbsSyn13 (TypeParam)
	| HappyAbsSyn14 ([ConstrTypeParam])
	| HappyAbsSyn15 (ConstrTypeParam)
	| HappyAbsSyn16 ([ArgDef])
	| HappyAbsSyn17 (ArgDef)
	| HappyAbsSyn18 (PrimType)
	| HappyAbsSyn19 (TypeDef)
	| HappyAbsSyn21 ([PrimType])
	| HappyAbsSyn22 (ClassType)
	| HappyAbsSyn23 ([ClassType])
	| HappyAbsSyn24 (ClassDef)
	| HappyAbsSyn25 (IsImplementing)
	| HappyAbsSyn26 (IsDeriving)
	| HappyAbsSyn27 ([ClassModifier])
	| HappyAbsSyn28 (ClassModifier)
	| HappyAbsSyn29 (ClassContents)
	| HappyAbsSyn30 (MemberDef)
	| HappyAbsSyn31 ([MemberDef])
	| HappyAbsSyn32 (FunDef)
	| HappyAbsSyn33 ([FunDef])
	| HappyAbsSyn34 ([FunctionModifier])
	| HappyAbsSyn35 (FunctionModifier)
	| HappyAbsSyn36 (ClassField)
	| HappyAbsSyn37 ([ClassField])
	| HappyAbsSyn38 (FieldModifier)
	| HappyAbsSyn39 (Expr)
	| HappyAbsSyn40 ([AsDef])
	| HappyAbsSyn41 (AsDef)
	| HappyAbsSyn42 ([MatchClause])
	| HappyAbsSyn43 (MatchClause)
	| HappyAbsSyn44 (Functorial)
	| HappyAbsSyn45 (Arg)
	| HappyAbsSyn46 ([Arg])

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
 action_170,
 action_171,
 action_172,
 action_173,
 action_174,
 action_175,
 action_176,
 action_177,
 action_178,
 action_179,
 action_180,
 action_181,
 action_182,
 action_183,
 action_184,
 action_185,
 action_186,
 action_187,
 action_188,
 action_189,
 action_190,
 action_191,
 action_192,
 action_193,
 action_194,
 action_195,
 action_196,
 action_197,
 action_198,
 action_199,
 action_200,
 action_201,
 action_202,
 action_203,
 action_204,
 action_205 :: () => Int -> ({-HappyReduction (Err) = -}
	   Int 
	-> (Token)
	-> HappyState (Token) (HappyStk HappyAbsSyn -> [(Token)] -> (Err) HappyAbsSyn)
	-> [HappyState (Token) (HappyStk HappyAbsSyn -> [(Token)] -> (Err) HappyAbsSyn)] 
	-> HappyStk HappyAbsSyn 
	-> [(Token)] -> (Err) HappyAbsSyn)

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
 happyReduce_79,
 happyReduce_80,
 happyReduce_81,
 happyReduce_82,
 happyReduce_83,
 happyReduce_84,
 happyReduce_85,
 happyReduce_86,
 happyReduce_87,
 happyReduce_88,
 happyReduce_89,
 happyReduce_90,
 happyReduce_91,
 happyReduce_92,
 happyReduce_93,
 happyReduce_94,
 happyReduce_95,
 happyReduce_96,
 happyReduce_97,
 happyReduce_98,
 happyReduce_99,
 happyReduce_100,
 happyReduce_101,
 happyReduce_102,
 happyReduce_103,
 happyReduce_104,
 happyReduce_105,
 happyReduce_106,
 happyReduce_107,
 happyReduce_108,
 happyReduce_109,
 happyReduce_110,
 happyReduce_111,
 happyReduce_112 :: () => ({-HappyReduction (Err) = -}
	   Int 
	-> (Token)
	-> HappyState (Token) (HappyStk HappyAbsSyn -> [(Token)] -> (Err) HappyAbsSyn)
	-> [HappyState (Token) (HappyStk HappyAbsSyn -> [(Token)] -> (Err) HappyAbsSyn)] 
	-> HappyStk HappyAbsSyn 
	-> [(Token)] -> (Err) HappyAbsSyn)

happyExpList :: Happy_Data_Array.Array Int Int
happyExpList = Happy_Data_Array.listArray (0,751) ([0,0,0,0,0,0,0,0,0,0,0,0,0,256,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,4,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,16,0,0,0,32,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,8194,170,0,0,0,0,0,0,0,0,0,0,0,0,0,16384,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1024,0,0,0,0,0,0,512,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,32768,0,0,0,0,0,0,128,0,0,0,0,0,0,0,0,8,0,0,0,0,0,16384,0,0,0,0,2048,2048,0,6,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,32768,0,0,0,0,0,0,0,0,6144,0,0,0,0,0,0,0,0,0,0,0,0,2304,1024,0,0,0,2,0,0,768,0,0,0,16,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,32768,0,0,0,0,0,0,0,16,0,0,0,0,0,0,0,0,0,0,0,0,16384,0,0,0,0,0,0,0,2,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,8192,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,8,0,0,3072,0,0,0,1024,0,0,0,0,0,0,1024,0,0,0,0,0,0,0,0,0,16,0,0,0,0,0,0,128,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,64,512,0,0,0,0,0,0,4096,0,0,0,0,0,0,8192,0,0,0,512,0,0,0,3,0,0,256,0,0,32768,1,0,0,32768,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,18432,8192,0,0,0,16,0,0,6144,0,0,0,16,0,0,0,0,0,0,0,0,0,1536,0,0,0,0,4,0,768,0,0,0,0,2,0,384,0,0,0,0,0,0,0,0,0,0,0,0,0,32,0,0,0,0,2048,0,0,0,0,0,0,0,0,1,0,0,0,16,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,32,0,0,12288,0,0,0,0,128,0,0,0,0,0,0,64,0,0,0,0,0,0,0,0,512,0,0,0,0,0,0,32,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,64,0,0,0,0,0,0,0,0,0,0,0,0,0,0,2432,65,0,0,0,0,0,0,0,2,0,0,0,0,0,0,0,0,0,0,0,0,2048,0,0,0,0,0,8192,32769,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,2048,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,32768,0,0,0,0,0,0,0,0,0,0,512,2,0,0,2,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,16384,0,0,0,32,2048,0,12288,0,0,0,0,1,0,0,0,0,0,8,0,0,3072,0,0,0,1024,0,0,0,0,0,0,2,0,0,768,0,0,0,0,0,0,0,0,0,32768,0,16656,36928,496,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,2048,0,0,0,0,0,0,8,0,0,0,0,0,34048,49,0,0,0,0,0,2112,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,2,1096,16641,1986,0,0,0,0,0,0,0,0,0,32768,0,16656,36928,500,0,0,16384,0,8328,18464,248,0,0,8192,0,4164,9232,124,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,512,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,256,0,0,0,0,0,0,16,0,0,0,0,2048,0,0,0,0,0,0,0,64,0,0,0,0,4,2176,33282,3972,0,0,0,4,0,0,0,0,0,0,0,0,0,0,0,0,32768,0,16,36864,496,0,0,16384,0,8,18432,248,0,0,8192,0,4,9216,124,0,0,4096,0,2,4608,62,0,0,2048,0,1,2304,31,0,0,1024,32768,0,33920,15,0,0,512,16384,0,49728,7,0,0,256,8192,0,57632,3,0,0,128,4096,0,61584,1,0,0,64,2048,0,63560,0,0,0,32,0,0,28708,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,2,1088,16641,1986,0,0,0,0,0,0,0,0,0,0,20,0,0,0,0,0,0,10,0,0,0,0,0,0,5,0,0,0,0,0,32768,2,0,0,0,0,0,16384,1,0,0,0,0,0,4096,2,0,0,0,0,0,2048,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,16448,0,0,16384,0,0,0,0,0,0,0,0,0,0,0,0,0,256,0,0,0,4096,0,0,0,0,0,0,4,2176,33282,3972,0,0,0,0,0,0,512,0,0,0,1,33312,8320,993,0,0,0,0,0,0,4,0,0,16384,0,8328,18464,248,0,0,0,0,256,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1024,32768,520,33922,15,0,0,0,0,4096,0,0,0,0,256,0,0,32768,1,0,0,0,32,0,0,0,0,0,64,34816,8224,63560,0,0,0,0,0,0,0,0,0,0,16,8704,2056,15890,0,0,0,512,0,0,0,0,0,0,0,0,0,64,0,0,0,1024,0,0,0,0,0,0,1,33312,8320,993,0,0,0,0,0,0,0,0,0,16384,0,8328,18464,248,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,2048,0,1041,2308,31,0,0,2048,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	])

{-# NOINLINE happyExpListPerState #-}
happyExpListPerState st =
    token_strs_expected
  where token_strs = ["error","%dummy","%start_pProgramDef","Integer","Double","UIdent","LIdent","MFun","ProgramDef","ListClassDef","ImportDef","ListImportDef","TypeParam","ListConstrTypeParam","ConstrTypeParam","ListArgDef","ArgDef","PrimType","TypeDef","TypeDef1","ListPrimType","ClassType","ListClassType","ClassDef","IsImplementing","IsDeriving","ListClassModifier","ClassModifier","ClassContents","MemberDef","ListMemberDef","FunDef","ListFunDef","ListFunctionModifier","FunctionModifier","ClassField","ListClassField","FieldModifier","Expr","ListAsDef","AsDef","ListMatchClause","MatchClause","Functorial","Arg","ListArg","Expr5","Expr1","Expr2","Expr3","Expr4","Expr6","'('","')'","'*'","'+'","','","'-'","'->'","'/'","':'","';'","'<'","'<='","'='","'=='","'=>'","'>'","'>='","'['","'\\\\'","']'","'^'","'_'","'abstract'","'as'","'class'","'define'","'deriving'","'else'","'final | unique'","'function'","'has'","'if'","'implement'","'implementing'","'import'","'in'","'interface'","'internal'","'internal | unique'","'match'","'module'","'public'","'sealed'","'static'","'struct'","'super'","'template'","'then'","'this'","'where'","'with'","'{'","'}'","L_integ","L_doubl","L_UIdent","L_LIdent","L_MFun","%eof"]
        bit_start = st * 111
        bit_end = (st + 1) * 111
        read_bit = readArrayBit happyExpList
        bits = map read_bit [bit_start..bit_end - 1]
        bits_indexed = zip bits [0..110]
        token_strs_expected = concatMap f bits_indexed
        f (False, _) = []
        f (True, nr) = [token_strs !! nr]

action_0 (9) = happyGoto action_3
action_0 (12) = happyGoto action_4
action_0 _ = happyReduce_10

action_1 (106) = happyShift action_2
action_1 _ = happyFail (happyExpListPerState 1)

action_2 _ = happyReduce_1

action_3 (111) = happyAccept
action_3 _ = happyFail (happyExpListPerState 3)

action_4 (87) = happyShift action_7
action_4 (10) = happyGoto action_5
action_4 (11) = happyGoto action_6
action_4 _ = happyReduce_7

action_5 (111) = happyReduce_6
action_5 (24) = happyGoto action_10
action_5 (27) = happyGoto action_11
action_5 _ = happyReduce_41

action_6 _ = happyReduce_11

action_7 (108) = happyShift action_9
action_7 (6) = happyGoto action_8
action_7 _ = happyFail (happyExpListPerState 7)

action_8 (62) = happyShift action_19
action_8 _ = happyFail (happyExpListPerState 8)

action_9 _ = happyReduce_3

action_10 _ = happyReduce_8

action_11 (77) = happyShift action_13
action_11 (89) = happyShift action_14
action_11 (93) = happyShift action_15
action_11 (95) = happyShift action_16
action_11 (97) = happyShift action_17
action_11 (99) = happyShift action_18
action_11 (28) = happyGoto action_12
action_11 _ = happyFail (happyExpListPerState 11)

action_12 _ = happyReduce_42

action_13 (108) = happyShift action_9
action_13 (6) = happyGoto action_22
action_13 _ = happyFail (happyExpListPerState 13)

action_14 _ = happyReduce_44

action_15 _ = happyReduce_43

action_16 _ = happyReduce_45

action_17 (108) = happyShift action_9
action_17 (6) = happyGoto action_21
action_17 _ = happyFail (happyExpListPerState 17)

action_18 (108) = happyShift action_9
action_18 (6) = happyGoto action_20
action_18 _ = happyFail (happyExpListPerState 18)

action_19 _ = happyReduce_9

action_20 (14) = happyGoto action_26
action_20 _ = happyReduce_14

action_21 (102) = happyShift action_25
action_21 _ = happyFail (happyExpListPerState 21)

action_22 (86) = happyShift action_24
action_22 (25) = happyGoto action_23
action_22 _ = happyReduce_38

action_23 (79) = happyShift action_39
action_23 (26) = happyGoto action_38
action_23 _ = happyReduce_40

action_24 (108) = happyShift action_9
action_24 (6) = happyGoto action_35
action_24 (22) = happyGoto action_36
action_24 (23) = happyGoto action_37
action_24 _ = happyFail (happyExpListPerState 24)

action_25 (104) = happyShift action_34
action_25 _ = happyFail (happyExpListPerState 25)

action_26 (70) = happyShift action_32
action_26 (86) = happyShift action_24
action_26 (108) = happyShift action_9
action_26 (109) = happyShift action_33
action_26 (6) = happyGoto action_27
action_26 (7) = happyGoto action_28
action_26 (13) = happyGoto action_29
action_26 (15) = happyGoto action_30
action_26 (25) = happyGoto action_31
action_26 _ = happyReduce_38

action_27 _ = happyReduce_13

action_28 _ = happyReduce_12

action_29 _ = happyReduce_16

action_30 _ = happyReduce_15

action_31 (79) = happyShift action_39
action_31 (26) = happyGoto action_57
action_31 _ = happyReduce_40

action_32 (108) = happyShift action_9
action_32 (109) = happyShift action_33
action_32 (6) = happyGoto action_27
action_32 (7) = happyGoto action_28
action_32 (13) = happyGoto action_56
action_32 _ = happyFail (happyExpListPerState 32)

action_33 _ = happyReduce_4

action_34 (91) = happyShift action_54
action_34 (94) = happyShift action_55
action_34 (109) = happyShift action_33
action_34 (7) = happyGoto action_50
action_34 (36) = happyGoto action_51
action_34 (37) = happyGoto action_52
action_34 (38) = happyGoto action_53
action_34 _ = happyReduce_65

action_35 (53) = happyShift action_49
action_35 (108) = happyShift action_9
action_35 (109) = happyShift action_33
action_35 (6) = happyGoto action_43
action_35 (7) = happyGoto action_44
action_35 (18) = happyGoto action_45
action_35 (19) = happyGoto action_46
action_35 (20) = happyGoto action_47
action_35 (21) = happyGoto action_48
action_35 _ = happyReduce_28

action_36 (57) = happyShift action_42
action_36 _ = happyReduce_32

action_37 _ = happyReduce_37

action_38 (102) = happyShift action_41
action_38 _ = happyFail (happyExpListPerState 38)

action_39 (108) = happyShift action_9
action_39 (6) = happyGoto action_35
action_39 (22) = happyGoto action_40
action_39 _ = happyFail (happyExpListPerState 39)

action_40 _ = happyReduce_39

action_41 (104) = happyShift action_70
action_41 _ = happyFail (happyExpListPerState 41)

action_42 (108) = happyShift action_9
action_42 (6) = happyGoto action_35
action_42 (22) = happyGoto action_36
action_42 (23) = happyGoto action_69
action_42 _ = happyFail (happyExpListPerState 42)

action_43 (14) = happyGoto action_68
action_43 _ = happyReduce_14

action_44 (14) = happyGoto action_67
action_44 _ = happyReduce_14

action_45 (59) = happyShift action_66
action_45 _ = happyReduce_29

action_46 _ = happyReduce_31

action_47 _ = happyReduce_26

action_48 _ = happyReduce_25

action_49 (53) = happyShift action_49
action_49 (108) = happyShift action_9
action_49 (109) = happyShift action_33
action_49 (6) = happyGoto action_43
action_49 (7) = happyGoto action_44
action_49 (18) = happyGoto action_45
action_49 (19) = happyGoto action_65
action_49 (20) = happyGoto action_47
action_49 (21) = happyGoto action_48
action_49 _ = happyReduce_28

action_50 (61) = happyShift action_64
action_50 _ = happyFail (happyExpListPerState 50)

action_51 (62) = happyShift action_63
action_51 _ = happyReduce_66

action_52 (105) = happyShift action_62
action_52 _ = happyFail (happyExpListPerState 52)

action_53 (109) = happyShift action_33
action_53 (7) = happyGoto action_61
action_53 _ = happyFail (happyExpListPerState 53)

action_54 _ = happyReduce_69

action_55 _ = happyReduce_68

action_56 (79) = happyShift action_59
action_56 (98) = happyShift action_60
action_56 _ = happyFail (happyExpListPerState 56)

action_57 (102) = happyShift action_58
action_57 _ = happyFail (happyExpListPerState 57)

action_58 (104) = happyShift action_82
action_58 _ = happyFail (happyExpListPerState 58)

action_59 (53) = happyShift action_49
action_59 (108) = happyShift action_9
action_59 (109) = happyShift action_33
action_59 (6) = happyGoto action_43
action_59 (7) = happyGoto action_44
action_59 (18) = happyGoto action_45
action_59 (19) = happyGoto action_81
action_59 (20) = happyGoto action_47
action_59 (21) = happyGoto action_48
action_59 _ = happyReduce_28

action_60 (53) = happyShift action_49
action_60 (108) = happyShift action_9
action_60 (109) = happyShift action_33
action_60 (6) = happyGoto action_43
action_60 (7) = happyGoto action_44
action_60 (18) = happyGoto action_45
action_60 (19) = happyGoto action_80
action_60 (20) = happyGoto action_47
action_60 (21) = happyGoto action_48
action_60 _ = happyReduce_28

action_61 (61) = happyShift action_79
action_61 _ = happyFail (happyExpListPerState 61)

action_62 _ = happyReduce_34

action_63 (91) = happyShift action_54
action_63 (94) = happyShift action_55
action_63 (109) = happyShift action_33
action_63 (7) = happyGoto action_50
action_63 (36) = happyGoto action_51
action_63 (37) = happyGoto action_78
action_63 (38) = happyGoto action_53
action_63 _ = happyReduce_65

action_64 (53) = happyShift action_49
action_64 (108) = happyShift action_9
action_64 (109) = happyShift action_33
action_64 (6) = happyGoto action_43
action_64 (7) = happyGoto action_44
action_64 (18) = happyGoto action_45
action_64 (19) = happyGoto action_77
action_64 (20) = happyGoto action_47
action_64 (21) = happyGoto action_48
action_64 _ = happyReduce_28

action_65 (54) = happyShift action_76
action_65 _ = happyFail (happyExpListPerState 65)

action_66 (108) = happyShift action_9
action_66 (109) = happyShift action_33
action_66 (6) = happyGoto action_43
action_66 (7) = happyGoto action_44
action_66 (18) = happyGoto action_45
action_66 (21) = happyGoto action_75
action_66 _ = happyReduce_28

action_67 (70) = happyShift action_32
action_67 (108) = happyShift action_9
action_67 (109) = happyShift action_33
action_67 (6) = happyGoto action_27
action_67 (7) = happyGoto action_28
action_67 (13) = happyGoto action_29
action_67 (15) = happyGoto action_30
action_67 _ = happyReduce_24

action_68 (70) = happyShift action_32
action_68 (108) = happyShift action_9
action_68 (109) = happyShift action_33
action_68 (6) = happyGoto action_27
action_68 (7) = happyGoto action_28
action_68 (13) = happyGoto action_29
action_68 (15) = happyGoto action_30
action_68 _ = happyReduce_23

action_69 _ = happyReduce_33

action_70 (108) = happyShift action_9
action_70 (6) = happyGoto action_71
action_70 (29) = happyGoto action_72
action_70 (30) = happyGoto action_73
action_70 (31) = happyGoto action_74
action_70 _ = happyReduce_49

action_71 (83) = happyShift action_92
action_71 _ = happyReduce_47

action_72 (105) = happyShift action_91
action_72 _ = happyFail (happyExpListPerState 72)

action_73 (62) = happyShift action_90
action_73 _ = happyReduce_50

action_74 (105) = happyReduce_54
action_74 (32) = happyGoto action_87
action_74 (33) = happyGoto action_88
action_74 (34) = happyGoto action_89
action_74 _ = happyReduce_57

action_75 _ = happyReduce_30

action_76 _ = happyReduce_27

action_77 _ = happyReduce_64

action_78 _ = happyReduce_67

action_79 (53) = happyShift action_49
action_79 (108) = happyShift action_9
action_79 (109) = happyShift action_33
action_79 (6) = happyGoto action_43
action_79 (7) = happyGoto action_44
action_79 (18) = happyGoto action_45
action_79 (19) = happyGoto action_86
action_79 (20) = happyGoto action_47
action_79 (21) = happyGoto action_48
action_79 _ = happyReduce_28

action_80 (72) = happyShift action_85
action_80 _ = happyFail (happyExpListPerState 80)

action_81 (72) = happyShift action_84
action_81 _ = happyFail (happyExpListPerState 81)

action_82 (108) = happyShift action_9
action_82 (6) = happyGoto action_71
action_82 (29) = happyGoto action_83
action_82 (30) = happyGoto action_73
action_82 (31) = happyGoto action_74
action_82 _ = happyReduce_49

action_83 (105) = happyShift action_102
action_83 _ = happyFail (happyExpListPerState 83)

action_84 _ = happyReduce_18

action_85 _ = happyReduce_17

action_86 _ = happyReduce_63

action_87 (62) = happyShift action_101
action_87 _ = happyReduce_55

action_88 _ = happyReduce_46

action_89 (81) = happyShift action_96
action_89 (82) = happyShift action_97
action_89 (85) = happyShift action_98
action_89 (90) = happyShift action_99
action_89 (96) = happyShift action_100
action_89 (35) = happyGoto action_95
action_89 _ = happyFail (happyExpListPerState 89)

action_90 (108) = happyShift action_9
action_90 (6) = happyGoto action_71
action_90 (30) = happyGoto action_73
action_90 (31) = happyGoto action_94
action_90 _ = happyReduce_49

action_91 _ = happyReduce_35

action_92 (104) = happyShift action_93
action_92 _ = happyFail (happyExpListPerState 92)

action_93 (91) = happyShift action_54
action_93 (94) = happyShift action_55
action_93 (109) = happyShift action_33
action_93 (7) = happyGoto action_50
action_93 (36) = happyGoto action_51
action_93 (37) = happyGoto action_105
action_93 (38) = happyGoto action_53
action_93 _ = happyReduce_65

action_94 _ = happyReduce_51

action_95 _ = happyReduce_58

action_96 _ = happyReduce_62

action_97 (109) = happyShift action_33
action_97 (7) = happyGoto action_104
action_97 _ = happyFail (happyExpListPerState 97)

action_98 _ = happyReduce_61

action_99 _ = happyReduce_60

action_100 _ = happyReduce_59

action_101 (105) = happyReduce_54
action_101 (32) = happyGoto action_87
action_101 (33) = happyGoto action_103
action_101 (34) = happyGoto action_89
action_101 _ = happyReduce_57

action_102 _ = happyReduce_36

action_103 _ = happyReduce_56

action_104 (16) = happyGoto action_107
action_104 _ = happyReduce_19

action_105 (105) = happyShift action_106
action_105 _ = happyFail (happyExpListPerState 105)

action_106 _ = happyReduce_48

action_107 (53) = happyShift action_110
action_107 (61) = happyShift action_111
action_107 (109) = happyShift action_33
action_107 (7) = happyGoto action_108
action_107 (17) = happyGoto action_109
action_107 _ = happyFail (happyExpListPerState 107)

action_108 _ = happyReduce_22

action_109 _ = happyReduce_20

action_110 (109) = happyShift action_33
action_110 (7) = happyGoto action_114
action_110 _ = happyFail (happyExpListPerState 110)

action_111 (53) = happyShift action_49
action_111 (75) = happyShift action_113
action_111 (108) = happyShift action_9
action_111 (109) = happyShift action_33
action_111 (6) = happyGoto action_43
action_111 (7) = happyGoto action_44
action_111 (18) = happyGoto action_45
action_111 (19) = happyGoto action_112
action_111 (20) = happyGoto action_47
action_111 (21) = happyGoto action_48
action_111 _ = happyReduce_28

action_112 (65) = happyShift action_117
action_112 _ = happyFail (happyExpListPerState 112)

action_113 (53) = happyShift action_49
action_113 (108) = happyShift action_9
action_113 (109) = happyShift action_33
action_113 (6) = happyGoto action_43
action_113 (7) = happyGoto action_44
action_113 (18) = happyGoto action_45
action_113 (19) = happyGoto action_116
action_113 (20) = happyGoto action_47
action_113 (21) = happyGoto action_48
action_113 _ = happyReduce_28

action_114 (61) = happyShift action_115
action_114 _ = happyFail (happyExpListPerState 114)

action_115 (53) = happyShift action_49
action_115 (108) = happyShift action_9
action_115 (109) = happyShift action_33
action_115 (6) = happyGoto action_43
action_115 (7) = happyGoto action_44
action_115 (18) = happyGoto action_45
action_115 (19) = happyGoto action_140
action_115 (20) = happyGoto action_47
action_115 (21) = happyGoto action_48
action_115 _ = happyReduce_28

action_116 _ = happyReduce_53

action_117 (53) = happyShift action_131
action_117 (74) = happyShift action_132
action_117 (78) = happyShift action_133
action_117 (84) = happyShift action_134
action_117 (92) = happyShift action_135
action_117 (98) = happyShift action_136
action_117 (101) = happyShift action_137
action_117 (106) = happyShift action_2
action_117 (107) = happyShift action_138
action_117 (108) = happyShift action_9
action_117 (109) = happyShift action_33
action_117 (110) = happyShift action_139
action_117 (4) = happyGoto action_118
action_117 (5) = happyGoto action_119
action_117 (6) = happyGoto action_120
action_117 (7) = happyGoto action_121
action_117 (8) = happyGoto action_122
action_117 (39) = happyGoto action_123
action_117 (44) = happyGoto action_124
action_117 (47) = happyGoto action_125
action_117 (48) = happyGoto action_126
action_117 (49) = happyGoto action_127
action_117 (50) = happyGoto action_128
action_117 (51) = happyGoto action_129
action_117 (52) = happyGoto action_130
action_117 _ = happyFail (happyExpListPerState 117)

action_118 _ = happyReduce_94

action_119 _ = happyReduce_95

action_120 _ = happyReduce_86

action_121 _ = happyReduce_87

action_122 _ = happyReduce_88

action_123 _ = happyReduce_52

action_124 (46) = happyGoto action_159
action_124 _ = happyReduce_91

action_125 (73) = happyShift action_158
action_125 _ = happyReduce_111

action_126 (66) = happyShift action_157
action_126 _ = happyReduce_75

action_127 (56) = happyShift action_151
action_127 (58) = happyShift action_152
action_127 (63) = happyShift action_153
action_127 (64) = happyShift action_154
action_127 (68) = happyShift action_155
action_127 (69) = happyShift action_156
action_127 _ = happyReduce_103

action_128 (55) = happyShift action_149
action_128 (60) = happyShift action_150
action_128 _ = happyReduce_106

action_129 _ = happyReduce_109

action_130 _ = happyReduce_97

action_131 (53) = happyShift action_131
action_131 (71) = happyShift action_148
action_131 (74) = happyShift action_132
action_131 (78) = happyShift action_133
action_131 (84) = happyShift action_134
action_131 (92) = happyShift action_135
action_131 (98) = happyShift action_136
action_131 (101) = happyShift action_137
action_131 (106) = happyShift action_2
action_131 (107) = happyShift action_138
action_131 (108) = happyShift action_9
action_131 (109) = happyShift action_33
action_131 (110) = happyShift action_139
action_131 (4) = happyGoto action_118
action_131 (5) = happyGoto action_119
action_131 (6) = happyGoto action_120
action_131 (7) = happyGoto action_121
action_131 (8) = happyGoto action_122
action_131 (39) = happyGoto action_147
action_131 (44) = happyGoto action_124
action_131 (47) = happyGoto action_125
action_131 (48) = happyGoto action_126
action_131 (49) = happyGoto action_127
action_131 (50) = happyGoto action_128
action_131 (51) = happyGoto action_129
action_131 (52) = happyGoto action_130
action_131 _ = happyFail (happyExpListPerState 131)

action_132 _ = happyReduce_96

action_133 (53) = happyShift action_131
action_133 (74) = happyShift action_132
action_133 (78) = happyShift action_133
action_133 (84) = happyShift action_134
action_133 (92) = happyShift action_135
action_133 (98) = happyShift action_136
action_133 (101) = happyShift action_137
action_133 (104) = happyShift action_146
action_133 (106) = happyShift action_2
action_133 (107) = happyShift action_138
action_133 (108) = happyShift action_9
action_133 (109) = happyShift action_33
action_133 (110) = happyShift action_139
action_133 (4) = happyGoto action_118
action_133 (5) = happyGoto action_119
action_133 (6) = happyGoto action_120
action_133 (7) = happyGoto action_121
action_133 (8) = happyGoto action_122
action_133 (39) = happyGoto action_144
action_133 (41) = happyGoto action_145
action_133 (44) = happyGoto action_124
action_133 (47) = happyGoto action_125
action_133 (48) = happyGoto action_126
action_133 (49) = happyGoto action_127
action_133 (50) = happyGoto action_128
action_133 (51) = happyGoto action_129
action_133 (52) = happyGoto action_130
action_133 _ = happyFail (happyExpListPerState 133)

action_134 (53) = happyShift action_131
action_134 (74) = happyShift action_132
action_134 (78) = happyShift action_133
action_134 (84) = happyShift action_134
action_134 (92) = happyShift action_135
action_134 (98) = happyShift action_136
action_134 (101) = happyShift action_137
action_134 (106) = happyShift action_2
action_134 (107) = happyShift action_138
action_134 (108) = happyShift action_9
action_134 (109) = happyShift action_33
action_134 (110) = happyShift action_139
action_134 (4) = happyGoto action_118
action_134 (5) = happyGoto action_119
action_134 (6) = happyGoto action_120
action_134 (7) = happyGoto action_121
action_134 (8) = happyGoto action_122
action_134 (39) = happyGoto action_143
action_134 (44) = happyGoto action_124
action_134 (47) = happyGoto action_125
action_134 (48) = happyGoto action_126
action_134 (49) = happyGoto action_127
action_134 (50) = happyGoto action_128
action_134 (51) = happyGoto action_129
action_134 (52) = happyGoto action_130
action_134 _ = happyFail (happyExpListPerState 134)

action_135 (53) = happyShift action_131
action_135 (74) = happyShift action_132
action_135 (78) = happyShift action_133
action_135 (84) = happyShift action_134
action_135 (92) = happyShift action_135
action_135 (98) = happyShift action_136
action_135 (101) = happyShift action_137
action_135 (106) = happyShift action_2
action_135 (107) = happyShift action_138
action_135 (108) = happyShift action_9
action_135 (109) = happyShift action_33
action_135 (110) = happyShift action_139
action_135 (4) = happyGoto action_118
action_135 (5) = happyGoto action_119
action_135 (6) = happyGoto action_120
action_135 (7) = happyGoto action_121
action_135 (8) = happyGoto action_122
action_135 (39) = happyGoto action_142
action_135 (44) = happyGoto action_124
action_135 (47) = happyGoto action_125
action_135 (48) = happyGoto action_126
action_135 (49) = happyGoto action_127
action_135 (50) = happyGoto action_128
action_135 (51) = happyGoto action_129
action_135 (52) = happyGoto action_130
action_135 _ = happyFail (happyExpListPerState 135)

action_136 _ = happyReduce_85

action_137 _ = happyReduce_84

action_138 _ = happyReduce_2

action_139 _ = happyReduce_5

action_140 (54) = happyShift action_141
action_140 _ = happyFail (happyExpListPerState 140)

action_141 _ = happyReduce_21

action_142 (103) = happyShift action_181
action_142 _ = happyFail (happyExpListPerState 142)

action_143 (100) = happyShift action_180
action_143 _ = happyFail (happyExpListPerState 143)

action_144 (76) = happyShift action_179
action_144 _ = happyFail (happyExpListPerState 144)

action_145 (88) = happyShift action_178
action_145 _ = happyFail (happyExpListPerState 145)

action_146 (53) = happyShift action_131
action_146 (74) = happyShift action_132
action_146 (78) = happyShift action_133
action_146 (84) = happyShift action_134
action_146 (92) = happyShift action_135
action_146 (98) = happyShift action_136
action_146 (101) = happyShift action_137
action_146 (106) = happyShift action_2
action_146 (107) = happyShift action_138
action_146 (108) = happyShift action_9
action_146 (109) = happyShift action_33
action_146 (110) = happyShift action_139
action_146 (4) = happyGoto action_118
action_146 (5) = happyGoto action_119
action_146 (6) = happyGoto action_120
action_146 (7) = happyGoto action_121
action_146 (8) = happyGoto action_122
action_146 (39) = happyGoto action_144
action_146 (40) = happyGoto action_176
action_146 (41) = happyGoto action_177
action_146 (44) = happyGoto action_124
action_146 (47) = happyGoto action_125
action_146 (48) = happyGoto action_126
action_146 (49) = happyGoto action_127
action_146 (50) = happyGoto action_128
action_146 (51) = happyGoto action_129
action_146 (52) = happyGoto action_130
action_146 _ = happyReduce_76

action_147 (54) = happyShift action_175
action_147 _ = happyFail (happyExpListPerState 147)

action_148 (16) = happyGoto action_174
action_148 _ = happyReduce_19

action_149 (53) = happyShift action_163
action_149 (74) = happyShift action_132
action_149 (98) = happyShift action_136
action_149 (101) = happyShift action_137
action_149 (106) = happyShift action_2
action_149 (107) = happyShift action_138
action_149 (108) = happyShift action_9
action_149 (109) = happyShift action_33
action_149 (110) = happyShift action_139
action_149 (4) = happyGoto action_118
action_149 (5) = happyGoto action_119
action_149 (6) = happyGoto action_120
action_149 (7) = happyGoto action_121
action_149 (8) = happyGoto action_122
action_149 (44) = happyGoto action_124
action_149 (47) = happyGoto action_125
action_149 (51) = happyGoto action_173
action_149 (52) = happyGoto action_130
action_149 _ = happyFail (happyExpListPerState 149)

action_150 (53) = happyShift action_163
action_150 (74) = happyShift action_132
action_150 (98) = happyShift action_136
action_150 (101) = happyShift action_137
action_150 (106) = happyShift action_2
action_150 (107) = happyShift action_138
action_150 (108) = happyShift action_9
action_150 (109) = happyShift action_33
action_150 (110) = happyShift action_139
action_150 (4) = happyGoto action_118
action_150 (5) = happyGoto action_119
action_150 (6) = happyGoto action_120
action_150 (7) = happyGoto action_121
action_150 (8) = happyGoto action_122
action_150 (44) = happyGoto action_124
action_150 (47) = happyGoto action_125
action_150 (51) = happyGoto action_172
action_150 (52) = happyGoto action_130
action_150 _ = happyFail (happyExpListPerState 150)

action_151 (53) = happyShift action_163
action_151 (74) = happyShift action_132
action_151 (98) = happyShift action_136
action_151 (101) = happyShift action_137
action_151 (106) = happyShift action_2
action_151 (107) = happyShift action_138
action_151 (108) = happyShift action_9
action_151 (109) = happyShift action_33
action_151 (110) = happyShift action_139
action_151 (4) = happyGoto action_118
action_151 (5) = happyGoto action_119
action_151 (6) = happyGoto action_120
action_151 (7) = happyGoto action_121
action_151 (8) = happyGoto action_122
action_151 (44) = happyGoto action_124
action_151 (47) = happyGoto action_125
action_151 (50) = happyGoto action_171
action_151 (51) = happyGoto action_129
action_151 (52) = happyGoto action_130
action_151 _ = happyFail (happyExpListPerState 151)

action_152 (53) = happyShift action_163
action_152 (74) = happyShift action_132
action_152 (98) = happyShift action_136
action_152 (101) = happyShift action_137
action_152 (106) = happyShift action_2
action_152 (107) = happyShift action_138
action_152 (108) = happyShift action_9
action_152 (109) = happyShift action_33
action_152 (110) = happyShift action_139
action_152 (4) = happyGoto action_118
action_152 (5) = happyGoto action_119
action_152 (6) = happyGoto action_120
action_152 (7) = happyGoto action_121
action_152 (8) = happyGoto action_122
action_152 (44) = happyGoto action_124
action_152 (47) = happyGoto action_125
action_152 (50) = happyGoto action_170
action_152 (51) = happyGoto action_129
action_152 (52) = happyGoto action_130
action_152 _ = happyFail (happyExpListPerState 152)

action_153 (53) = happyShift action_163
action_153 (74) = happyShift action_132
action_153 (98) = happyShift action_136
action_153 (101) = happyShift action_137
action_153 (106) = happyShift action_2
action_153 (107) = happyShift action_138
action_153 (108) = happyShift action_9
action_153 (109) = happyShift action_33
action_153 (110) = happyShift action_139
action_153 (4) = happyGoto action_118
action_153 (5) = happyGoto action_119
action_153 (6) = happyGoto action_120
action_153 (7) = happyGoto action_121
action_153 (8) = happyGoto action_122
action_153 (44) = happyGoto action_124
action_153 (47) = happyGoto action_125
action_153 (49) = happyGoto action_169
action_153 (50) = happyGoto action_128
action_153 (51) = happyGoto action_129
action_153 (52) = happyGoto action_130
action_153 _ = happyFail (happyExpListPerState 153)

action_154 (53) = happyShift action_163
action_154 (74) = happyShift action_132
action_154 (98) = happyShift action_136
action_154 (101) = happyShift action_137
action_154 (106) = happyShift action_2
action_154 (107) = happyShift action_138
action_154 (108) = happyShift action_9
action_154 (109) = happyShift action_33
action_154 (110) = happyShift action_139
action_154 (4) = happyGoto action_118
action_154 (5) = happyGoto action_119
action_154 (6) = happyGoto action_120
action_154 (7) = happyGoto action_121
action_154 (8) = happyGoto action_122
action_154 (44) = happyGoto action_124
action_154 (47) = happyGoto action_125
action_154 (49) = happyGoto action_168
action_154 (50) = happyGoto action_128
action_154 (51) = happyGoto action_129
action_154 (52) = happyGoto action_130
action_154 _ = happyFail (happyExpListPerState 154)

action_155 (53) = happyShift action_163
action_155 (74) = happyShift action_132
action_155 (98) = happyShift action_136
action_155 (101) = happyShift action_137
action_155 (106) = happyShift action_2
action_155 (107) = happyShift action_138
action_155 (108) = happyShift action_9
action_155 (109) = happyShift action_33
action_155 (110) = happyShift action_139
action_155 (4) = happyGoto action_118
action_155 (5) = happyGoto action_119
action_155 (6) = happyGoto action_120
action_155 (7) = happyGoto action_121
action_155 (8) = happyGoto action_122
action_155 (44) = happyGoto action_124
action_155 (47) = happyGoto action_125
action_155 (49) = happyGoto action_167
action_155 (50) = happyGoto action_128
action_155 (51) = happyGoto action_129
action_155 (52) = happyGoto action_130
action_155 _ = happyFail (happyExpListPerState 155)

action_156 (53) = happyShift action_163
action_156 (74) = happyShift action_132
action_156 (98) = happyShift action_136
action_156 (101) = happyShift action_137
action_156 (106) = happyShift action_2
action_156 (107) = happyShift action_138
action_156 (108) = happyShift action_9
action_156 (109) = happyShift action_33
action_156 (110) = happyShift action_139
action_156 (4) = happyGoto action_118
action_156 (5) = happyGoto action_119
action_156 (6) = happyGoto action_120
action_156 (7) = happyGoto action_121
action_156 (8) = happyGoto action_122
action_156 (44) = happyGoto action_124
action_156 (47) = happyGoto action_125
action_156 (49) = happyGoto action_166
action_156 (50) = happyGoto action_128
action_156 (51) = happyGoto action_129
action_156 (52) = happyGoto action_130
action_156 _ = happyFail (happyExpListPerState 156)

action_157 (53) = happyShift action_163
action_157 (74) = happyShift action_132
action_157 (98) = happyShift action_136
action_157 (101) = happyShift action_137
action_157 (106) = happyShift action_2
action_157 (107) = happyShift action_138
action_157 (108) = happyShift action_9
action_157 (109) = happyShift action_33
action_157 (110) = happyShift action_139
action_157 (4) = happyGoto action_118
action_157 (5) = happyGoto action_119
action_157 (6) = happyGoto action_120
action_157 (7) = happyGoto action_121
action_157 (8) = happyGoto action_122
action_157 (44) = happyGoto action_124
action_157 (47) = happyGoto action_125
action_157 (49) = happyGoto action_165
action_157 (50) = happyGoto action_128
action_157 (51) = happyGoto action_129
action_157 (52) = happyGoto action_130
action_157 _ = happyFail (happyExpListPerState 157)

action_158 (53) = happyShift action_163
action_158 (74) = happyShift action_132
action_158 (98) = happyShift action_136
action_158 (101) = happyShift action_137
action_158 (106) = happyShift action_2
action_158 (107) = happyShift action_138
action_158 (108) = happyShift action_9
action_158 (109) = happyShift action_33
action_158 (110) = happyShift action_139
action_158 (4) = happyGoto action_118
action_158 (5) = happyGoto action_119
action_158 (6) = happyGoto action_120
action_158 (7) = happyGoto action_121
action_158 (8) = happyGoto action_122
action_158 (44) = happyGoto action_124
action_158 (47) = happyGoto action_125
action_158 (51) = happyGoto action_164
action_158 (52) = happyGoto action_130
action_158 _ = happyFail (happyExpListPerState 158)

action_159 (53) = happyShift action_163
action_159 (98) = happyShift action_136
action_159 (101) = happyShift action_137
action_159 (108) = happyShift action_9
action_159 (109) = happyShift action_33
action_159 (110) = happyShift action_139
action_159 (6) = happyGoto action_120
action_159 (7) = happyGoto action_121
action_159 (8) = happyGoto action_122
action_159 (44) = happyGoto action_160
action_159 (45) = happyGoto action_161
action_159 (52) = happyGoto action_162
action_159 _ = happyReduce_93

action_160 _ = happyReduce_90

action_161 _ = happyReduce_92

action_162 _ = happyReduce_89

action_163 (53) = happyShift action_131
action_163 (74) = happyShift action_132
action_163 (78) = happyShift action_133
action_163 (84) = happyShift action_134
action_163 (92) = happyShift action_135
action_163 (98) = happyShift action_136
action_163 (101) = happyShift action_137
action_163 (106) = happyShift action_2
action_163 (107) = happyShift action_138
action_163 (108) = happyShift action_9
action_163 (109) = happyShift action_33
action_163 (110) = happyShift action_139
action_163 (4) = happyGoto action_118
action_163 (5) = happyGoto action_119
action_163 (6) = happyGoto action_120
action_163 (7) = happyGoto action_121
action_163 (8) = happyGoto action_122
action_163 (39) = happyGoto action_147
action_163 (44) = happyGoto action_124
action_163 (47) = happyGoto action_125
action_163 (48) = happyGoto action_126
action_163 (49) = happyGoto action_127
action_163 (50) = happyGoto action_128
action_163 (51) = happyGoto action_129
action_163 (52) = happyGoto action_130
action_163 _ = happyFail (happyExpListPerState 163)

action_164 _ = happyReduce_110

action_165 (56) = happyShift action_151
action_165 (58) = happyShift action_152
action_165 _ = happyReduce_98

action_166 (56) = happyShift action_151
action_166 (58) = happyShift action_152
action_166 _ = happyReduce_102

action_167 (56) = happyShift action_151
action_167 (58) = happyShift action_152
action_167 _ = happyReduce_100

action_168 (56) = happyShift action_151
action_168 (58) = happyShift action_152
action_168 _ = happyReduce_101

action_169 (56) = happyShift action_151
action_169 (58) = happyShift action_152
action_169 _ = happyReduce_99

action_170 (55) = happyShift action_149
action_170 (60) = happyShift action_150
action_170 _ = happyReduce_105

action_171 (55) = happyShift action_149
action_171 (60) = happyShift action_150
action_171 _ = happyReduce_104

action_172 _ = happyReduce_108

action_173 _ = happyReduce_107

action_174 (53) = happyShift action_110
action_174 (61) = happyShift action_188
action_174 (109) = happyShift action_33
action_174 (7) = happyGoto action_108
action_174 (17) = happyGoto action_109
action_174 _ = happyFail (happyExpListPerState 174)

action_175 _ = happyReduce_112

action_176 (105) = happyShift action_187
action_176 _ = happyFail (happyExpListPerState 176)

action_177 (62) = happyShift action_186
action_177 _ = happyReduce_77

action_178 (53) = happyShift action_131
action_178 (74) = happyShift action_132
action_178 (78) = happyShift action_133
action_178 (84) = happyShift action_134
action_178 (92) = happyShift action_135
action_178 (98) = happyShift action_136
action_178 (101) = happyShift action_137
action_178 (106) = happyShift action_2
action_178 (107) = happyShift action_138
action_178 (108) = happyShift action_9
action_178 (109) = happyShift action_33
action_178 (110) = happyShift action_139
action_178 (4) = happyGoto action_118
action_178 (5) = happyGoto action_119
action_178 (6) = happyGoto action_120
action_178 (7) = happyGoto action_121
action_178 (8) = happyGoto action_122
action_178 (39) = happyGoto action_185
action_178 (44) = happyGoto action_124
action_178 (47) = happyGoto action_125
action_178 (48) = happyGoto action_126
action_178 (49) = happyGoto action_127
action_178 (50) = happyGoto action_128
action_178 (51) = happyGoto action_129
action_178 (52) = happyGoto action_130
action_178 _ = happyFail (happyExpListPerState 178)

action_179 (109) = happyShift action_33
action_179 (7) = happyGoto action_184
action_179 _ = happyFail (happyExpListPerState 179)

action_180 (53) = happyShift action_131
action_180 (74) = happyShift action_132
action_180 (78) = happyShift action_133
action_180 (84) = happyShift action_134
action_180 (92) = happyShift action_135
action_180 (98) = happyShift action_136
action_180 (101) = happyShift action_137
action_180 (106) = happyShift action_2
action_180 (107) = happyShift action_138
action_180 (108) = happyShift action_9
action_180 (109) = happyShift action_33
action_180 (110) = happyShift action_139
action_180 (4) = happyGoto action_118
action_180 (5) = happyGoto action_119
action_180 (6) = happyGoto action_120
action_180 (7) = happyGoto action_121
action_180 (8) = happyGoto action_122
action_180 (39) = happyGoto action_183
action_180 (44) = happyGoto action_124
action_180 (47) = happyGoto action_125
action_180 (48) = happyGoto action_126
action_180 (49) = happyGoto action_127
action_180 (50) = happyGoto action_128
action_180 (51) = happyGoto action_129
action_180 (52) = happyGoto action_130
action_180 _ = happyFail (happyExpListPerState 180)

action_181 (104) = happyShift action_182
action_181 _ = happyFail (happyExpListPerState 181)

action_182 (53) = happyShift action_131
action_182 (74) = happyShift action_132
action_182 (78) = happyShift action_133
action_182 (84) = happyShift action_134
action_182 (92) = happyShift action_135
action_182 (98) = happyShift action_136
action_182 (101) = happyShift action_137
action_182 (106) = happyShift action_2
action_182 (107) = happyShift action_138
action_182 (108) = happyShift action_9
action_182 (109) = happyShift action_33
action_182 (110) = happyShift action_139
action_182 (4) = happyGoto action_118
action_182 (5) = happyGoto action_119
action_182 (6) = happyGoto action_120
action_182 (7) = happyGoto action_121
action_182 (8) = happyGoto action_122
action_182 (39) = happyGoto action_193
action_182 (42) = happyGoto action_194
action_182 (43) = happyGoto action_195
action_182 (44) = happyGoto action_124
action_182 (47) = happyGoto action_125
action_182 (48) = happyGoto action_126
action_182 (49) = happyGoto action_127
action_182 (50) = happyGoto action_128
action_182 (51) = happyGoto action_129
action_182 (52) = happyGoto action_130
action_182 _ = happyReduce_80

action_183 (80) = happyShift action_192
action_183 _ = happyFail (happyExpListPerState 183)

action_184 _ = happyReduce_79

action_185 _ = happyReduce_71

action_186 (53) = happyShift action_131
action_186 (74) = happyShift action_132
action_186 (78) = happyShift action_133
action_186 (84) = happyShift action_134
action_186 (92) = happyShift action_135
action_186 (98) = happyShift action_136
action_186 (101) = happyShift action_137
action_186 (106) = happyShift action_2
action_186 (107) = happyShift action_138
action_186 (108) = happyShift action_9
action_186 (109) = happyShift action_33
action_186 (110) = happyShift action_139
action_186 (4) = happyGoto action_118
action_186 (5) = happyGoto action_119
action_186 (6) = happyGoto action_120
action_186 (7) = happyGoto action_121
action_186 (8) = happyGoto action_122
action_186 (39) = happyGoto action_144
action_186 (40) = happyGoto action_191
action_186 (41) = happyGoto action_177
action_186 (44) = happyGoto action_124
action_186 (47) = happyGoto action_125
action_186 (48) = happyGoto action_126
action_186 (49) = happyGoto action_127
action_186 (50) = happyGoto action_128
action_186 (51) = happyGoto action_129
action_186 (52) = happyGoto action_130
action_186 _ = happyReduce_76

action_187 (88) = happyShift action_190
action_187 _ = happyFail (happyExpListPerState 187)

action_188 (53) = happyShift action_49
action_188 (108) = happyShift action_9
action_188 (109) = happyShift action_33
action_188 (6) = happyGoto action_43
action_188 (7) = happyGoto action_44
action_188 (18) = happyGoto action_45
action_188 (19) = happyGoto action_189
action_188 (20) = happyGoto action_47
action_188 (21) = happyGoto action_48
action_188 _ = happyReduce_28

action_189 (67) = happyShift action_201
action_189 _ = happyFail (happyExpListPerState 189)

action_190 (53) = happyShift action_131
action_190 (74) = happyShift action_132
action_190 (78) = happyShift action_133
action_190 (84) = happyShift action_134
action_190 (92) = happyShift action_135
action_190 (98) = happyShift action_136
action_190 (101) = happyShift action_137
action_190 (106) = happyShift action_2
action_190 (107) = happyShift action_138
action_190 (108) = happyShift action_9
action_190 (109) = happyShift action_33
action_190 (110) = happyShift action_139
action_190 (4) = happyGoto action_118
action_190 (5) = happyGoto action_119
action_190 (6) = happyGoto action_120
action_190 (7) = happyGoto action_121
action_190 (8) = happyGoto action_122
action_190 (39) = happyGoto action_200
action_190 (44) = happyGoto action_124
action_190 (47) = happyGoto action_125
action_190 (48) = happyGoto action_126
action_190 (49) = happyGoto action_127
action_190 (50) = happyGoto action_128
action_190 (51) = happyGoto action_129
action_190 (52) = happyGoto action_130
action_190 _ = happyFail (happyExpListPerState 190)

action_191 _ = happyReduce_78

action_192 (53) = happyShift action_131
action_192 (74) = happyShift action_132
action_192 (78) = happyShift action_133
action_192 (84) = happyShift action_134
action_192 (92) = happyShift action_135
action_192 (98) = happyShift action_136
action_192 (101) = happyShift action_137
action_192 (106) = happyShift action_2
action_192 (107) = happyShift action_138
action_192 (108) = happyShift action_9
action_192 (109) = happyShift action_33
action_192 (110) = happyShift action_139
action_192 (4) = happyGoto action_118
action_192 (5) = happyGoto action_119
action_192 (6) = happyGoto action_120
action_192 (7) = happyGoto action_121
action_192 (8) = happyGoto action_122
action_192 (39) = happyGoto action_199
action_192 (44) = happyGoto action_124
action_192 (47) = happyGoto action_125
action_192 (48) = happyGoto action_126
action_192 (49) = happyGoto action_127
action_192 (50) = happyGoto action_128
action_192 (51) = happyGoto action_129
action_192 (52) = happyGoto action_130
action_192 _ = happyFail (happyExpListPerState 192)

action_193 (59) = happyShift action_198
action_193 _ = happyFail (happyExpListPerState 193)

action_194 (105) = happyShift action_197
action_194 _ = happyFail (happyExpListPerState 194)

action_195 (62) = happyShift action_196
action_195 _ = happyReduce_81

action_196 (53) = happyShift action_131
action_196 (74) = happyShift action_132
action_196 (78) = happyShift action_133
action_196 (84) = happyShift action_134
action_196 (92) = happyShift action_135
action_196 (98) = happyShift action_136
action_196 (101) = happyShift action_137
action_196 (106) = happyShift action_2
action_196 (107) = happyShift action_138
action_196 (108) = happyShift action_9
action_196 (109) = happyShift action_33
action_196 (110) = happyShift action_139
action_196 (4) = happyGoto action_118
action_196 (5) = happyGoto action_119
action_196 (6) = happyGoto action_120
action_196 (7) = happyGoto action_121
action_196 (8) = happyGoto action_122
action_196 (39) = happyGoto action_193
action_196 (42) = happyGoto action_204
action_196 (43) = happyGoto action_195
action_196 (44) = happyGoto action_124
action_196 (47) = happyGoto action_125
action_196 (48) = happyGoto action_126
action_196 (49) = happyGoto action_127
action_196 (50) = happyGoto action_128
action_196 (51) = happyGoto action_129
action_196 (52) = happyGoto action_130
action_196 _ = happyReduce_80

action_197 _ = happyReduce_72

action_198 (53) = happyShift action_131
action_198 (74) = happyShift action_132
action_198 (78) = happyShift action_133
action_198 (84) = happyShift action_134
action_198 (92) = happyShift action_135
action_198 (98) = happyShift action_136
action_198 (101) = happyShift action_137
action_198 (106) = happyShift action_2
action_198 (107) = happyShift action_138
action_198 (108) = happyShift action_9
action_198 (109) = happyShift action_33
action_198 (110) = happyShift action_139
action_198 (4) = happyGoto action_118
action_198 (5) = happyGoto action_119
action_198 (6) = happyGoto action_120
action_198 (7) = happyGoto action_121
action_198 (8) = happyGoto action_122
action_198 (39) = happyGoto action_203
action_198 (44) = happyGoto action_124
action_198 (47) = happyGoto action_125
action_198 (48) = happyGoto action_126
action_198 (49) = happyGoto action_127
action_198 (50) = happyGoto action_128
action_198 (51) = happyGoto action_129
action_198 (52) = happyGoto action_130
action_198 _ = happyFail (happyExpListPerState 198)

action_199 _ = happyReduce_73

action_200 _ = happyReduce_70

action_201 (53) = happyShift action_131
action_201 (74) = happyShift action_132
action_201 (78) = happyShift action_133
action_201 (84) = happyShift action_134
action_201 (92) = happyShift action_135
action_201 (98) = happyShift action_136
action_201 (101) = happyShift action_137
action_201 (106) = happyShift action_2
action_201 (107) = happyShift action_138
action_201 (108) = happyShift action_9
action_201 (109) = happyShift action_33
action_201 (110) = happyShift action_139
action_201 (4) = happyGoto action_118
action_201 (5) = happyGoto action_119
action_201 (6) = happyGoto action_120
action_201 (7) = happyGoto action_121
action_201 (8) = happyGoto action_122
action_201 (39) = happyGoto action_202
action_201 (44) = happyGoto action_124
action_201 (47) = happyGoto action_125
action_201 (48) = happyGoto action_126
action_201 (49) = happyGoto action_127
action_201 (50) = happyGoto action_128
action_201 (51) = happyGoto action_129
action_201 (52) = happyGoto action_130
action_201 _ = happyFail (happyExpListPerState 201)

action_202 (54) = happyShift action_205
action_202 _ = happyFail (happyExpListPerState 202)

action_203 _ = happyReduce_83

action_204 _ = happyReduce_82

action_205 _ = happyReduce_74

happyReduce_1 = happySpecReduce_1  4 happyReduction_1
happyReduction_1 (HappyTerminal (PT _ (TI happy_var_1)))
	 =  HappyAbsSyn4
		 ((read ( happy_var_1)) :: Integer
	)
happyReduction_1 _  = notHappyAtAll 

happyReduce_2 = happySpecReduce_1  5 happyReduction_2
happyReduction_2 (HappyTerminal (PT _ (TD happy_var_1)))
	 =  HappyAbsSyn5
		 ((read ( happy_var_1)) :: Double
	)
happyReduction_2 _  = notHappyAtAll 

happyReduce_3 = happySpecReduce_1  6 happyReduction_3
happyReduction_3 (HappyTerminal (PT _ (T_UIdent happy_var_1)))
	 =  HappyAbsSyn6
		 (UIdent (happy_var_1)
	)
happyReduction_3 _  = notHappyAtAll 

happyReduce_4 = happySpecReduce_1  7 happyReduction_4
happyReduction_4 (HappyTerminal (PT _ (T_LIdent happy_var_1)))
	 =  HappyAbsSyn7
		 (LIdent (happy_var_1)
	)
happyReduction_4 _  = notHappyAtAll 

happyReduce_5 = happySpecReduce_1  8 happyReduction_5
happyReduction_5 (HappyTerminal (PT _ (T_MFun happy_var_1)))
	 =  HappyAbsSyn8
		 (MFun (happy_var_1)
	)
happyReduction_5 _  = notHappyAtAll 

happyReduce_6 = happySpecReduce_2  9 happyReduction_6
happyReduction_6 (HappyAbsSyn10  happy_var_2)
	(HappyAbsSyn12  happy_var_1)
	 =  HappyAbsSyn9
		 (AbsVarg.Program (reverse happy_var_1) (reverse happy_var_2)
	)
happyReduction_6 _ _  = notHappyAtAll 

happyReduce_7 = happySpecReduce_0  10 happyReduction_7
happyReduction_7  =  HappyAbsSyn10
		 ([]
	)

happyReduce_8 = happySpecReduce_2  10 happyReduction_8
happyReduction_8 (HappyAbsSyn24  happy_var_2)
	(HappyAbsSyn10  happy_var_1)
	 =  HappyAbsSyn10
		 (flip (:) happy_var_1 happy_var_2
	)
happyReduction_8 _ _  = notHappyAtAll 

happyReduce_9 = happySpecReduce_3  11 happyReduction_9
happyReduction_9 _
	(HappyAbsSyn6  happy_var_2)
	_
	 =  HappyAbsSyn11
		 (AbsVarg.Import happy_var_2
	)
happyReduction_9 _ _ _  = notHappyAtAll 

happyReduce_10 = happySpecReduce_0  12 happyReduction_10
happyReduction_10  =  HappyAbsSyn12
		 ([]
	)

happyReduce_11 = happySpecReduce_2  12 happyReduction_11
happyReduction_11 (HappyAbsSyn11  happy_var_2)
	(HappyAbsSyn12  happy_var_1)
	 =  HappyAbsSyn12
		 (flip (:) happy_var_1 happy_var_2
	)
happyReduction_11 _ _  = notHappyAtAll 

happyReduce_12 = happySpecReduce_1  13 happyReduction_12
happyReduction_12 (HappyAbsSyn7  happy_var_1)
	 =  HappyAbsSyn13
		 (AbsVarg.InferredTypeParam happy_var_1
	)
happyReduction_12 _  = notHappyAtAll 

happyReduce_13 = happySpecReduce_1  13 happyReduction_13
happyReduction_13 (HappyAbsSyn6  happy_var_1)
	 =  HappyAbsSyn13
		 (AbsVarg.ConcreteTypeParam happy_var_1
	)
happyReduction_13 _  = notHappyAtAll 

happyReduce_14 = happySpecReduce_0  14 happyReduction_14
happyReduction_14  =  HappyAbsSyn14
		 ([]
	)

happyReduce_15 = happySpecReduce_2  14 happyReduction_15
happyReduction_15 (HappyAbsSyn15  happy_var_2)
	(HappyAbsSyn14  happy_var_1)
	 =  HappyAbsSyn14
		 (flip (:) happy_var_1 happy_var_2
	)
happyReduction_15 _ _  = notHappyAtAll 

happyReduce_16 = happySpecReduce_1  15 happyReduction_16
happyReduction_16 (HappyAbsSyn13  happy_var_1)
	 =  HappyAbsSyn15
		 (AbsVarg.UnconstrainedTypeParam happy_var_1
	)
happyReduction_16 _  = notHappyAtAll 

happyReduce_17 = happyReduce 5 15 happyReduction_17
happyReduction_17 (_ `HappyStk`
	(HappyAbsSyn19  happy_var_4) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn13  happy_var_2) `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn15
		 (AbsVarg.SuperConstrainedTypeParam happy_var_2 happy_var_4
	) `HappyStk` happyRest

happyReduce_18 = happyReduce 5 15 happyReduction_18
happyReduction_18 (_ `HappyStk`
	(HappyAbsSyn19  happy_var_4) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn13  happy_var_2) `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn15
		 (AbsVarg.DerivingConstrainedTypeParam happy_var_2 happy_var_4
	) `HappyStk` happyRest

happyReduce_19 = happySpecReduce_0  16 happyReduction_19
happyReduction_19  =  HappyAbsSyn16
		 ([]
	)

happyReduce_20 = happySpecReduce_2  16 happyReduction_20
happyReduction_20 (HappyAbsSyn17  happy_var_2)
	(HappyAbsSyn16  happy_var_1)
	 =  HappyAbsSyn16
		 (flip (:) happy_var_1 happy_var_2
	)
happyReduction_20 _ _  = notHappyAtAll 

happyReduce_21 = happyReduce 5 17 happyReduction_21
happyReduction_21 (_ `HappyStk`
	(HappyAbsSyn19  happy_var_4) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn7  happy_var_2) `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn17
		 (AbsVarg.ArgumentDefinition happy_var_2 happy_var_4
	) `HappyStk` happyRest

happyReduce_22 = happySpecReduce_1  17 happyReduction_22
happyReduction_22 (HappyAbsSyn7  happy_var_1)
	 =  HappyAbsSyn17
		 (AbsVarg.InferredArgumentDef happy_var_1
	)
happyReduction_22 _  = notHappyAtAll 

happyReduce_23 = happySpecReduce_2  18 happyReduction_23
happyReduction_23 (HappyAbsSyn14  happy_var_2)
	(HappyAbsSyn6  happy_var_1)
	 =  HappyAbsSyn18
		 (AbsVarg.ConcreteType happy_var_1 (reverse happy_var_2)
	)
happyReduction_23 _ _  = notHappyAtAll 

happyReduce_24 = happySpecReduce_2  18 happyReduction_24
happyReduction_24 (HappyAbsSyn14  happy_var_2)
	(HappyAbsSyn7  happy_var_1)
	 =  HappyAbsSyn18
		 (AbsVarg.TemplateType happy_var_1 (reverse happy_var_2)
	)
happyReduction_24 _ _  = notHappyAtAll 

happyReduce_25 = happySpecReduce_1  19 happyReduction_25
happyReduction_25 (HappyAbsSyn21  happy_var_1)
	 =  HappyAbsSyn19
		 (AbsVarg.Type happy_var_1
	)
happyReduction_25 _  = notHappyAtAll 

happyReduce_26 = happySpecReduce_1  19 happyReduction_26
happyReduction_26 (HappyAbsSyn19  happy_var_1)
	 =  HappyAbsSyn19
		 (happy_var_1
	)
happyReduction_26 _  = notHappyAtAll 

happyReduce_27 = happySpecReduce_3  20 happyReduction_27
happyReduction_27 _
	(HappyAbsSyn19  happy_var_2)
	_
	 =  HappyAbsSyn19
		 (happy_var_2
	)
happyReduction_27 _ _ _  = notHappyAtAll 

happyReduce_28 = happySpecReduce_0  21 happyReduction_28
happyReduction_28  =  HappyAbsSyn21
		 ([]
	)

happyReduce_29 = happySpecReduce_1  21 happyReduction_29
happyReduction_29 (HappyAbsSyn18  happy_var_1)
	 =  HappyAbsSyn21
		 ((:[]) happy_var_1
	)
happyReduction_29 _  = notHappyAtAll 

happyReduce_30 = happySpecReduce_3  21 happyReduction_30
happyReduction_30 (HappyAbsSyn21  happy_var_3)
	_
	(HappyAbsSyn18  happy_var_1)
	 =  HappyAbsSyn21
		 ((:) happy_var_1 happy_var_3
	)
happyReduction_30 _ _ _  = notHappyAtAll 

happyReduce_31 = happySpecReduce_2  22 happyReduction_31
happyReduction_31 (HappyAbsSyn19  happy_var_2)
	(HappyAbsSyn6  happy_var_1)
	 =  HappyAbsSyn22
		 (AbsVarg.Class happy_var_1 happy_var_2
	)
happyReduction_31 _ _  = notHappyAtAll 

happyReduce_32 = happySpecReduce_1  23 happyReduction_32
happyReduction_32 (HappyAbsSyn22  happy_var_1)
	 =  HappyAbsSyn23
		 ((:[]) happy_var_1
	)
happyReduction_32 _  = notHappyAtAll 

happyReduce_33 = happySpecReduce_3  23 happyReduction_33
happyReduction_33 (HappyAbsSyn23  happy_var_3)
	_
	(HappyAbsSyn22  happy_var_1)
	 =  HappyAbsSyn23
		 ((:) happy_var_1 happy_var_3
	)
happyReduction_33 _ _ _  = notHappyAtAll 

happyReduce_34 = happyReduce 7 24 happyReduction_34
happyReduction_34 (_ `HappyStk`
	(HappyAbsSyn37  happy_var_6) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn6  happy_var_3) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn27  happy_var_1) `HappyStk`
	happyRest)
	 = HappyAbsSyn24
		 (AbsVarg.StructDefinition (reverse happy_var_1) happy_var_3 happy_var_6
	) `HappyStk` happyRest

happyReduce_35 = happyReduce 9 24 happyReduction_35
happyReduction_35 (_ `HappyStk`
	(HappyAbsSyn29  happy_var_8) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn26  happy_var_5) `HappyStk`
	(HappyAbsSyn25  happy_var_4) `HappyStk`
	(HappyAbsSyn6  happy_var_3) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn27  happy_var_1) `HappyStk`
	happyRest)
	 = HappyAbsSyn24
		 (AbsVarg.ClassDefinition (reverse happy_var_1) happy_var_3 happy_var_4 happy_var_5 happy_var_8
	) `HappyStk` happyRest

happyReduce_36 = happyReduce 10 24 happyReduction_36
happyReduction_36 (_ `HappyStk`
	(HappyAbsSyn29  happy_var_9) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn26  happy_var_6) `HappyStk`
	(HappyAbsSyn25  happy_var_5) `HappyStk`
	(HappyAbsSyn14  happy_var_4) `HappyStk`
	(HappyAbsSyn6  happy_var_3) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn27  happy_var_1) `HappyStk`
	happyRest)
	 = HappyAbsSyn24
		 (AbsVarg.TemplateDefinition (reverse happy_var_1) happy_var_3 (reverse happy_var_4) happy_var_5 happy_var_6 happy_var_9
	) `HappyStk` happyRest

happyReduce_37 = happySpecReduce_2  25 happyReduction_37
happyReduction_37 (HappyAbsSyn23  happy_var_2)
	_
	 =  HappyAbsSyn25
		 (AbsVarg.Implementing happy_var_2
	)
happyReduction_37 _ _  = notHappyAtAll 

happyReduce_38 = happySpecReduce_0  25 happyReduction_38
happyReduction_38  =  HappyAbsSyn25
		 (AbsVarg.NotImplementing
	)

happyReduce_39 = happySpecReduce_2  26 happyReduction_39
happyReduction_39 (HappyAbsSyn22  happy_var_2)
	_
	 =  HappyAbsSyn26
		 (AbsVarg.Deriving happy_var_2
	)
happyReduction_39 _ _  = notHappyAtAll 

happyReduce_40 = happySpecReduce_0  26 happyReduction_40
happyReduction_40  =  HappyAbsSyn26
		 (AbsVarg.NotDeriving
	)

happyReduce_41 = happySpecReduce_0  27 happyReduction_41
happyReduction_41  =  HappyAbsSyn27
		 ([]
	)

happyReduce_42 = happySpecReduce_2  27 happyReduction_42
happyReduction_42 (HappyAbsSyn28  happy_var_2)
	(HappyAbsSyn27  happy_var_1)
	 =  HappyAbsSyn27
		 (flip (:) happy_var_1 happy_var_2
	)
happyReduction_42 _ _  = notHappyAtAll 

happyReduce_43 = happySpecReduce_1  28 happyReduction_43
happyReduction_43 _
	 =  HappyAbsSyn28
		 (AbsVarg.ClassModifier_module
	)

happyReduce_44 = happySpecReduce_1  28 happyReduction_44
happyReduction_44 _
	 =  HappyAbsSyn28
		 (AbsVarg.ClassModifier_interface
	)

happyReduce_45 = happySpecReduce_1  28 happyReduction_45
happyReduction_45 _
	 =  HappyAbsSyn28
		 (AbsVarg.ClassModifier_sealed
	)

happyReduce_46 = happySpecReduce_2  29 happyReduction_46
happyReduction_46 (HappyAbsSyn33  happy_var_2)
	(HappyAbsSyn31  happy_var_1)
	 =  HappyAbsSyn29
		 (AbsVarg.ClassContent happy_var_1 happy_var_2
	)
happyReduction_46 _ _  = notHappyAtAll 

happyReduce_47 = happySpecReduce_1  30 happyReduction_47
happyReduction_47 (HappyAbsSyn6  happy_var_1)
	 =  HappyAbsSyn30
		 (AbsVarg.EmptyMemberDefinition happy_var_1
	)
happyReduction_47 _  = notHappyAtAll 

happyReduce_48 = happyReduce 5 30 happyReduction_48
happyReduction_48 (_ `HappyStk`
	(HappyAbsSyn37  happy_var_4) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn6  happy_var_1) `HappyStk`
	happyRest)
	 = HappyAbsSyn30
		 (AbsVarg.MemberDefinition happy_var_1 happy_var_4
	) `HappyStk` happyRest

happyReduce_49 = happySpecReduce_0  31 happyReduction_49
happyReduction_49  =  HappyAbsSyn31
		 ([]
	)

happyReduce_50 = happySpecReduce_1  31 happyReduction_50
happyReduction_50 (HappyAbsSyn30  happy_var_1)
	 =  HappyAbsSyn31
		 ((:[]) happy_var_1
	)
happyReduction_50 _  = notHappyAtAll 

happyReduce_51 = happySpecReduce_3  31 happyReduction_51
happyReduction_51 (HappyAbsSyn31  happy_var_3)
	_
	(HappyAbsSyn30  happy_var_1)
	 =  HappyAbsSyn31
		 ((:) happy_var_1 happy_var_3
	)
happyReduction_51 _ _ _  = notHappyAtAll 

happyReduce_52 = happyReduce 8 32 happyReduction_52
happyReduction_52 ((HappyAbsSyn39  happy_var_8) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn19  happy_var_6) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn16  happy_var_4) `HappyStk`
	(HappyAbsSyn7  happy_var_3) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn34  happy_var_1) `HappyStk`
	happyRest)
	 = HappyAbsSyn32
		 (AbsVarg.MemberFunctionDefinition (reverse happy_var_1) happy_var_3 (reverse happy_var_4) happy_var_6 happy_var_8
	) `HappyStk` happyRest

happyReduce_53 = happyReduce 7 32 happyReduction_53
happyReduction_53 ((HappyAbsSyn19  happy_var_7) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn16  happy_var_4) `HappyStk`
	(HappyAbsSyn7  happy_var_3) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn34  happy_var_1) `HappyStk`
	happyRest)
	 = HappyAbsSyn32
		 (AbsVarg.AbstractFunctionDefinition (reverse happy_var_1) happy_var_3 (reverse happy_var_4) happy_var_7
	) `HappyStk` happyRest

happyReduce_54 = happySpecReduce_0  33 happyReduction_54
happyReduction_54  =  HappyAbsSyn33
		 ([]
	)

happyReduce_55 = happySpecReduce_1  33 happyReduction_55
happyReduction_55 (HappyAbsSyn32  happy_var_1)
	 =  HappyAbsSyn33
		 ((:[]) happy_var_1
	)
happyReduction_55 _  = notHappyAtAll 

happyReduce_56 = happySpecReduce_3  33 happyReduction_56
happyReduction_56 (HappyAbsSyn33  happy_var_3)
	_
	(HappyAbsSyn32  happy_var_1)
	 =  HappyAbsSyn33
		 ((:) happy_var_1 happy_var_3
	)
happyReduction_56 _ _ _  = notHappyAtAll 

happyReduce_57 = happySpecReduce_0  34 happyReduction_57
happyReduction_57  =  HappyAbsSyn34
		 ([]
	)

happyReduce_58 = happySpecReduce_2  34 happyReduction_58
happyReduction_58 (HappyAbsSyn35  happy_var_2)
	(HappyAbsSyn34  happy_var_1)
	 =  HappyAbsSyn34
		 (flip (:) happy_var_1 happy_var_2
	)
happyReduction_58 _ _  = notHappyAtAll 

happyReduce_59 = happySpecReduce_1  35 happyReduction_59
happyReduction_59 _
	 =  HappyAbsSyn35
		 (AbsVarg.FunctionModifier_static
	)

happyReduce_60 = happySpecReduce_1  35 happyReduction_60
happyReduction_60 _
	 =  HappyAbsSyn35
		 (AbsVarg.FunctionModifier_internal
	)

happyReduce_61 = happySpecReduce_1  35 happyReduction_61
happyReduction_61 _
	 =  HappyAbsSyn35
		 (AbsVarg.FunctionModifier_implement
	)

happyReduce_62 = happySpecReduce_1  35 happyReduction_62
happyReduction_62 _
	 =  HappyAbsSyn35
		 (AbsVarg.FunctionModifier1
	)

happyReduce_63 = happyReduce 4 36 happyReduction_63
happyReduction_63 ((HappyAbsSyn19  happy_var_4) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn7  happy_var_2) `HappyStk`
	(HappyAbsSyn38  happy_var_1) `HappyStk`
	happyRest)
	 = HappyAbsSyn36
		 (AbsVarg.ModifiedClassField happy_var_1 happy_var_2 happy_var_4
	) `HappyStk` happyRest

happyReduce_64 = happySpecReduce_3  36 happyReduction_64
happyReduction_64 (HappyAbsSyn19  happy_var_3)
	_
	(HappyAbsSyn7  happy_var_1)
	 =  HappyAbsSyn36
		 (AbsVarg.NormalClassField happy_var_1 happy_var_3
	)
happyReduction_64 _ _ _  = notHappyAtAll 

happyReduce_65 = happySpecReduce_0  37 happyReduction_65
happyReduction_65  =  HappyAbsSyn37
		 ([]
	)

happyReduce_66 = happySpecReduce_1  37 happyReduction_66
happyReduction_66 (HappyAbsSyn36  happy_var_1)
	 =  HappyAbsSyn37
		 ((:[]) happy_var_1
	)
happyReduction_66 _  = notHappyAtAll 

happyReduce_67 = happySpecReduce_3  37 happyReduction_67
happyReduction_67 (HappyAbsSyn37  happy_var_3)
	_
	(HappyAbsSyn36  happy_var_1)
	 =  HappyAbsSyn37
		 ((:) happy_var_1 happy_var_3
	)
happyReduction_67 _ _ _  = notHappyAtAll 

happyReduce_68 = happySpecReduce_1  38 happyReduction_68
happyReduction_68 _
	 =  HappyAbsSyn38
		 (AbsVarg.FieldModifier_public
	)

happyReduce_69 = happySpecReduce_1  38 happyReduction_69
happyReduction_69 _
	 =  HappyAbsSyn38
		 (AbsVarg.FieldModifier1
	)

happyReduce_70 = happyReduce 6 39 happyReduction_70
happyReduction_70 ((HappyAbsSyn39  happy_var_6) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn40  happy_var_3) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn39
		 (AbsVarg.EDefinitionsList happy_var_3 happy_var_6
	) `HappyStk` happyRest

happyReduce_71 = happyReduce 4 39 happyReduction_71
happyReduction_71 ((HappyAbsSyn39  happy_var_4) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn41  happy_var_2) `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn39
		 (AbsVarg.EDefinition happy_var_2 happy_var_4
	) `HappyStk` happyRest

happyReduce_72 = happyReduce 6 39 happyReduction_72
happyReduction_72 (_ `HappyStk`
	(HappyAbsSyn42  happy_var_5) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn39  happy_var_2) `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn39
		 (AbsVarg.EMatch happy_var_2 happy_var_5
	) `HappyStk` happyRest

happyReduce_73 = happyReduce 6 39 happyReduction_73
happyReduction_73 ((HappyAbsSyn39  happy_var_6) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn39  happy_var_4) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn39  happy_var_2) `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn39
		 (AbsVarg.EIfThenElse happy_var_2 happy_var_4 happy_var_6
	) `HappyStk` happyRest

happyReduce_74 = happyReduce 8 39 happyReduction_74
happyReduction_74 (_ `HappyStk`
	(HappyAbsSyn39  happy_var_7) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn19  happy_var_5) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn16  happy_var_3) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn39
		 (AbsVarg.ELambda (reverse happy_var_3) happy_var_5 happy_var_7
	) `HappyStk` happyRest

happyReduce_75 = happySpecReduce_1  39 happyReduction_75
happyReduction_75 (HappyAbsSyn39  happy_var_1)
	 =  HappyAbsSyn39
		 (happy_var_1
	)
happyReduction_75 _  = notHappyAtAll 

happyReduce_76 = happySpecReduce_0  40 happyReduction_76
happyReduction_76  =  HappyAbsSyn40
		 ([]
	)

happyReduce_77 = happySpecReduce_1  40 happyReduction_77
happyReduction_77 (HappyAbsSyn41  happy_var_1)
	 =  HappyAbsSyn40
		 ((:[]) happy_var_1
	)
happyReduction_77 _  = notHappyAtAll 

happyReduce_78 = happySpecReduce_3  40 happyReduction_78
happyReduction_78 (HappyAbsSyn40  happy_var_3)
	_
	(HappyAbsSyn41  happy_var_1)
	 =  HappyAbsSyn40
		 ((:) happy_var_1 happy_var_3
	)
happyReduction_78 _ _ _  = notHappyAtAll 

happyReduce_79 = happySpecReduce_3  41 happyReduction_79
happyReduction_79 (HappyAbsSyn7  happy_var_3)
	_
	(HappyAbsSyn39  happy_var_1)
	 =  HappyAbsSyn41
		 (AbsVarg.IDefinition happy_var_1 happy_var_3
	)
happyReduction_79 _ _ _  = notHappyAtAll 

happyReduce_80 = happySpecReduce_0  42 happyReduction_80
happyReduction_80  =  HappyAbsSyn42
		 ([]
	)

happyReduce_81 = happySpecReduce_1  42 happyReduction_81
happyReduction_81 (HappyAbsSyn43  happy_var_1)
	 =  HappyAbsSyn42
		 ((:[]) happy_var_1
	)
happyReduction_81 _  = notHappyAtAll 

happyReduce_82 = happySpecReduce_3  42 happyReduction_82
happyReduction_82 (HappyAbsSyn42  happy_var_3)
	_
	(HappyAbsSyn43  happy_var_1)
	 =  HappyAbsSyn42
		 ((:) happy_var_1 happy_var_3
	)
happyReduction_82 _ _ _  = notHappyAtAll 

happyReduce_83 = happySpecReduce_3  43 happyReduction_83
happyReduction_83 (HappyAbsSyn39  happy_var_3)
	_
	(HappyAbsSyn39  happy_var_1)
	 =  HappyAbsSyn43
		 (AbsVarg.IMatchClause happy_var_1 happy_var_3
	)
happyReduction_83 _ _ _  = notHappyAtAll 

happyReduce_84 = happySpecReduce_1  44 happyReduction_84
happyReduction_84 _
	 =  HappyAbsSyn44
		 (AbsVarg.ThisFunctor
	)

happyReduce_85 = happySpecReduce_1  44 happyReduction_85
happyReduction_85 _
	 =  HappyAbsSyn44
		 (AbsVarg.SuperFunctor
	)

happyReduce_86 = happySpecReduce_1  44 happyReduction_86
happyReduction_86 (HappyAbsSyn6  happy_var_1)
	 =  HappyAbsSyn44
		 (AbsVarg.TypeFunctor happy_var_1
	)
happyReduction_86 _  = notHappyAtAll 

happyReduce_87 = happySpecReduce_1  44 happyReduction_87
happyReduction_87 (HappyAbsSyn7  happy_var_1)
	 =  HappyAbsSyn44
		 (AbsVarg.InstanceFunctor happy_var_1
	)
happyReduction_87 _  = notHappyAtAll 

happyReduce_88 = happySpecReduce_1  44 happyReduction_88
happyReduction_88 (HappyAbsSyn8  happy_var_1)
	 =  HappyAbsSyn44
		 (AbsVarg.MemberFunctor happy_var_1
	)
happyReduction_88 _  = notHappyAtAll 

happyReduce_89 = happySpecReduce_1  45 happyReduction_89
happyReduction_89 (HappyAbsSyn39  happy_var_1)
	 =  HappyAbsSyn45
		 (AbsVarg.ArgExpr happy_var_1
	)
happyReduction_89 _  = notHappyAtAll 

happyReduce_90 = happySpecReduce_1  45 happyReduction_90
happyReduction_90 (HappyAbsSyn44  happy_var_1)
	 =  HappyAbsSyn45
		 (AbsVarg.ArgFunc happy_var_1
	)
happyReduction_90 _  = notHappyAtAll 

happyReduce_91 = happySpecReduce_0  46 happyReduction_91
happyReduction_91  =  HappyAbsSyn46
		 ([]
	)

happyReduce_92 = happySpecReduce_2  46 happyReduction_92
happyReduction_92 (HappyAbsSyn45  happy_var_2)
	(HappyAbsSyn46  happy_var_1)
	 =  HappyAbsSyn46
		 (flip (:) happy_var_1 happy_var_2
	)
happyReduction_92 _ _  = notHappyAtAll 

happyReduce_93 = happySpecReduce_2  47 happyReduction_93
happyReduction_93 (HappyAbsSyn46  happy_var_2)
	(HappyAbsSyn44  happy_var_1)
	 =  HappyAbsSyn39
		 (AbsVarg.EApply happy_var_1 (reverse happy_var_2)
	)
happyReduction_93 _ _  = notHappyAtAll 

happyReduce_94 = happySpecReduce_1  47 happyReduction_94
happyReduction_94 (HappyAbsSyn4  happy_var_1)
	 =  HappyAbsSyn39
		 (AbsVarg.EInt happy_var_1
	)
happyReduction_94 _  = notHappyAtAll 

happyReduce_95 = happySpecReduce_1  47 happyReduction_95
happyReduction_95 (HappyAbsSyn5  happy_var_1)
	 =  HappyAbsSyn39
		 (AbsVarg.EReal happy_var_1
	)
happyReduction_95 _  = notHappyAtAll 

happyReduce_96 = happySpecReduce_1  47 happyReduction_96
happyReduction_96 _
	 =  HappyAbsSyn39
		 (AbsVarg.EWild
	)

happyReduce_97 = happySpecReduce_1  47 happyReduction_97
happyReduction_97 (HappyAbsSyn39  happy_var_1)
	 =  HappyAbsSyn39
		 (happy_var_1
	)
happyReduction_97 _  = notHappyAtAll 

happyReduce_98 = happySpecReduce_3  48 happyReduction_98
happyReduction_98 (HappyAbsSyn39  happy_var_3)
	_
	(HappyAbsSyn39  happy_var_1)
	 =  HappyAbsSyn39
		 (AbsVarg.EEq happy_var_1 happy_var_3
	)
happyReduction_98 _ _ _  = notHappyAtAll 

happyReduce_99 = happySpecReduce_3  48 happyReduction_99
happyReduction_99 (HappyAbsSyn39  happy_var_3)
	_
	(HappyAbsSyn39  happy_var_1)
	 =  HappyAbsSyn39
		 (AbsVarg.ELq happy_var_1 happy_var_3
	)
happyReduction_99 _ _ _  = notHappyAtAll 

happyReduce_100 = happySpecReduce_3  48 happyReduction_100
happyReduction_100 (HappyAbsSyn39  happy_var_3)
	_
	(HappyAbsSyn39  happy_var_1)
	 =  HappyAbsSyn39
		 (AbsVarg.EGt happy_var_1 happy_var_3
	)
happyReduction_100 _ _ _  = notHappyAtAll 

happyReduce_101 = happySpecReduce_3  48 happyReduction_101
happyReduction_101 (HappyAbsSyn39  happy_var_3)
	_
	(HappyAbsSyn39  happy_var_1)
	 =  HappyAbsSyn39
		 (AbsVarg.ELeq happy_var_1 happy_var_3
	)
happyReduction_101 _ _ _  = notHappyAtAll 

happyReduce_102 = happySpecReduce_3  48 happyReduction_102
happyReduction_102 (HappyAbsSyn39  happy_var_3)
	_
	(HappyAbsSyn39  happy_var_1)
	 =  HappyAbsSyn39
		 (AbsVarg.EGeq happy_var_1 happy_var_3
	)
happyReduction_102 _ _ _  = notHappyAtAll 

happyReduce_103 = happySpecReduce_1  48 happyReduction_103
happyReduction_103 (HappyAbsSyn39  happy_var_1)
	 =  HappyAbsSyn39
		 (happy_var_1
	)
happyReduction_103 _  = notHappyAtAll 

happyReduce_104 = happySpecReduce_3  49 happyReduction_104
happyReduction_104 (HappyAbsSyn39  happy_var_3)
	_
	(HappyAbsSyn39  happy_var_1)
	 =  HappyAbsSyn39
		 (AbsVarg.EAdd happy_var_1 happy_var_3
	)
happyReduction_104 _ _ _  = notHappyAtAll 

happyReduce_105 = happySpecReduce_3  49 happyReduction_105
happyReduction_105 (HappyAbsSyn39  happy_var_3)
	_
	(HappyAbsSyn39  happy_var_1)
	 =  HappyAbsSyn39
		 (AbsVarg.ESub happy_var_1 happy_var_3
	)
happyReduction_105 _ _ _  = notHappyAtAll 

happyReduce_106 = happySpecReduce_1  49 happyReduction_106
happyReduction_106 (HappyAbsSyn39  happy_var_1)
	 =  HappyAbsSyn39
		 (happy_var_1
	)
happyReduction_106 _  = notHappyAtAll 

happyReduce_107 = happySpecReduce_3  50 happyReduction_107
happyReduction_107 (HappyAbsSyn39  happy_var_3)
	_
	(HappyAbsSyn39  happy_var_1)
	 =  HappyAbsSyn39
		 (AbsVarg.EMul happy_var_1 happy_var_3
	)
happyReduction_107 _ _ _  = notHappyAtAll 

happyReduce_108 = happySpecReduce_3  50 happyReduction_108
happyReduction_108 (HappyAbsSyn39  happy_var_3)
	_
	(HappyAbsSyn39  happy_var_1)
	 =  HappyAbsSyn39
		 (AbsVarg.EDiv happy_var_1 happy_var_3
	)
happyReduction_108 _ _ _  = notHappyAtAll 

happyReduce_109 = happySpecReduce_1  50 happyReduction_109
happyReduction_109 (HappyAbsSyn39  happy_var_1)
	 =  HappyAbsSyn39
		 (happy_var_1
	)
happyReduction_109 _  = notHappyAtAll 

happyReduce_110 = happySpecReduce_3  51 happyReduction_110
happyReduction_110 (HappyAbsSyn39  happy_var_3)
	_
	(HappyAbsSyn39  happy_var_1)
	 =  HappyAbsSyn39
		 (AbsVarg.EPow happy_var_1 happy_var_3
	)
happyReduction_110 _ _ _  = notHappyAtAll 

happyReduce_111 = happySpecReduce_1  51 happyReduction_111
happyReduction_111 (HappyAbsSyn39  happy_var_1)
	 =  HappyAbsSyn39
		 (happy_var_1
	)
happyReduction_111 _  = notHappyAtAll 

happyReduce_112 = happySpecReduce_3  52 happyReduction_112
happyReduction_112 _
	(HappyAbsSyn39  happy_var_2)
	_
	 =  HappyAbsSyn39
		 (happy_var_2
	)
happyReduction_112 _ _ _  = notHappyAtAll 

happyNewToken action sts stk [] =
	action 111 111 notHappyAtAll (HappyState action) sts stk []

happyNewToken action sts stk (tk:tks) =
	let cont i = action i i tk (HappyState action) sts stk tks in
	case tk of {
	PT _ (TS _ 1) -> cont 53;
	PT _ (TS _ 2) -> cont 54;
	PT _ (TS _ 3) -> cont 55;
	PT _ (TS _ 4) -> cont 56;
	PT _ (TS _ 5) -> cont 57;
	PT _ (TS _ 6) -> cont 58;
	PT _ (TS _ 7) -> cont 59;
	PT _ (TS _ 8) -> cont 60;
	PT _ (TS _ 9) -> cont 61;
	PT _ (TS _ 10) -> cont 62;
	PT _ (TS _ 11) -> cont 63;
	PT _ (TS _ 12) -> cont 64;
	PT _ (TS _ 13) -> cont 65;
	PT _ (TS _ 14) -> cont 66;
	PT _ (TS _ 15) -> cont 67;
	PT _ (TS _ 16) -> cont 68;
	PT _ (TS _ 17) -> cont 69;
	PT _ (TS _ 18) -> cont 70;
	PT _ (TS _ 19) -> cont 71;
	PT _ (TS _ 20) -> cont 72;
	PT _ (TS _ 21) -> cont 73;
	PT _ (TS _ 22) -> cont 74;
	PT _ (TS _ 23) -> cont 75;
	PT _ (TS _ 24) -> cont 76;
	PT _ (TS _ 25) -> cont 77;
	PT _ (TS _ 26) -> cont 78;
	PT _ (TS _ 27) -> cont 79;
	PT _ (TS _ 28) -> cont 80;
	PT _ (TS _ 29) -> cont 81;
	PT _ (TS _ 30) -> cont 82;
	PT _ (TS _ 31) -> cont 83;
	PT _ (TS _ 32) -> cont 84;
	PT _ (TS _ 33) -> cont 85;
	PT _ (TS _ 34) -> cont 86;
	PT _ (TS _ 35) -> cont 87;
	PT _ (TS _ 36) -> cont 88;
	PT _ (TS _ 37) -> cont 89;
	PT _ (TS _ 38) -> cont 90;
	PT _ (TS _ 39) -> cont 91;
	PT _ (TS _ 40) -> cont 92;
	PT _ (TS _ 41) -> cont 93;
	PT _ (TS _ 42) -> cont 94;
	PT _ (TS _ 43) -> cont 95;
	PT _ (TS _ 44) -> cont 96;
	PT _ (TS _ 45) -> cont 97;
	PT _ (TS _ 46) -> cont 98;
	PT _ (TS _ 47) -> cont 99;
	PT _ (TS _ 48) -> cont 100;
	PT _ (TS _ 49) -> cont 101;
	PT _ (TS _ 50) -> cont 102;
	PT _ (TS _ 51) -> cont 103;
	PT _ (TS _ 52) -> cont 104;
	PT _ (TS _ 53) -> cont 105;
	PT _ (TI happy_dollar_dollar) -> cont 106;
	PT _ (TD happy_dollar_dollar) -> cont 107;
	PT _ (T_UIdent happy_dollar_dollar) -> cont 108;
	PT _ (T_LIdent happy_dollar_dollar) -> cont 109;
	PT _ (T_MFun happy_dollar_dollar) -> cont 110;
	_ -> happyError' ((tk:tks), [])
	}

happyError_ explist 111 tk tks = happyError' (tks, explist)
happyError_ explist _ tk tks = happyError' ((tk:tks), explist)

happyThen :: () => Err a -> (a -> Err b) -> Err b
happyThen = (thenM)
happyReturn :: () => a -> Err a
happyReturn = (returnM)
happyThen1 m k tks = (thenM) m (\a -> k a tks)
happyReturn1 :: () => a -> b -> Err a
happyReturn1 = \a tks -> (returnM) a
happyError' :: () => ([(Token)], [String]) -> Err a
happyError' = (\(tokens, _) -> happyError tokens)
pProgramDef tks = happySomeParser where
 happySomeParser = happyThen (happyParse action_0 tks) (\x -> case x of {HappyAbsSyn9 z -> happyReturn z; _other -> notHappyAtAll })

happySeq = happyDontSeq


returnM :: a -> Err a
returnM = return

thenM :: Err a -> (a -> Err b) -> Err b
thenM = (>>=)

happyError :: [Token] -> Err a
happyError ts =
  Bad $ "syntax error at " ++ tokenPos ts ++ 
  case ts of
    [] -> []
    [Err _] -> " due to lexer error"
    _ -> " before " ++ unwords (map (id . prToken) (take 4 ts))

myLexer = tokens
{-# LINE 1 "templates/GenericTemplate.hs" #-}
{-# LINE 1 "templates/GenericTemplate.hs" #-}
{-# LINE 1 "<built-in>" #-}
{-# LINE 1 "<command-line>" #-}







# 1 "/usr/include/stdc-predef.h" 1 3 4

# 17 "/usr/include/stdc-predef.h" 3 4











































{-# LINE 7 "<command-line>" #-}
{-# LINE 1 "/home/mateusz/.stack/programs/x86_64-linux/ghc-tinfo6-8.4.3/lib/ghc-8.4.3/include/ghcversion.h" #-}















{-# LINE 7 "<command-line>" #-}
{-# LINE 1 "/tmp/ghc21666_0/ghc_2.h" #-}




















































































































































































{-# LINE 7 "<command-line>" #-}
{-# LINE 1 "templates/GenericTemplate.hs" #-}
-- Id: GenericTemplate.hs,v 1.26 2005/01/14 14:47:22 simonmar Exp 









{-# LINE 43 "templates/GenericTemplate.hs" #-}

data Happy_IntList = HappyCons Int Happy_IntList







{-# LINE 65 "templates/GenericTemplate.hs" #-}

{-# LINE 75 "templates/GenericTemplate.hs" #-}

{-# LINE 84 "templates/GenericTemplate.hs" #-}

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

{-# LINE 137 "templates/GenericTemplate.hs" #-}

{-# LINE 147 "templates/GenericTemplate.hs" #-}
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

{-# LINE 267 "templates/GenericTemplate.hs" #-}
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

{-# LINE 333 "templates/GenericTemplate.hs" #-}
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
