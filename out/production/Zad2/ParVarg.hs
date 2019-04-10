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
	| HappyAbsSyn21 ([TypeDef])
	| HappyAbsSyn22 ([PrimType])
	| HappyAbsSyn23 (ClassType)
	| HappyAbsSyn24 ([ClassType])
	| HappyAbsSyn25 (ClassDef)
	| HappyAbsSyn26 (IsImplementing)
	| HappyAbsSyn27 (IsDeriving)
	| HappyAbsSyn28 ([ClassModifier])
	| HappyAbsSyn29 (ClassModifier)
	| HappyAbsSyn30 (ClassContents)
	| HappyAbsSyn31 (MemberDef)
	| HappyAbsSyn32 ([MemberDef])
	| HappyAbsSyn33 (FunDef)
	| HappyAbsSyn34 (RetType)
	| HappyAbsSyn35 (AbsRetType)
	| HappyAbsSyn36 ([FunDef])
	| HappyAbsSyn37 ([FunctionModifier])
	| HappyAbsSyn38 (FunctionModifier)
	| HappyAbsSyn39 (ClassField)
	| HappyAbsSyn40 ([ClassField])
	| HappyAbsSyn41 (FieldModifier)
	| HappyAbsSyn42 (Expr)
	| HappyAbsSyn43 ([AsDef])
	| HappyAbsSyn44 (AsDef)
	| HappyAbsSyn45 ([MatchClause])
	| HappyAbsSyn46 (MatchClause)
	| HappyAbsSyn47 (Functorial)
	| HappyAbsSyn48 (Arg)
	| HappyAbsSyn49 ([Arg])
	| HappyAbsSyn51 (ListElem)
	| HappyAbsSyn52 ([ListElem])

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
 action_205,
 action_206,
 action_207,
 action_208,
 action_209,
 action_210,
 action_211,
 action_212,
 action_213,
 action_214,
 action_215,
 action_216,
 action_217,
 action_218 :: () => Int -> ({-HappyReduction (Err) = -}
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
 happyReduce_112,
 happyReduce_113,
 happyReduce_114,
 happyReduce_115,
 happyReduce_116,
 happyReduce_117,
 happyReduce_118,
 happyReduce_119,
 happyReduce_120,
 happyReduce_121,
 happyReduce_122,
 happyReduce_123,
 happyReduce_124 :: () => ({-HappyReduction (Err) = -}
	   Int 
	-> (Token)
	-> HappyState (Token) (HappyStk HappyAbsSyn -> [(Token)] -> (Err) HappyAbsSyn)
	-> [HappyState (Token) (HappyStk HappyAbsSyn -> [(Token)] -> (Err) HappyAbsSyn)] 
	-> HappyStk HappyAbsSyn 
	-> [(Token)] -> (Err) HappyAbsSyn)

happyExpList :: Happy_Data_Array.Array Int Int
happyExpList = Happy_Data_Array.listArray (0,852) ([0,0,0,0,0,0,0,0,0,0,0,0,0,0,16,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,16,0,0,0,1024,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,512,43552,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,4,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,64,0,0,0,0,0,0,2048,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,16,0,0,0,0,0,512,0,0,0,0,0,0,128,0,0,0,0,0,0,0,0,512,0,0,0,0,0,0,1024,0,0,0,0,12288,8192,0,24,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,32768,0,0,0,0,0,0,0,0,0,0,0,0,0,32768,0,0,192,0,0,0,0,0,0,0,0,0,0,0,0,32768,4,2,0,0,8192,0,0,0,96,0,0,0,64,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,16384,0,0,0,0,0,0,0,512,0,0,0,0,0,0,0,0,0,0,0,0,0,32768,0,0,0,0,0,0,0,256,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,32,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,8,0,0,6144,0,0,0,0,1,0,0,0,0,0,0,64,0,0,0,0,0,0,0,0,0,128,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,2,16,0,0,0,0,0,0,8192,0,0,0,0,0,0,0,16,0,0,0,32,0,0,24576,0,0,0,1024,0,0,0,12,0,0,0,128,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,9,4,0,0,16384,0,0,0,192,0,0,0,16,0,0,0,0,0,0,0,0,0,0,3,0,0,0,49152,0,0,96,0,0,0,0,24,0,3072,0,0,0,0,0,0,0,0,0,0,0,0,0,0,16,0,0,0,0,0,1,0,0,0,0,0,0,0,2048,0,0,0,0,16,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,512,0,0,0,6,0,0,0,4,0,0,0,0,0,0,0,128,0,0,0,0,0,0,4096,0,0,0,0,0,0,0,0,0,32,0,0,0,0,0,0,128,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,2,0,0,1536,0,0,0,0,0,0,0,0,0,0,0,16,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,2124,2,0,0,0,0,0,0,0,4,0,0,0,0,0,0,0,0,0,0,0,0,0,256,0,0,0,0,0,0,9,4,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,64,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,32768,0,0,0,0,0,0,0,0,0,0,0,4112,0,0,8192,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,32768,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,64,0,0,0,4,512,0,3072,0,0,0,0,0,0,0,0,0,0,4096,0,0,0,48,0,0,0,512,0,0,0,0,0,0,64,4352,16449,61584,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,8,0,0,0,0,0,0,1,0,0,0,0,0,10240,396,0,0,0,0,0,32768,16,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,4096,49152,4164,9232,124,0,0,0,2,2184,33282,3972,0,0,0,0,0,0,0,0,0,0,2048,8192,2082,37384,62,0,0,0,1,1092,16641,1986,0,0,0,32,34944,8224,63560,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,16384,0,0,0,192,0,0,0,0,0,0,0,0,0,0,512,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,4,0,0,0,0,32768,0,0,0,0,0,0,0,0,1,0,0,0,0,2,2184,33282,3972,0,0,0,0,0,0,0,0,0,0,32768,0,0,0,0,0,0,0,0,16,0,0,0,0,0,64,0,0,0,0,0,0,0,0,0,0,0,0,0,32768,0,32,8192,993,0,0,0,16,1024,0,31780,0,0,0,512,32768,0,33920,15,0,0,16384,0,16,36864,496,0,0,0,8,512,0,15890,0,0,0,256,16384,0,49728,7,0,0,8192,0,8,18432,248,0,0,0,4,256,0,7945,0,0,0,128,8192,0,57632,3,0,0,4096,0,4,9216,124,0,0,0,2,128,32768,3972,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,32,34944,8224,63560,0,0,0,0,0,0,0,0,0,0,0,20,0,0,0,0,0,0,640,0,0,0,0,0,0,20480,0,0,0,0,0,0,0,10,0,0,0,0,0,0,320,0,0,0,0,0,0,33792,0,0,0,0,0,0,32768,16,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,4096,16,0,0,32,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,2048,8192,2082,4616,62,0,0,0,0,0,0,32,0,0,0,16384,0,0,0,0,0,0,1024,4096,1041,2308,31,0,0,0,0,0,0,256,0,0,0,16,17472,4112,31780,0,0,0,0,0,0,8192,0,0,0,0,0,0,0,0,0,0,0,8,8736,2056,15890,0,0,0,0,0,16,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,128,8704,32898,57632,3,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,64,0,0,49152,0,0,0,0,512,0,0,0,0,0,0,1,1092,16641,1986,0,0,0,0,0,0,0,0,0,0,1024,4096,1041,2308,31,0,0,0,32,0,0,0,0,0,0,0,0,0,512,0,0,0,0,4,0,0,0,0,0,16384,0,16657,36928,496,0,0,0,0,0,0,0,0,0,0,256,17408,260,49729,7,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,128,8704,32898,57632,3,0,0,8192,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	])

{-# NOINLINE happyExpListPerState #-}
happyExpListPerState st =
    token_strs_expected
  where token_strs = ["error","%dummy","%start_pProgramDef","Integer","Double","UIdent","LIdent","MFun","ProgramDef","ListClassDef","ImportDef","ListImportDef","TypeParam","ListConstrTypeParam","ConstrTypeParam","ListArgDef","ArgDef","PrimType","TypeDef","TypeDef1","ListTypeDef","ListPrimType","ClassType","ListClassType","ClassDef","IsImplementing","IsDeriving","ListClassModifier","ClassModifier","ClassContents","MemberDef","ListMemberDef","FunDef","RetType","AbsRetType","ListFunDef","ListFunctionModifier","FunctionModifier","ClassField","ListClassField","FieldModifier","Expr","ListAsDef","AsDef","ListMatchClause","MatchClause","Functorial","Arg","ListArg","Expr5","ListElem","ListListElem","Expr1","Expr2","Expr3","Expr4","Expr6","'('","')'","'*'","'+'","','","'-'","'->'","'/'","':'","';'","'<'","'<='","'='","'=='","'=>'","'>'","'>='","'?'","'['","'\\\\'","']'","'^'","'_'","'abstract'","'as'","'class'","'define'","'deriving'","'else'","'final | unique'","'function'","'has'","'if'","'implement'","'implementing'","'import'","'in'","'interface'","'internal'","'internal | unique'","'match'","'module'","'public'","'sealed'","'static'","'struct'","'super'","'template'","'then'","'this'","'where'","'with'","'{'","'}'","L_integ","L_doubl","L_UIdent","L_LIdent","L_MFun","%eof"]
        bit_start = st * 117
        bit_end = (st + 1) * 117
        read_bit = readArrayBit happyExpList
        bits = map read_bit [bit_start..bit_end - 1]
        bits_indexed = zip bits [0..116]
        token_strs_expected = concatMap f bits_indexed
        f (False, _) = []
        f (True, nr) = [token_strs !! nr]

action_0 (9) = happyGoto action_3
action_0 (12) = happyGoto action_4
action_0 _ = happyReduce_10

action_1 (112) = happyShift action_2
action_1 _ = happyFail (happyExpListPerState 1)

action_2 _ = happyReduce_1

action_3 (117) = happyAccept
action_3 _ = happyFail (happyExpListPerState 3)

action_4 (93) = happyShift action_7
action_4 (10) = happyGoto action_5
action_4 (11) = happyGoto action_6
action_4 _ = happyReduce_7

action_5 (117) = happyReduce_6
action_5 (25) = happyGoto action_10
action_5 (28) = happyGoto action_11
action_5 _ = happyReduce_44

action_6 _ = happyReduce_11

action_7 (114) = happyShift action_9
action_7 (6) = happyGoto action_8
action_7 _ = happyFail (happyExpListPerState 7)

action_8 (67) = happyShift action_19
action_8 _ = happyFail (happyExpListPerState 8)

action_9 _ = happyReduce_3

action_10 _ = happyReduce_8

action_11 (83) = happyShift action_13
action_11 (95) = happyShift action_14
action_11 (99) = happyShift action_15
action_11 (101) = happyShift action_16
action_11 (103) = happyShift action_17
action_11 (105) = happyShift action_18
action_11 (29) = happyGoto action_12
action_11 _ = happyFail (happyExpListPerState 11)

action_12 _ = happyReduce_45

action_13 (114) = happyShift action_9
action_13 (6) = happyGoto action_22
action_13 _ = happyFail (happyExpListPerState 13)

action_14 _ = happyReduce_47

action_15 _ = happyReduce_46

action_16 _ = happyReduce_48

action_17 (114) = happyShift action_9
action_17 (6) = happyGoto action_21
action_17 _ = happyFail (happyExpListPerState 17)

action_18 (114) = happyShift action_9
action_18 (6) = happyGoto action_20
action_18 _ = happyFail (happyExpListPerState 18)

action_19 _ = happyReduce_9

action_20 (14) = happyGoto action_26
action_20 _ = happyReduce_15

action_21 (108) = happyShift action_25
action_21 _ = happyFail (happyExpListPerState 21)

action_22 (92) = happyShift action_24
action_22 (26) = happyGoto action_23
action_22 _ = happyReduce_41

action_23 (85) = happyShift action_40
action_23 (27) = happyGoto action_39
action_23 _ = happyReduce_43

action_24 (114) = happyShift action_9
action_24 (6) = happyGoto action_36
action_24 (23) = happyGoto action_37
action_24 (24) = happyGoto action_38
action_24 _ = happyFail (happyExpListPerState 24)

action_25 (110) = happyShift action_35
action_25 _ = happyFail (happyExpListPerState 25)

action_26 (75) = happyShift action_32
action_26 (76) = happyShift action_33
action_26 (92) = happyShift action_24
action_26 (114) = happyShift action_9
action_26 (115) = happyShift action_34
action_26 (6) = happyGoto action_27
action_26 (7) = happyGoto action_28
action_26 (13) = happyGoto action_29
action_26 (15) = happyGoto action_30
action_26 (26) = happyGoto action_31
action_26 _ = happyReduce_41

action_27 _ = happyReduce_13

action_28 _ = happyReduce_12

action_29 _ = happyReduce_17

action_30 _ = happyReduce_16

action_31 (85) = happyShift action_40
action_31 (27) = happyGoto action_58
action_31 _ = happyReduce_43

action_32 _ = happyReduce_14

action_33 (75) = happyShift action_32
action_33 (114) = happyShift action_9
action_33 (115) = happyShift action_34
action_33 (6) = happyGoto action_27
action_33 (7) = happyGoto action_28
action_33 (13) = happyGoto action_57
action_33 _ = happyFail (happyExpListPerState 33)

action_34 _ = happyReduce_4

action_35 (97) = happyShift action_55
action_35 (100) = happyShift action_56
action_35 (115) = happyShift action_34
action_35 (7) = happyGoto action_51
action_35 (39) = happyGoto action_52
action_35 (40) = happyGoto action_53
action_35 (41) = happyGoto action_54
action_35 _ = happyReduce_72

action_36 (58) = happyShift action_50
action_36 (114) = happyShift action_9
action_36 (115) = happyShift action_34
action_36 (6) = happyGoto action_44
action_36 (7) = happyGoto action_45
action_36 (18) = happyGoto action_46
action_36 (19) = happyGoto action_47
action_36 (20) = happyGoto action_48
action_36 (22) = happyGoto action_49
action_36 _ = happyReduce_31

action_37 (62) = happyShift action_43
action_37 _ = happyReduce_35

action_38 _ = happyReduce_40

action_39 (108) = happyShift action_42
action_39 _ = happyFail (happyExpListPerState 39)

action_40 (114) = happyShift action_9
action_40 (6) = happyGoto action_36
action_40 (23) = happyGoto action_41
action_40 _ = happyFail (happyExpListPerState 40)

action_41 _ = happyReduce_42

action_42 (110) = happyShift action_71
action_42 _ = happyFail (happyExpListPerState 42)

action_43 (114) = happyShift action_9
action_43 (6) = happyGoto action_36
action_43 (23) = happyGoto action_37
action_43 (24) = happyGoto action_70
action_43 _ = happyFail (happyExpListPerState 43)

action_44 (14) = happyGoto action_69
action_44 _ = happyReduce_15

action_45 (14) = happyGoto action_68
action_45 _ = happyReduce_15

action_46 (64) = happyShift action_67
action_46 _ = happyReduce_32

action_47 _ = happyReduce_34

action_48 _ = happyReduce_27

action_49 _ = happyReduce_26

action_50 (58) = happyShift action_50
action_50 (114) = happyShift action_9
action_50 (115) = happyShift action_34
action_50 (6) = happyGoto action_44
action_50 (7) = happyGoto action_45
action_50 (18) = happyGoto action_46
action_50 (19) = happyGoto action_66
action_50 (20) = happyGoto action_48
action_50 (22) = happyGoto action_49
action_50 _ = happyReduce_31

action_51 (66) = happyShift action_65
action_51 _ = happyFail (happyExpListPerState 51)

action_52 (67) = happyShift action_64
action_52 _ = happyReduce_73

action_53 (111) = happyShift action_63
action_53 _ = happyFail (happyExpListPerState 53)

action_54 (115) = happyShift action_34
action_54 (7) = happyGoto action_62
action_54 _ = happyFail (happyExpListPerState 54)

action_55 _ = happyReduce_76

action_56 _ = happyReduce_75

action_57 (85) = happyShift action_60
action_57 (104) = happyShift action_61
action_57 _ = happyFail (happyExpListPerState 57)

action_58 (108) = happyShift action_59
action_58 _ = happyFail (happyExpListPerState 58)

action_59 (110) = happyShift action_84
action_59 _ = happyFail (happyExpListPerState 59)

action_60 (58) = happyShift action_50
action_60 (114) = happyShift action_9
action_60 (115) = happyShift action_34
action_60 (6) = happyGoto action_44
action_60 (7) = happyGoto action_45
action_60 (18) = happyGoto action_46
action_60 (19) = happyGoto action_81
action_60 (20) = happyGoto action_48
action_60 (21) = happyGoto action_83
action_60 (22) = happyGoto action_49
action_60 _ = happyReduce_31

action_61 (58) = happyShift action_50
action_61 (114) = happyShift action_9
action_61 (115) = happyShift action_34
action_61 (6) = happyGoto action_44
action_61 (7) = happyGoto action_45
action_61 (18) = happyGoto action_46
action_61 (19) = happyGoto action_81
action_61 (20) = happyGoto action_48
action_61 (21) = happyGoto action_82
action_61 (22) = happyGoto action_49
action_61 _ = happyReduce_31

action_62 (66) = happyShift action_80
action_62 _ = happyFail (happyExpListPerState 62)

action_63 _ = happyReduce_37

action_64 (97) = happyShift action_55
action_64 (100) = happyShift action_56
action_64 (115) = happyShift action_34
action_64 (7) = happyGoto action_51
action_64 (39) = happyGoto action_52
action_64 (40) = happyGoto action_79
action_64 (41) = happyGoto action_54
action_64 _ = happyReduce_72

action_65 (58) = happyShift action_50
action_65 (114) = happyShift action_9
action_65 (115) = happyShift action_34
action_65 (6) = happyGoto action_44
action_65 (7) = happyGoto action_45
action_65 (18) = happyGoto action_46
action_65 (19) = happyGoto action_78
action_65 (20) = happyGoto action_48
action_65 (22) = happyGoto action_49
action_65 _ = happyReduce_31

action_66 (59) = happyShift action_77
action_66 _ = happyFail (happyExpListPerState 66)

action_67 (114) = happyShift action_9
action_67 (115) = happyShift action_34
action_67 (6) = happyGoto action_44
action_67 (7) = happyGoto action_45
action_67 (18) = happyGoto action_46
action_67 (22) = happyGoto action_76
action_67 _ = happyReduce_31

action_68 (75) = happyShift action_32
action_68 (76) = happyShift action_33
action_68 (114) = happyShift action_9
action_68 (115) = happyShift action_34
action_68 (6) = happyGoto action_27
action_68 (7) = happyGoto action_28
action_68 (13) = happyGoto action_29
action_68 (15) = happyGoto action_30
action_68 _ = happyReduce_25

action_69 (75) = happyShift action_32
action_69 (76) = happyShift action_33
action_69 (114) = happyShift action_9
action_69 (115) = happyShift action_34
action_69 (6) = happyGoto action_27
action_69 (7) = happyGoto action_28
action_69 (13) = happyGoto action_29
action_69 (15) = happyGoto action_30
action_69 _ = happyReduce_24

action_70 _ = happyReduce_36

action_71 (114) = happyShift action_9
action_71 (6) = happyGoto action_72
action_71 (30) = happyGoto action_73
action_71 (31) = happyGoto action_74
action_71 (32) = happyGoto action_75
action_71 _ = happyReduce_52

action_72 (89) = happyShift action_95
action_72 _ = happyReduce_50

action_73 (111) = happyShift action_94
action_73 _ = happyFail (happyExpListPerState 73)

action_74 (67) = happyShift action_93
action_74 _ = happyReduce_53

action_75 (111) = happyReduce_61
action_75 (33) = happyGoto action_90
action_75 (36) = happyGoto action_91
action_75 (37) = happyGoto action_92
action_75 _ = happyReduce_64

action_76 _ = happyReduce_33

action_77 _ = happyReduce_28

action_78 _ = happyReduce_71

action_79 _ = happyReduce_74

action_80 (58) = happyShift action_50
action_80 (114) = happyShift action_9
action_80 (115) = happyShift action_34
action_80 (6) = happyGoto action_44
action_80 (7) = happyGoto action_45
action_80 (18) = happyGoto action_46
action_80 (19) = happyGoto action_89
action_80 (20) = happyGoto action_48
action_80 (22) = happyGoto action_49
action_80 _ = happyReduce_31

action_81 (62) = happyShift action_88
action_81 _ = happyReduce_29

action_82 (78) = happyShift action_87
action_82 _ = happyFail (happyExpListPerState 82)

action_83 (78) = happyShift action_86
action_83 _ = happyFail (happyExpListPerState 83)

action_84 (114) = happyShift action_9
action_84 (6) = happyGoto action_72
action_84 (30) = happyGoto action_85
action_84 (31) = happyGoto action_74
action_84 (32) = happyGoto action_75
action_84 _ = happyReduce_52

action_85 (111) = happyShift action_106
action_85 _ = happyFail (happyExpListPerState 85)

action_86 _ = happyReduce_19

action_87 _ = happyReduce_18

action_88 (58) = happyShift action_50
action_88 (114) = happyShift action_9
action_88 (115) = happyShift action_34
action_88 (6) = happyGoto action_44
action_88 (7) = happyGoto action_45
action_88 (18) = happyGoto action_46
action_88 (19) = happyGoto action_81
action_88 (20) = happyGoto action_48
action_88 (21) = happyGoto action_105
action_88 (22) = happyGoto action_49
action_88 _ = happyReduce_31

action_89 _ = happyReduce_70

action_90 (67) = happyShift action_104
action_90 _ = happyReduce_62

action_91 _ = happyReduce_49

action_92 (87) = happyShift action_99
action_92 (88) = happyShift action_100
action_92 (91) = happyShift action_101
action_92 (96) = happyShift action_102
action_92 (102) = happyShift action_103
action_92 (38) = happyGoto action_98
action_92 _ = happyFail (happyExpListPerState 92)

action_93 (114) = happyShift action_9
action_93 (6) = happyGoto action_72
action_93 (31) = happyGoto action_74
action_93 (32) = happyGoto action_97
action_93 _ = happyReduce_52

action_94 _ = happyReduce_38

action_95 (110) = happyShift action_96
action_95 _ = happyFail (happyExpListPerState 95)

action_96 (97) = happyShift action_55
action_96 (100) = happyShift action_56
action_96 (115) = happyShift action_34
action_96 (7) = happyGoto action_51
action_96 (39) = happyGoto action_52
action_96 (40) = happyGoto action_109
action_96 (41) = happyGoto action_54
action_96 _ = happyReduce_72

action_97 _ = happyReduce_54

action_98 _ = happyReduce_65

action_99 _ = happyReduce_69

action_100 (115) = happyShift action_34
action_100 (7) = happyGoto action_108
action_100 _ = happyFail (happyExpListPerState 100)

action_101 _ = happyReduce_68

action_102 _ = happyReduce_67

action_103 _ = happyReduce_66

action_104 (111) = happyReduce_61
action_104 (33) = happyGoto action_90
action_104 (36) = happyGoto action_107
action_104 (37) = happyGoto action_92
action_104 _ = happyReduce_64

action_105 _ = happyReduce_30

action_106 _ = happyReduce_39

action_107 _ = happyReduce_63

action_108 (16) = happyGoto action_111
action_108 _ = happyReduce_20

action_109 (111) = happyShift action_110
action_109 _ = happyFail (happyExpListPerState 109)

action_110 _ = happyReduce_51

action_111 (58) = happyShift action_116
action_111 (66) = happyShift action_117
action_111 (70) = happyReduce_58
action_111 (115) = happyShift action_34
action_111 (7) = happyGoto action_112
action_111 (17) = happyGoto action_113
action_111 (34) = happyGoto action_114
action_111 (35) = happyGoto action_115
action_111 _ = happyReduce_60

action_112 _ = happyReduce_23

action_113 _ = happyReduce_21

action_114 (70) = happyShift action_121
action_114 _ = happyFail (happyExpListPerState 114)

action_115 _ = happyReduce_56

action_116 (115) = happyShift action_34
action_116 (7) = happyGoto action_120
action_116 _ = happyFail (happyExpListPerState 116)

action_117 (58) = happyShift action_50
action_117 (81) = happyShift action_119
action_117 (114) = happyShift action_9
action_117 (115) = happyShift action_34
action_117 (6) = happyGoto action_44
action_117 (7) = happyGoto action_45
action_117 (18) = happyGoto action_46
action_117 (19) = happyGoto action_118
action_117 (20) = happyGoto action_48
action_117 (22) = happyGoto action_49
action_117 _ = happyReduce_31

action_118 _ = happyReduce_57

action_119 (58) = happyShift action_50
action_119 (114) = happyShift action_9
action_119 (115) = happyShift action_34
action_119 (6) = happyGoto action_44
action_119 (7) = happyGoto action_45
action_119 (18) = happyGoto action_46
action_119 (19) = happyGoto action_146
action_119 (20) = happyGoto action_48
action_119 (22) = happyGoto action_49
action_119 _ = happyReduce_31

action_120 (66) = happyShift action_145
action_120 _ = happyFail (happyExpListPerState 120)

action_121 (58) = happyShift action_135
action_121 (76) = happyShift action_136
action_121 (80) = happyShift action_137
action_121 (84) = happyShift action_138
action_121 (90) = happyShift action_139
action_121 (98) = happyShift action_140
action_121 (104) = happyShift action_141
action_121 (107) = happyShift action_142
action_121 (112) = happyShift action_2
action_121 (113) = happyShift action_143
action_121 (114) = happyShift action_9
action_121 (115) = happyShift action_34
action_121 (116) = happyShift action_144
action_121 (4) = happyGoto action_122
action_121 (5) = happyGoto action_123
action_121 (6) = happyGoto action_124
action_121 (7) = happyGoto action_125
action_121 (8) = happyGoto action_126
action_121 (42) = happyGoto action_127
action_121 (47) = happyGoto action_128
action_121 (50) = happyGoto action_129
action_121 (53) = happyGoto action_130
action_121 (54) = happyGoto action_131
action_121 (55) = happyGoto action_132
action_121 (56) = happyGoto action_133
action_121 (57) = happyGoto action_134
action_121 _ = happyFail (happyExpListPerState 121)

action_122 _ = happyReduce_121

action_123 _ = happyReduce_122

action_124 _ = happyReduce_94

action_125 _ = happyReduce_95

action_126 _ = happyReduce_96

action_127 _ = happyReduce_55

action_128 (49) = happyGoto action_168
action_128 _ = happyReduce_99

action_129 (79) = happyShift action_167
action_129 _ = happyReduce_120

action_130 (71) = happyShift action_166
action_130 _ = happyReduce_83

action_131 (61) = happyShift action_160
action_131 (63) = happyShift action_161
action_131 (68) = happyShift action_162
action_131 (69) = happyShift action_163
action_131 (73) = happyShift action_164
action_131 (74) = happyShift action_165
action_131 _ = happyReduce_112

action_132 (60) = happyShift action_158
action_132 (65) = happyShift action_159
action_132 _ = happyReduce_115

action_133 _ = happyReduce_118

action_134 _ = happyReduce_102

action_135 (58) = happyShift action_135
action_135 (76) = happyShift action_136
action_135 (77) = happyShift action_157
action_135 (80) = happyShift action_137
action_135 (84) = happyShift action_138
action_135 (90) = happyShift action_139
action_135 (98) = happyShift action_140
action_135 (104) = happyShift action_141
action_135 (107) = happyShift action_142
action_135 (112) = happyShift action_2
action_135 (113) = happyShift action_143
action_135 (114) = happyShift action_9
action_135 (115) = happyShift action_34
action_135 (116) = happyShift action_144
action_135 (4) = happyGoto action_122
action_135 (5) = happyGoto action_123
action_135 (6) = happyGoto action_124
action_135 (7) = happyGoto action_125
action_135 (8) = happyGoto action_126
action_135 (42) = happyGoto action_156
action_135 (47) = happyGoto action_128
action_135 (50) = happyGoto action_129
action_135 (53) = happyGoto action_130
action_135 (54) = happyGoto action_131
action_135 (55) = happyGoto action_132
action_135 (56) = happyGoto action_133
action_135 (57) = happyGoto action_134
action_135 _ = happyFail (happyExpListPerState 135)

action_136 (58) = happyShift action_135
action_136 (76) = happyShift action_136
action_136 (80) = happyShift action_137
action_136 (84) = happyShift action_138
action_136 (90) = happyShift action_139
action_136 (98) = happyShift action_140
action_136 (104) = happyShift action_141
action_136 (107) = happyShift action_142
action_136 (112) = happyShift action_2
action_136 (113) = happyShift action_143
action_136 (114) = happyShift action_9
action_136 (115) = happyShift action_34
action_136 (116) = happyShift action_144
action_136 (4) = happyGoto action_122
action_136 (5) = happyGoto action_123
action_136 (6) = happyGoto action_124
action_136 (7) = happyGoto action_125
action_136 (8) = happyGoto action_126
action_136 (42) = happyGoto action_153
action_136 (47) = happyGoto action_128
action_136 (50) = happyGoto action_129
action_136 (51) = happyGoto action_154
action_136 (52) = happyGoto action_155
action_136 (53) = happyGoto action_130
action_136 (54) = happyGoto action_131
action_136 (55) = happyGoto action_132
action_136 (56) = happyGoto action_133
action_136 (57) = happyGoto action_134
action_136 _ = happyReduce_104

action_137 _ = happyReduce_123

action_138 (58) = happyShift action_135
action_138 (76) = happyShift action_136
action_138 (80) = happyShift action_137
action_138 (84) = happyShift action_138
action_138 (90) = happyShift action_139
action_138 (98) = happyShift action_140
action_138 (104) = happyShift action_141
action_138 (107) = happyShift action_142
action_138 (110) = happyShift action_152
action_138 (112) = happyShift action_2
action_138 (113) = happyShift action_143
action_138 (114) = happyShift action_9
action_138 (115) = happyShift action_34
action_138 (116) = happyShift action_144
action_138 (4) = happyGoto action_122
action_138 (5) = happyGoto action_123
action_138 (6) = happyGoto action_124
action_138 (7) = happyGoto action_125
action_138 (8) = happyGoto action_126
action_138 (42) = happyGoto action_150
action_138 (44) = happyGoto action_151
action_138 (47) = happyGoto action_128
action_138 (50) = happyGoto action_129
action_138 (53) = happyGoto action_130
action_138 (54) = happyGoto action_131
action_138 (55) = happyGoto action_132
action_138 (56) = happyGoto action_133
action_138 (57) = happyGoto action_134
action_138 _ = happyFail (happyExpListPerState 138)

action_139 (58) = happyShift action_135
action_139 (76) = happyShift action_136
action_139 (80) = happyShift action_137
action_139 (84) = happyShift action_138
action_139 (90) = happyShift action_139
action_139 (98) = happyShift action_140
action_139 (104) = happyShift action_141
action_139 (107) = happyShift action_142
action_139 (112) = happyShift action_2
action_139 (113) = happyShift action_143
action_139 (114) = happyShift action_9
action_139 (115) = happyShift action_34
action_139 (116) = happyShift action_144
action_139 (4) = happyGoto action_122
action_139 (5) = happyGoto action_123
action_139 (6) = happyGoto action_124
action_139 (7) = happyGoto action_125
action_139 (8) = happyGoto action_126
action_139 (42) = happyGoto action_149
action_139 (47) = happyGoto action_128
action_139 (50) = happyGoto action_129
action_139 (53) = happyGoto action_130
action_139 (54) = happyGoto action_131
action_139 (55) = happyGoto action_132
action_139 (56) = happyGoto action_133
action_139 (57) = happyGoto action_134
action_139 _ = happyFail (happyExpListPerState 139)

action_140 (58) = happyShift action_135
action_140 (76) = happyShift action_136
action_140 (80) = happyShift action_137
action_140 (84) = happyShift action_138
action_140 (90) = happyShift action_139
action_140 (98) = happyShift action_140
action_140 (104) = happyShift action_141
action_140 (107) = happyShift action_142
action_140 (112) = happyShift action_2
action_140 (113) = happyShift action_143
action_140 (114) = happyShift action_9
action_140 (115) = happyShift action_34
action_140 (116) = happyShift action_144
action_140 (4) = happyGoto action_122
action_140 (5) = happyGoto action_123
action_140 (6) = happyGoto action_124
action_140 (7) = happyGoto action_125
action_140 (8) = happyGoto action_126
action_140 (42) = happyGoto action_148
action_140 (47) = happyGoto action_128
action_140 (50) = happyGoto action_129
action_140 (53) = happyGoto action_130
action_140 (54) = happyGoto action_131
action_140 (55) = happyGoto action_132
action_140 (56) = happyGoto action_133
action_140 (57) = happyGoto action_134
action_140 _ = happyFail (happyExpListPerState 140)

action_141 _ = happyReduce_93

action_142 _ = happyReduce_92

action_143 _ = happyReduce_2

action_144 _ = happyReduce_5

action_145 (58) = happyShift action_50
action_145 (114) = happyShift action_9
action_145 (115) = happyShift action_34
action_145 (6) = happyGoto action_44
action_145 (7) = happyGoto action_45
action_145 (18) = happyGoto action_46
action_145 (19) = happyGoto action_147
action_145 (20) = happyGoto action_48
action_145 (22) = happyGoto action_49
action_145 _ = happyReduce_31

action_146 _ = happyReduce_59

action_147 (59) = happyShift action_193
action_147 _ = happyFail (happyExpListPerState 147)

action_148 (109) = happyShift action_192
action_148 _ = happyFail (happyExpListPerState 148)

action_149 (106) = happyShift action_191
action_149 _ = happyFail (happyExpListPerState 149)

action_150 (82) = happyShift action_190
action_150 _ = happyFail (happyExpListPerState 150)

action_151 (94) = happyShift action_189
action_151 _ = happyFail (happyExpListPerState 151)

action_152 (58) = happyShift action_135
action_152 (76) = happyShift action_136
action_152 (80) = happyShift action_137
action_152 (84) = happyShift action_138
action_152 (90) = happyShift action_139
action_152 (98) = happyShift action_140
action_152 (104) = happyShift action_141
action_152 (107) = happyShift action_142
action_152 (112) = happyShift action_2
action_152 (113) = happyShift action_143
action_152 (114) = happyShift action_9
action_152 (115) = happyShift action_34
action_152 (116) = happyShift action_144
action_152 (4) = happyGoto action_122
action_152 (5) = happyGoto action_123
action_152 (6) = happyGoto action_124
action_152 (7) = happyGoto action_125
action_152 (8) = happyGoto action_126
action_152 (42) = happyGoto action_150
action_152 (43) = happyGoto action_187
action_152 (44) = happyGoto action_188
action_152 (47) = happyGoto action_128
action_152 (50) = happyGoto action_129
action_152 (53) = happyGoto action_130
action_152 (54) = happyGoto action_131
action_152 (55) = happyGoto action_132
action_152 (56) = happyGoto action_133
action_152 (57) = happyGoto action_134
action_152 _ = happyReduce_84

action_153 _ = happyReduce_103

action_154 (62) = happyShift action_186
action_154 _ = happyReduce_105

action_155 (78) = happyShift action_185
action_155 _ = happyFail (happyExpListPerState 155)

action_156 (59) = happyShift action_184
action_156 _ = happyFail (happyExpListPerState 156)

action_157 (16) = happyGoto action_183
action_157 _ = happyReduce_20

action_158 (58) = happyShift action_172
action_158 (80) = happyShift action_137
action_158 (104) = happyShift action_141
action_158 (107) = happyShift action_142
action_158 (112) = happyShift action_2
action_158 (113) = happyShift action_143
action_158 (114) = happyShift action_9
action_158 (115) = happyShift action_34
action_158 (116) = happyShift action_144
action_158 (4) = happyGoto action_122
action_158 (5) = happyGoto action_123
action_158 (6) = happyGoto action_124
action_158 (7) = happyGoto action_125
action_158 (8) = happyGoto action_126
action_158 (47) = happyGoto action_128
action_158 (50) = happyGoto action_129
action_158 (56) = happyGoto action_182
action_158 (57) = happyGoto action_134
action_158 _ = happyFail (happyExpListPerState 158)

action_159 (58) = happyShift action_172
action_159 (80) = happyShift action_137
action_159 (104) = happyShift action_141
action_159 (107) = happyShift action_142
action_159 (112) = happyShift action_2
action_159 (113) = happyShift action_143
action_159 (114) = happyShift action_9
action_159 (115) = happyShift action_34
action_159 (116) = happyShift action_144
action_159 (4) = happyGoto action_122
action_159 (5) = happyGoto action_123
action_159 (6) = happyGoto action_124
action_159 (7) = happyGoto action_125
action_159 (8) = happyGoto action_126
action_159 (47) = happyGoto action_128
action_159 (50) = happyGoto action_129
action_159 (56) = happyGoto action_181
action_159 (57) = happyGoto action_134
action_159 _ = happyFail (happyExpListPerState 159)

action_160 (58) = happyShift action_172
action_160 (80) = happyShift action_137
action_160 (104) = happyShift action_141
action_160 (107) = happyShift action_142
action_160 (112) = happyShift action_2
action_160 (113) = happyShift action_143
action_160 (114) = happyShift action_9
action_160 (115) = happyShift action_34
action_160 (116) = happyShift action_144
action_160 (4) = happyGoto action_122
action_160 (5) = happyGoto action_123
action_160 (6) = happyGoto action_124
action_160 (7) = happyGoto action_125
action_160 (8) = happyGoto action_126
action_160 (47) = happyGoto action_128
action_160 (50) = happyGoto action_129
action_160 (55) = happyGoto action_180
action_160 (56) = happyGoto action_133
action_160 (57) = happyGoto action_134
action_160 _ = happyFail (happyExpListPerState 160)

action_161 (58) = happyShift action_172
action_161 (80) = happyShift action_137
action_161 (104) = happyShift action_141
action_161 (107) = happyShift action_142
action_161 (112) = happyShift action_2
action_161 (113) = happyShift action_143
action_161 (114) = happyShift action_9
action_161 (115) = happyShift action_34
action_161 (116) = happyShift action_144
action_161 (4) = happyGoto action_122
action_161 (5) = happyGoto action_123
action_161 (6) = happyGoto action_124
action_161 (7) = happyGoto action_125
action_161 (8) = happyGoto action_126
action_161 (47) = happyGoto action_128
action_161 (50) = happyGoto action_129
action_161 (55) = happyGoto action_179
action_161 (56) = happyGoto action_133
action_161 (57) = happyGoto action_134
action_161 _ = happyFail (happyExpListPerState 161)

action_162 (58) = happyShift action_172
action_162 (80) = happyShift action_137
action_162 (104) = happyShift action_141
action_162 (107) = happyShift action_142
action_162 (112) = happyShift action_2
action_162 (113) = happyShift action_143
action_162 (114) = happyShift action_9
action_162 (115) = happyShift action_34
action_162 (116) = happyShift action_144
action_162 (4) = happyGoto action_122
action_162 (5) = happyGoto action_123
action_162 (6) = happyGoto action_124
action_162 (7) = happyGoto action_125
action_162 (8) = happyGoto action_126
action_162 (47) = happyGoto action_128
action_162 (50) = happyGoto action_129
action_162 (54) = happyGoto action_178
action_162 (55) = happyGoto action_132
action_162 (56) = happyGoto action_133
action_162 (57) = happyGoto action_134
action_162 _ = happyFail (happyExpListPerState 162)

action_163 (58) = happyShift action_172
action_163 (80) = happyShift action_137
action_163 (104) = happyShift action_141
action_163 (107) = happyShift action_142
action_163 (112) = happyShift action_2
action_163 (113) = happyShift action_143
action_163 (114) = happyShift action_9
action_163 (115) = happyShift action_34
action_163 (116) = happyShift action_144
action_163 (4) = happyGoto action_122
action_163 (5) = happyGoto action_123
action_163 (6) = happyGoto action_124
action_163 (7) = happyGoto action_125
action_163 (8) = happyGoto action_126
action_163 (47) = happyGoto action_128
action_163 (50) = happyGoto action_129
action_163 (54) = happyGoto action_177
action_163 (55) = happyGoto action_132
action_163 (56) = happyGoto action_133
action_163 (57) = happyGoto action_134
action_163 _ = happyFail (happyExpListPerState 163)

action_164 (58) = happyShift action_172
action_164 (80) = happyShift action_137
action_164 (104) = happyShift action_141
action_164 (107) = happyShift action_142
action_164 (112) = happyShift action_2
action_164 (113) = happyShift action_143
action_164 (114) = happyShift action_9
action_164 (115) = happyShift action_34
action_164 (116) = happyShift action_144
action_164 (4) = happyGoto action_122
action_164 (5) = happyGoto action_123
action_164 (6) = happyGoto action_124
action_164 (7) = happyGoto action_125
action_164 (8) = happyGoto action_126
action_164 (47) = happyGoto action_128
action_164 (50) = happyGoto action_129
action_164 (54) = happyGoto action_176
action_164 (55) = happyGoto action_132
action_164 (56) = happyGoto action_133
action_164 (57) = happyGoto action_134
action_164 _ = happyFail (happyExpListPerState 164)

action_165 (58) = happyShift action_172
action_165 (80) = happyShift action_137
action_165 (104) = happyShift action_141
action_165 (107) = happyShift action_142
action_165 (112) = happyShift action_2
action_165 (113) = happyShift action_143
action_165 (114) = happyShift action_9
action_165 (115) = happyShift action_34
action_165 (116) = happyShift action_144
action_165 (4) = happyGoto action_122
action_165 (5) = happyGoto action_123
action_165 (6) = happyGoto action_124
action_165 (7) = happyGoto action_125
action_165 (8) = happyGoto action_126
action_165 (47) = happyGoto action_128
action_165 (50) = happyGoto action_129
action_165 (54) = happyGoto action_175
action_165 (55) = happyGoto action_132
action_165 (56) = happyGoto action_133
action_165 (57) = happyGoto action_134
action_165 _ = happyFail (happyExpListPerState 165)

action_166 (58) = happyShift action_172
action_166 (80) = happyShift action_137
action_166 (104) = happyShift action_141
action_166 (107) = happyShift action_142
action_166 (112) = happyShift action_2
action_166 (113) = happyShift action_143
action_166 (114) = happyShift action_9
action_166 (115) = happyShift action_34
action_166 (116) = happyShift action_144
action_166 (4) = happyGoto action_122
action_166 (5) = happyGoto action_123
action_166 (6) = happyGoto action_124
action_166 (7) = happyGoto action_125
action_166 (8) = happyGoto action_126
action_166 (47) = happyGoto action_128
action_166 (50) = happyGoto action_129
action_166 (54) = happyGoto action_174
action_166 (55) = happyGoto action_132
action_166 (56) = happyGoto action_133
action_166 (57) = happyGoto action_134
action_166 _ = happyFail (happyExpListPerState 166)

action_167 (58) = happyShift action_172
action_167 (80) = happyShift action_137
action_167 (104) = happyShift action_141
action_167 (107) = happyShift action_142
action_167 (112) = happyShift action_2
action_167 (113) = happyShift action_143
action_167 (114) = happyShift action_9
action_167 (115) = happyShift action_34
action_167 (116) = happyShift action_144
action_167 (4) = happyGoto action_122
action_167 (5) = happyGoto action_123
action_167 (6) = happyGoto action_124
action_167 (7) = happyGoto action_125
action_167 (8) = happyGoto action_126
action_167 (47) = happyGoto action_128
action_167 (50) = happyGoto action_129
action_167 (56) = happyGoto action_173
action_167 (57) = happyGoto action_134
action_167 _ = happyFail (happyExpListPerState 167)

action_168 (58) = happyShift action_172
action_168 (80) = happyShift action_137
action_168 (104) = happyShift action_141
action_168 (107) = happyShift action_142
action_168 (112) = happyShift action_2
action_168 (113) = happyShift action_143
action_168 (114) = happyShift action_9
action_168 (115) = happyShift action_34
action_168 (116) = happyShift action_144
action_168 (4) = happyGoto action_122
action_168 (5) = happyGoto action_123
action_168 (6) = happyGoto action_124
action_168 (7) = happyGoto action_125
action_168 (8) = happyGoto action_126
action_168 (47) = happyGoto action_169
action_168 (48) = happyGoto action_170
action_168 (57) = happyGoto action_171
action_168 _ = happyReduce_101

action_169 _ = happyReduce_98

action_170 _ = happyReduce_100

action_171 _ = happyReduce_97

action_172 (58) = happyShift action_135
action_172 (76) = happyShift action_136
action_172 (80) = happyShift action_137
action_172 (84) = happyShift action_138
action_172 (90) = happyShift action_139
action_172 (98) = happyShift action_140
action_172 (104) = happyShift action_141
action_172 (107) = happyShift action_142
action_172 (112) = happyShift action_2
action_172 (113) = happyShift action_143
action_172 (114) = happyShift action_9
action_172 (115) = happyShift action_34
action_172 (116) = happyShift action_144
action_172 (4) = happyGoto action_122
action_172 (5) = happyGoto action_123
action_172 (6) = happyGoto action_124
action_172 (7) = happyGoto action_125
action_172 (8) = happyGoto action_126
action_172 (42) = happyGoto action_156
action_172 (47) = happyGoto action_128
action_172 (50) = happyGoto action_129
action_172 (53) = happyGoto action_130
action_172 (54) = happyGoto action_131
action_172 (55) = happyGoto action_132
action_172 (56) = happyGoto action_133
action_172 (57) = happyGoto action_134
action_172 _ = happyFail (happyExpListPerState 172)

action_173 _ = happyReduce_119

action_174 (61) = happyShift action_160
action_174 (63) = happyShift action_161
action_174 _ = happyReduce_107

action_175 (61) = happyShift action_160
action_175 (63) = happyShift action_161
action_175 _ = happyReduce_111

action_176 (61) = happyShift action_160
action_176 (63) = happyShift action_161
action_176 _ = happyReduce_109

action_177 (61) = happyShift action_160
action_177 (63) = happyShift action_161
action_177 _ = happyReduce_110

action_178 (61) = happyShift action_160
action_178 (63) = happyShift action_161
action_178 _ = happyReduce_108

action_179 (60) = happyShift action_158
action_179 (65) = happyShift action_159
action_179 _ = happyReduce_114

action_180 (60) = happyShift action_158
action_180 (65) = happyShift action_159
action_180 _ = happyReduce_113

action_181 _ = happyReduce_117

action_182 _ = happyReduce_116

action_183 (58) = happyShift action_116
action_183 (66) = happyShift action_201
action_183 (115) = happyShift action_34
action_183 (7) = happyGoto action_112
action_183 (17) = happyGoto action_113
action_183 _ = happyFail (happyExpListPerState 183)

action_184 _ = happyReduce_124

action_185 _ = happyReduce_82

action_186 (58) = happyShift action_135
action_186 (76) = happyShift action_136
action_186 (80) = happyShift action_137
action_186 (84) = happyShift action_138
action_186 (90) = happyShift action_139
action_186 (98) = happyShift action_140
action_186 (104) = happyShift action_141
action_186 (107) = happyShift action_142
action_186 (112) = happyShift action_2
action_186 (113) = happyShift action_143
action_186 (114) = happyShift action_9
action_186 (115) = happyShift action_34
action_186 (116) = happyShift action_144
action_186 (4) = happyGoto action_122
action_186 (5) = happyGoto action_123
action_186 (6) = happyGoto action_124
action_186 (7) = happyGoto action_125
action_186 (8) = happyGoto action_126
action_186 (42) = happyGoto action_153
action_186 (47) = happyGoto action_128
action_186 (50) = happyGoto action_129
action_186 (51) = happyGoto action_154
action_186 (52) = happyGoto action_200
action_186 (53) = happyGoto action_130
action_186 (54) = happyGoto action_131
action_186 (55) = happyGoto action_132
action_186 (56) = happyGoto action_133
action_186 (57) = happyGoto action_134
action_186 _ = happyReduce_104

action_187 (111) = happyShift action_199
action_187 _ = happyFail (happyExpListPerState 187)

action_188 (67) = happyShift action_198
action_188 _ = happyReduce_85

action_189 (58) = happyShift action_135
action_189 (76) = happyShift action_136
action_189 (80) = happyShift action_137
action_189 (84) = happyShift action_138
action_189 (90) = happyShift action_139
action_189 (98) = happyShift action_140
action_189 (104) = happyShift action_141
action_189 (107) = happyShift action_142
action_189 (112) = happyShift action_2
action_189 (113) = happyShift action_143
action_189 (114) = happyShift action_9
action_189 (115) = happyShift action_34
action_189 (116) = happyShift action_144
action_189 (4) = happyGoto action_122
action_189 (5) = happyGoto action_123
action_189 (6) = happyGoto action_124
action_189 (7) = happyGoto action_125
action_189 (8) = happyGoto action_126
action_189 (42) = happyGoto action_197
action_189 (47) = happyGoto action_128
action_189 (50) = happyGoto action_129
action_189 (53) = happyGoto action_130
action_189 (54) = happyGoto action_131
action_189 (55) = happyGoto action_132
action_189 (56) = happyGoto action_133
action_189 (57) = happyGoto action_134
action_189 _ = happyFail (happyExpListPerState 189)

action_190 (115) = happyShift action_34
action_190 (7) = happyGoto action_196
action_190 _ = happyFail (happyExpListPerState 190)

action_191 (58) = happyShift action_135
action_191 (76) = happyShift action_136
action_191 (80) = happyShift action_137
action_191 (84) = happyShift action_138
action_191 (90) = happyShift action_139
action_191 (98) = happyShift action_140
action_191 (104) = happyShift action_141
action_191 (107) = happyShift action_142
action_191 (112) = happyShift action_2
action_191 (113) = happyShift action_143
action_191 (114) = happyShift action_9
action_191 (115) = happyShift action_34
action_191 (116) = happyShift action_144
action_191 (4) = happyGoto action_122
action_191 (5) = happyGoto action_123
action_191 (6) = happyGoto action_124
action_191 (7) = happyGoto action_125
action_191 (8) = happyGoto action_126
action_191 (42) = happyGoto action_195
action_191 (47) = happyGoto action_128
action_191 (50) = happyGoto action_129
action_191 (53) = happyGoto action_130
action_191 (54) = happyGoto action_131
action_191 (55) = happyGoto action_132
action_191 (56) = happyGoto action_133
action_191 (57) = happyGoto action_134
action_191 _ = happyFail (happyExpListPerState 191)

action_192 (110) = happyShift action_194
action_192 _ = happyFail (happyExpListPerState 192)

action_193 _ = happyReduce_22

action_194 (58) = happyShift action_135
action_194 (76) = happyShift action_136
action_194 (80) = happyShift action_137
action_194 (84) = happyShift action_138
action_194 (90) = happyShift action_139
action_194 (98) = happyShift action_140
action_194 (104) = happyShift action_141
action_194 (107) = happyShift action_142
action_194 (112) = happyShift action_2
action_194 (113) = happyShift action_143
action_194 (114) = happyShift action_9
action_194 (115) = happyShift action_34
action_194 (116) = happyShift action_144
action_194 (4) = happyGoto action_122
action_194 (5) = happyGoto action_123
action_194 (6) = happyGoto action_124
action_194 (7) = happyGoto action_125
action_194 (8) = happyGoto action_126
action_194 (42) = happyGoto action_206
action_194 (45) = happyGoto action_207
action_194 (46) = happyGoto action_208
action_194 (47) = happyGoto action_128
action_194 (50) = happyGoto action_129
action_194 (53) = happyGoto action_130
action_194 (54) = happyGoto action_131
action_194 (55) = happyGoto action_132
action_194 (56) = happyGoto action_133
action_194 (57) = happyGoto action_134
action_194 _ = happyReduce_88

action_195 (86) = happyShift action_205
action_195 _ = happyFail (happyExpListPerState 195)

action_196 _ = happyReduce_87

action_197 _ = happyReduce_78

action_198 (58) = happyShift action_135
action_198 (76) = happyShift action_136
action_198 (80) = happyShift action_137
action_198 (84) = happyShift action_138
action_198 (90) = happyShift action_139
action_198 (98) = happyShift action_140
action_198 (104) = happyShift action_141
action_198 (107) = happyShift action_142
action_198 (112) = happyShift action_2
action_198 (113) = happyShift action_143
action_198 (114) = happyShift action_9
action_198 (115) = happyShift action_34
action_198 (116) = happyShift action_144
action_198 (4) = happyGoto action_122
action_198 (5) = happyGoto action_123
action_198 (6) = happyGoto action_124
action_198 (7) = happyGoto action_125
action_198 (8) = happyGoto action_126
action_198 (42) = happyGoto action_150
action_198 (43) = happyGoto action_204
action_198 (44) = happyGoto action_188
action_198 (47) = happyGoto action_128
action_198 (50) = happyGoto action_129
action_198 (53) = happyGoto action_130
action_198 (54) = happyGoto action_131
action_198 (55) = happyGoto action_132
action_198 (56) = happyGoto action_133
action_198 (57) = happyGoto action_134
action_198 _ = happyReduce_84

action_199 (94) = happyShift action_203
action_199 _ = happyFail (happyExpListPerState 199)

action_200 _ = happyReduce_106

action_201 (58) = happyShift action_50
action_201 (114) = happyShift action_9
action_201 (115) = happyShift action_34
action_201 (6) = happyGoto action_44
action_201 (7) = happyGoto action_45
action_201 (18) = happyGoto action_46
action_201 (19) = happyGoto action_202
action_201 (20) = happyGoto action_48
action_201 (22) = happyGoto action_49
action_201 _ = happyReduce_31

action_202 (72) = happyShift action_214
action_202 _ = happyFail (happyExpListPerState 202)

action_203 (58) = happyShift action_135
action_203 (76) = happyShift action_136
action_203 (80) = happyShift action_137
action_203 (84) = happyShift action_138
action_203 (90) = happyShift action_139
action_203 (98) = happyShift action_140
action_203 (104) = happyShift action_141
action_203 (107) = happyShift action_142
action_203 (112) = happyShift action_2
action_203 (113) = happyShift action_143
action_203 (114) = happyShift action_9
action_203 (115) = happyShift action_34
action_203 (116) = happyShift action_144
action_203 (4) = happyGoto action_122
action_203 (5) = happyGoto action_123
action_203 (6) = happyGoto action_124
action_203 (7) = happyGoto action_125
action_203 (8) = happyGoto action_126
action_203 (42) = happyGoto action_213
action_203 (47) = happyGoto action_128
action_203 (50) = happyGoto action_129
action_203 (53) = happyGoto action_130
action_203 (54) = happyGoto action_131
action_203 (55) = happyGoto action_132
action_203 (56) = happyGoto action_133
action_203 (57) = happyGoto action_134
action_203 _ = happyFail (happyExpListPerState 203)

action_204 _ = happyReduce_86

action_205 (58) = happyShift action_135
action_205 (76) = happyShift action_136
action_205 (80) = happyShift action_137
action_205 (84) = happyShift action_138
action_205 (90) = happyShift action_139
action_205 (98) = happyShift action_140
action_205 (104) = happyShift action_141
action_205 (107) = happyShift action_142
action_205 (112) = happyShift action_2
action_205 (113) = happyShift action_143
action_205 (114) = happyShift action_9
action_205 (115) = happyShift action_34
action_205 (116) = happyShift action_144
action_205 (4) = happyGoto action_122
action_205 (5) = happyGoto action_123
action_205 (6) = happyGoto action_124
action_205 (7) = happyGoto action_125
action_205 (8) = happyGoto action_126
action_205 (42) = happyGoto action_212
action_205 (47) = happyGoto action_128
action_205 (50) = happyGoto action_129
action_205 (53) = happyGoto action_130
action_205 (54) = happyGoto action_131
action_205 (55) = happyGoto action_132
action_205 (56) = happyGoto action_133
action_205 (57) = happyGoto action_134
action_205 _ = happyFail (happyExpListPerState 205)

action_206 (64) = happyShift action_211
action_206 _ = happyFail (happyExpListPerState 206)

action_207 (111) = happyShift action_210
action_207 _ = happyFail (happyExpListPerState 207)

action_208 (67) = happyShift action_209
action_208 _ = happyReduce_89

action_209 (58) = happyShift action_135
action_209 (76) = happyShift action_136
action_209 (80) = happyShift action_137
action_209 (84) = happyShift action_138
action_209 (90) = happyShift action_139
action_209 (98) = happyShift action_140
action_209 (104) = happyShift action_141
action_209 (107) = happyShift action_142
action_209 (112) = happyShift action_2
action_209 (113) = happyShift action_143
action_209 (114) = happyShift action_9
action_209 (115) = happyShift action_34
action_209 (116) = happyShift action_144
action_209 (4) = happyGoto action_122
action_209 (5) = happyGoto action_123
action_209 (6) = happyGoto action_124
action_209 (7) = happyGoto action_125
action_209 (8) = happyGoto action_126
action_209 (42) = happyGoto action_206
action_209 (45) = happyGoto action_217
action_209 (46) = happyGoto action_208
action_209 (47) = happyGoto action_128
action_209 (50) = happyGoto action_129
action_209 (53) = happyGoto action_130
action_209 (54) = happyGoto action_131
action_209 (55) = happyGoto action_132
action_209 (56) = happyGoto action_133
action_209 (57) = happyGoto action_134
action_209 _ = happyReduce_88

action_210 _ = happyReduce_79

action_211 (58) = happyShift action_135
action_211 (76) = happyShift action_136
action_211 (80) = happyShift action_137
action_211 (84) = happyShift action_138
action_211 (90) = happyShift action_139
action_211 (98) = happyShift action_140
action_211 (104) = happyShift action_141
action_211 (107) = happyShift action_142
action_211 (112) = happyShift action_2
action_211 (113) = happyShift action_143
action_211 (114) = happyShift action_9
action_211 (115) = happyShift action_34
action_211 (116) = happyShift action_144
action_211 (4) = happyGoto action_122
action_211 (5) = happyGoto action_123
action_211 (6) = happyGoto action_124
action_211 (7) = happyGoto action_125
action_211 (8) = happyGoto action_126
action_211 (42) = happyGoto action_216
action_211 (47) = happyGoto action_128
action_211 (50) = happyGoto action_129
action_211 (53) = happyGoto action_130
action_211 (54) = happyGoto action_131
action_211 (55) = happyGoto action_132
action_211 (56) = happyGoto action_133
action_211 (57) = happyGoto action_134
action_211 _ = happyFail (happyExpListPerState 211)

action_212 _ = happyReduce_80

action_213 _ = happyReduce_77

action_214 (58) = happyShift action_135
action_214 (76) = happyShift action_136
action_214 (80) = happyShift action_137
action_214 (84) = happyShift action_138
action_214 (90) = happyShift action_139
action_214 (98) = happyShift action_140
action_214 (104) = happyShift action_141
action_214 (107) = happyShift action_142
action_214 (112) = happyShift action_2
action_214 (113) = happyShift action_143
action_214 (114) = happyShift action_9
action_214 (115) = happyShift action_34
action_214 (116) = happyShift action_144
action_214 (4) = happyGoto action_122
action_214 (5) = happyGoto action_123
action_214 (6) = happyGoto action_124
action_214 (7) = happyGoto action_125
action_214 (8) = happyGoto action_126
action_214 (42) = happyGoto action_215
action_214 (47) = happyGoto action_128
action_214 (50) = happyGoto action_129
action_214 (53) = happyGoto action_130
action_214 (54) = happyGoto action_131
action_214 (55) = happyGoto action_132
action_214 (56) = happyGoto action_133
action_214 (57) = happyGoto action_134
action_214 _ = happyFail (happyExpListPerState 214)

action_215 (59) = happyShift action_218
action_215 _ = happyFail (happyExpListPerState 215)

action_216 _ = happyReduce_91

action_217 _ = happyReduce_90

action_218 _ = happyReduce_81

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
happyReduction_8 (HappyAbsSyn25  happy_var_2)
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

happyReduce_14 = happySpecReduce_1  13 happyReduction_14
happyReduction_14 _
	 =  HappyAbsSyn13
		 (AbsVarg.WildcardTypeParam
	)

happyReduce_15 = happySpecReduce_0  14 happyReduction_15
happyReduction_15  =  HappyAbsSyn14
		 ([]
	)

happyReduce_16 = happySpecReduce_2  14 happyReduction_16
happyReduction_16 (HappyAbsSyn15  happy_var_2)
	(HappyAbsSyn14  happy_var_1)
	 =  HappyAbsSyn14
		 (flip (:) happy_var_1 happy_var_2
	)
happyReduction_16 _ _  = notHappyAtAll 

happyReduce_17 = happySpecReduce_1  15 happyReduction_17
happyReduction_17 (HappyAbsSyn13  happy_var_1)
	 =  HappyAbsSyn15
		 (AbsVarg.UnconstrainedTypeParam happy_var_1
	)
happyReduction_17 _  = notHappyAtAll 

happyReduce_18 = happyReduce 5 15 happyReduction_18
happyReduction_18 (_ `HappyStk`
	(HappyAbsSyn21  happy_var_4) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn13  happy_var_2) `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn15
		 (AbsVarg.SuperConstrainedTypeParam happy_var_2 happy_var_4
	) `HappyStk` happyRest

happyReduce_19 = happyReduce 5 15 happyReduction_19
happyReduction_19 (_ `HappyStk`
	(HappyAbsSyn21  happy_var_4) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn13  happy_var_2) `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn15
		 (AbsVarg.DerivingConstrainedTypeParam happy_var_2 happy_var_4
	) `HappyStk` happyRest

happyReduce_20 = happySpecReduce_0  16 happyReduction_20
happyReduction_20  =  HappyAbsSyn16
		 ([]
	)

happyReduce_21 = happySpecReduce_2  16 happyReduction_21
happyReduction_21 (HappyAbsSyn17  happy_var_2)
	(HappyAbsSyn16  happy_var_1)
	 =  HappyAbsSyn16
		 (flip (:) happy_var_1 happy_var_2
	)
happyReduction_21 _ _  = notHappyAtAll 

happyReduce_22 = happyReduce 5 17 happyReduction_22
happyReduction_22 (_ `HappyStk`
	(HappyAbsSyn19  happy_var_4) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn7  happy_var_2) `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn17
		 (AbsVarg.ArgumentDefinition happy_var_2 happy_var_4
	) `HappyStk` happyRest

happyReduce_23 = happySpecReduce_1  17 happyReduction_23
happyReduction_23 (HappyAbsSyn7  happy_var_1)
	 =  HappyAbsSyn17
		 (AbsVarg.InferredArgumentDef happy_var_1
	)
happyReduction_23 _  = notHappyAtAll 

happyReduce_24 = happySpecReduce_2  18 happyReduction_24
happyReduction_24 (HappyAbsSyn14  happy_var_2)
	(HappyAbsSyn6  happy_var_1)
	 =  HappyAbsSyn18
		 (AbsVarg.ConcreteType happy_var_1 (reverse happy_var_2)
	)
happyReduction_24 _ _  = notHappyAtAll 

happyReduce_25 = happySpecReduce_2  18 happyReduction_25
happyReduction_25 (HappyAbsSyn14  happy_var_2)
	(HappyAbsSyn7  happy_var_1)
	 =  HappyAbsSyn18
		 (AbsVarg.TemplateType happy_var_1 (reverse happy_var_2)
	)
happyReduction_25 _ _  = notHappyAtAll 

happyReduce_26 = happySpecReduce_1  19 happyReduction_26
happyReduction_26 (HappyAbsSyn22  happy_var_1)
	 =  HappyAbsSyn19
		 (AbsVarg.Type happy_var_1
	)
happyReduction_26 _  = notHappyAtAll 

happyReduce_27 = happySpecReduce_1  19 happyReduction_27
happyReduction_27 (HappyAbsSyn19  happy_var_1)
	 =  HappyAbsSyn19
		 (happy_var_1
	)
happyReduction_27 _  = notHappyAtAll 

happyReduce_28 = happySpecReduce_3  20 happyReduction_28
happyReduction_28 _
	(HappyAbsSyn19  happy_var_2)
	_
	 =  HappyAbsSyn19
		 (happy_var_2
	)
happyReduction_28 _ _ _  = notHappyAtAll 

happyReduce_29 = happySpecReduce_1  21 happyReduction_29
happyReduction_29 (HappyAbsSyn19  happy_var_1)
	 =  HappyAbsSyn21
		 ((:[]) happy_var_1
	)
happyReduction_29 _  = notHappyAtAll 

happyReduce_30 = happySpecReduce_3  21 happyReduction_30
happyReduction_30 (HappyAbsSyn21  happy_var_3)
	_
	(HappyAbsSyn19  happy_var_1)
	 =  HappyAbsSyn21
		 ((:) happy_var_1 happy_var_3
	)
happyReduction_30 _ _ _  = notHappyAtAll 

happyReduce_31 = happySpecReduce_0  22 happyReduction_31
happyReduction_31  =  HappyAbsSyn22
		 ([]
	)

happyReduce_32 = happySpecReduce_1  22 happyReduction_32
happyReduction_32 (HappyAbsSyn18  happy_var_1)
	 =  HappyAbsSyn22
		 ((:[]) happy_var_1
	)
happyReduction_32 _  = notHappyAtAll 

happyReduce_33 = happySpecReduce_3  22 happyReduction_33
happyReduction_33 (HappyAbsSyn22  happy_var_3)
	_
	(HappyAbsSyn18  happy_var_1)
	 =  HappyAbsSyn22
		 ((:) happy_var_1 happy_var_3
	)
happyReduction_33 _ _ _  = notHappyAtAll 

happyReduce_34 = happySpecReduce_2  23 happyReduction_34
happyReduction_34 (HappyAbsSyn19  happy_var_2)
	(HappyAbsSyn6  happy_var_1)
	 =  HappyAbsSyn23
		 (AbsVarg.Class happy_var_1 happy_var_2
	)
happyReduction_34 _ _  = notHappyAtAll 

happyReduce_35 = happySpecReduce_1  24 happyReduction_35
happyReduction_35 (HappyAbsSyn23  happy_var_1)
	 =  HappyAbsSyn24
		 ((:[]) happy_var_1
	)
happyReduction_35 _  = notHappyAtAll 

happyReduce_36 = happySpecReduce_3  24 happyReduction_36
happyReduction_36 (HappyAbsSyn24  happy_var_3)
	_
	(HappyAbsSyn23  happy_var_1)
	 =  HappyAbsSyn24
		 ((:) happy_var_1 happy_var_3
	)
happyReduction_36 _ _ _  = notHappyAtAll 

happyReduce_37 = happyReduce 7 25 happyReduction_37
happyReduction_37 (_ `HappyStk`
	(HappyAbsSyn40  happy_var_6) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn6  happy_var_3) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn28  happy_var_1) `HappyStk`
	happyRest)
	 = HappyAbsSyn25
		 (AbsVarg.StructDefinition (reverse happy_var_1) happy_var_3 happy_var_6
	) `HappyStk` happyRest

happyReduce_38 = happyReduce 9 25 happyReduction_38
happyReduction_38 (_ `HappyStk`
	(HappyAbsSyn30  happy_var_8) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn27  happy_var_5) `HappyStk`
	(HappyAbsSyn26  happy_var_4) `HappyStk`
	(HappyAbsSyn6  happy_var_3) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn28  happy_var_1) `HappyStk`
	happyRest)
	 = HappyAbsSyn25
		 (AbsVarg.ClassDefinition (reverse happy_var_1) happy_var_3 happy_var_4 happy_var_5 happy_var_8
	) `HappyStk` happyRest

happyReduce_39 = happyReduce 10 25 happyReduction_39
happyReduction_39 (_ `HappyStk`
	(HappyAbsSyn30  happy_var_9) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn27  happy_var_6) `HappyStk`
	(HappyAbsSyn26  happy_var_5) `HappyStk`
	(HappyAbsSyn14  happy_var_4) `HappyStk`
	(HappyAbsSyn6  happy_var_3) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn28  happy_var_1) `HappyStk`
	happyRest)
	 = HappyAbsSyn25
		 (AbsVarg.TemplateDefinition (reverse happy_var_1) happy_var_3 (reverse happy_var_4) happy_var_5 happy_var_6 happy_var_9
	) `HappyStk` happyRest

happyReduce_40 = happySpecReduce_2  26 happyReduction_40
happyReduction_40 (HappyAbsSyn24  happy_var_2)
	_
	 =  HappyAbsSyn26
		 (AbsVarg.Implementing happy_var_2
	)
happyReduction_40 _ _  = notHappyAtAll 

happyReduce_41 = happySpecReduce_0  26 happyReduction_41
happyReduction_41  =  HappyAbsSyn26
		 (AbsVarg.NotImplementing
	)

happyReduce_42 = happySpecReduce_2  27 happyReduction_42
happyReduction_42 (HappyAbsSyn23  happy_var_2)
	_
	 =  HappyAbsSyn27
		 (AbsVarg.Deriving happy_var_2
	)
happyReduction_42 _ _  = notHappyAtAll 

happyReduce_43 = happySpecReduce_0  27 happyReduction_43
happyReduction_43  =  HappyAbsSyn27
		 (AbsVarg.NotDeriving
	)

happyReduce_44 = happySpecReduce_0  28 happyReduction_44
happyReduction_44  =  HappyAbsSyn28
		 ([]
	)

happyReduce_45 = happySpecReduce_2  28 happyReduction_45
happyReduction_45 (HappyAbsSyn29  happy_var_2)
	(HappyAbsSyn28  happy_var_1)
	 =  HappyAbsSyn28
		 (flip (:) happy_var_1 happy_var_2
	)
happyReduction_45 _ _  = notHappyAtAll 

happyReduce_46 = happySpecReduce_1  29 happyReduction_46
happyReduction_46 _
	 =  HappyAbsSyn29
		 (AbsVarg.ClassModifier_module
	)

happyReduce_47 = happySpecReduce_1  29 happyReduction_47
happyReduction_47 _
	 =  HappyAbsSyn29
		 (AbsVarg.ClassModifier_interface
	)

happyReduce_48 = happySpecReduce_1  29 happyReduction_48
happyReduction_48 _
	 =  HappyAbsSyn29
		 (AbsVarg.ClassModifier_sealed
	)

happyReduce_49 = happySpecReduce_2  30 happyReduction_49
happyReduction_49 (HappyAbsSyn36  happy_var_2)
	(HappyAbsSyn32  happy_var_1)
	 =  HappyAbsSyn30
		 (AbsVarg.ClassContent happy_var_1 happy_var_2
	)
happyReduction_49 _ _  = notHappyAtAll 

happyReduce_50 = happySpecReduce_1  31 happyReduction_50
happyReduction_50 (HappyAbsSyn6  happy_var_1)
	 =  HappyAbsSyn31
		 (AbsVarg.EmptyMemberDefinition happy_var_1
	)
happyReduction_50 _  = notHappyAtAll 

happyReduce_51 = happyReduce 5 31 happyReduction_51
happyReduction_51 (_ `HappyStk`
	(HappyAbsSyn40  happy_var_4) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn6  happy_var_1) `HappyStk`
	happyRest)
	 = HappyAbsSyn31
		 (AbsVarg.MemberDefinition happy_var_1 happy_var_4
	) `HappyStk` happyRest

happyReduce_52 = happySpecReduce_0  32 happyReduction_52
happyReduction_52  =  HappyAbsSyn32
		 ([]
	)

happyReduce_53 = happySpecReduce_1  32 happyReduction_53
happyReduction_53 (HappyAbsSyn31  happy_var_1)
	 =  HappyAbsSyn32
		 ((:[]) happy_var_1
	)
happyReduction_53 _  = notHappyAtAll 

happyReduce_54 = happySpecReduce_3  32 happyReduction_54
happyReduction_54 (HappyAbsSyn32  happy_var_3)
	_
	(HappyAbsSyn31  happy_var_1)
	 =  HappyAbsSyn32
		 ((:) happy_var_1 happy_var_3
	)
happyReduction_54 _ _ _  = notHappyAtAll 

happyReduce_55 = happyReduce 7 33 happyReduction_55
happyReduction_55 ((HappyAbsSyn42  happy_var_7) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn34  happy_var_5) `HappyStk`
	(HappyAbsSyn16  happy_var_4) `HappyStk`
	(HappyAbsSyn7  happy_var_3) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn37  happy_var_1) `HappyStk`
	happyRest)
	 = HappyAbsSyn33
		 (AbsVarg.MemberFunctionDefinition (reverse happy_var_1) happy_var_3 (reverse happy_var_4) happy_var_5 happy_var_7
	) `HappyStk` happyRest

happyReduce_56 = happyReduce 5 33 happyReduction_56
happyReduction_56 ((HappyAbsSyn35  happy_var_5) `HappyStk`
	(HappyAbsSyn16  happy_var_4) `HappyStk`
	(HappyAbsSyn7  happy_var_3) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn37  happy_var_1) `HappyStk`
	happyRest)
	 = HappyAbsSyn33
		 (AbsVarg.AbstractFunctionDefinition (reverse happy_var_1) happy_var_3 (reverse happy_var_4) happy_var_5
	) `HappyStk` happyRest

happyReduce_57 = happySpecReduce_2  34 happyReduction_57
happyReduction_57 (HappyAbsSyn19  happy_var_2)
	_
	 =  HappyAbsSyn34
		 (AbsVarg.ReturnType happy_var_2
	)
happyReduction_57 _ _  = notHappyAtAll 

happyReduce_58 = happySpecReduce_0  34 happyReduction_58
happyReduction_58  =  HappyAbsSyn34
		 (AbsVarg.InferredReturnType
	)

happyReduce_59 = happySpecReduce_3  35 happyReduction_59
happyReduction_59 (HappyAbsSyn19  happy_var_3)
	_
	_
	 =  HappyAbsSyn35
		 (AbsVarg.AbsReturnType happy_var_3
	)
happyReduction_59 _ _ _  = notHappyAtAll 

happyReduce_60 = happySpecReduce_0  35 happyReduction_60
happyReduction_60  =  HappyAbsSyn35
		 (AbsVarg.AbsInferredReturnType
	)

happyReduce_61 = happySpecReduce_0  36 happyReduction_61
happyReduction_61  =  HappyAbsSyn36
		 ([]
	)

happyReduce_62 = happySpecReduce_1  36 happyReduction_62
happyReduction_62 (HappyAbsSyn33  happy_var_1)
	 =  HappyAbsSyn36
		 ((:[]) happy_var_1
	)
happyReduction_62 _  = notHappyAtAll 

happyReduce_63 = happySpecReduce_3  36 happyReduction_63
happyReduction_63 (HappyAbsSyn36  happy_var_3)
	_
	(HappyAbsSyn33  happy_var_1)
	 =  HappyAbsSyn36
		 ((:) happy_var_1 happy_var_3
	)
happyReduction_63 _ _ _  = notHappyAtAll 

happyReduce_64 = happySpecReduce_0  37 happyReduction_64
happyReduction_64  =  HappyAbsSyn37
		 ([]
	)

happyReduce_65 = happySpecReduce_2  37 happyReduction_65
happyReduction_65 (HappyAbsSyn38  happy_var_2)
	(HappyAbsSyn37  happy_var_1)
	 =  HappyAbsSyn37
		 (flip (:) happy_var_1 happy_var_2
	)
happyReduction_65 _ _  = notHappyAtAll 

happyReduce_66 = happySpecReduce_1  38 happyReduction_66
happyReduction_66 _
	 =  HappyAbsSyn38
		 (AbsVarg.FunctionModifier_static
	)

happyReduce_67 = happySpecReduce_1  38 happyReduction_67
happyReduction_67 _
	 =  HappyAbsSyn38
		 (AbsVarg.FunctionModifier_internal
	)

happyReduce_68 = happySpecReduce_1  38 happyReduction_68
happyReduction_68 _
	 =  HappyAbsSyn38
		 (AbsVarg.FunctionModifier_implement
	)

happyReduce_69 = happySpecReduce_1  38 happyReduction_69
happyReduction_69 _
	 =  HappyAbsSyn38
		 (AbsVarg.FunctionModifier1
	)

happyReduce_70 = happyReduce 4 39 happyReduction_70
happyReduction_70 ((HappyAbsSyn19  happy_var_4) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn7  happy_var_2) `HappyStk`
	(HappyAbsSyn41  happy_var_1) `HappyStk`
	happyRest)
	 = HappyAbsSyn39
		 (AbsVarg.ModifiedClassField happy_var_1 happy_var_2 happy_var_4
	) `HappyStk` happyRest

happyReduce_71 = happySpecReduce_3  39 happyReduction_71
happyReduction_71 (HappyAbsSyn19  happy_var_3)
	_
	(HappyAbsSyn7  happy_var_1)
	 =  HappyAbsSyn39
		 (AbsVarg.NormalClassField happy_var_1 happy_var_3
	)
happyReduction_71 _ _ _  = notHappyAtAll 

happyReduce_72 = happySpecReduce_0  40 happyReduction_72
happyReduction_72  =  HappyAbsSyn40
		 ([]
	)

happyReduce_73 = happySpecReduce_1  40 happyReduction_73
happyReduction_73 (HappyAbsSyn39  happy_var_1)
	 =  HappyAbsSyn40
		 ((:[]) happy_var_1
	)
happyReduction_73 _  = notHappyAtAll 

happyReduce_74 = happySpecReduce_3  40 happyReduction_74
happyReduction_74 (HappyAbsSyn40  happy_var_3)
	_
	(HappyAbsSyn39  happy_var_1)
	 =  HappyAbsSyn40
		 ((:) happy_var_1 happy_var_3
	)
happyReduction_74 _ _ _  = notHappyAtAll 

happyReduce_75 = happySpecReduce_1  41 happyReduction_75
happyReduction_75 _
	 =  HappyAbsSyn41
		 (AbsVarg.FieldModifier_public
	)

happyReduce_76 = happySpecReduce_1  41 happyReduction_76
happyReduction_76 _
	 =  HappyAbsSyn41
		 (AbsVarg.FieldModifier1
	)

happyReduce_77 = happyReduce 6 42 happyReduction_77
happyReduction_77 ((HappyAbsSyn42  happy_var_6) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn43  happy_var_3) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn42
		 (AbsVarg.EDefinitionsList happy_var_3 happy_var_6
	) `HappyStk` happyRest

happyReduce_78 = happyReduce 4 42 happyReduction_78
happyReduction_78 ((HappyAbsSyn42  happy_var_4) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn44  happy_var_2) `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn42
		 (AbsVarg.EDefinition happy_var_2 happy_var_4
	) `HappyStk` happyRest

happyReduce_79 = happyReduce 6 42 happyReduction_79
happyReduction_79 (_ `HappyStk`
	(HappyAbsSyn45  happy_var_5) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn42  happy_var_2) `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn42
		 (AbsVarg.EMatch happy_var_2 happy_var_5
	) `HappyStk` happyRest

happyReduce_80 = happyReduce 6 42 happyReduction_80
happyReduction_80 ((HappyAbsSyn42  happy_var_6) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn42  happy_var_4) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn42  happy_var_2) `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn42
		 (AbsVarg.EIfThenElse happy_var_2 happy_var_4 happy_var_6
	) `HappyStk` happyRest

happyReduce_81 = happyReduce 8 42 happyReduction_81
happyReduction_81 (_ `HappyStk`
	(HappyAbsSyn42  happy_var_7) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn19  happy_var_5) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn16  happy_var_3) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn42
		 (AbsVarg.ELambda (reverse happy_var_3) happy_var_5 happy_var_7
	) `HappyStk` happyRest

happyReduce_82 = happySpecReduce_3  42 happyReduction_82
happyReduction_82 _
	(HappyAbsSyn52  happy_var_2)
	_
	 =  HappyAbsSyn42
		 (AbsVarg.EList happy_var_2
	)
happyReduction_82 _ _ _  = notHappyAtAll 

happyReduce_83 = happySpecReduce_1  42 happyReduction_83
happyReduction_83 (HappyAbsSyn42  happy_var_1)
	 =  HappyAbsSyn42
		 (happy_var_1
	)
happyReduction_83 _  = notHappyAtAll 

happyReduce_84 = happySpecReduce_0  43 happyReduction_84
happyReduction_84  =  HappyAbsSyn43
		 ([]
	)

happyReduce_85 = happySpecReduce_1  43 happyReduction_85
happyReduction_85 (HappyAbsSyn44  happy_var_1)
	 =  HappyAbsSyn43
		 ((:[]) happy_var_1
	)
happyReduction_85 _  = notHappyAtAll 

happyReduce_86 = happySpecReduce_3  43 happyReduction_86
happyReduction_86 (HappyAbsSyn43  happy_var_3)
	_
	(HappyAbsSyn44  happy_var_1)
	 =  HappyAbsSyn43
		 ((:) happy_var_1 happy_var_3
	)
happyReduction_86 _ _ _  = notHappyAtAll 

happyReduce_87 = happySpecReduce_3  44 happyReduction_87
happyReduction_87 (HappyAbsSyn7  happy_var_3)
	_
	(HappyAbsSyn42  happy_var_1)
	 =  HappyAbsSyn44
		 (AbsVarg.IDefinition happy_var_1 happy_var_3
	)
happyReduction_87 _ _ _  = notHappyAtAll 

happyReduce_88 = happySpecReduce_0  45 happyReduction_88
happyReduction_88  =  HappyAbsSyn45
		 ([]
	)

happyReduce_89 = happySpecReduce_1  45 happyReduction_89
happyReduction_89 (HappyAbsSyn46  happy_var_1)
	 =  HappyAbsSyn45
		 ((:[]) happy_var_1
	)
happyReduction_89 _  = notHappyAtAll 

happyReduce_90 = happySpecReduce_3  45 happyReduction_90
happyReduction_90 (HappyAbsSyn45  happy_var_3)
	_
	(HappyAbsSyn46  happy_var_1)
	 =  HappyAbsSyn45
		 ((:) happy_var_1 happy_var_3
	)
happyReduction_90 _ _ _  = notHappyAtAll 

happyReduce_91 = happySpecReduce_3  46 happyReduction_91
happyReduction_91 (HappyAbsSyn42  happy_var_3)
	_
	(HappyAbsSyn42  happy_var_1)
	 =  HappyAbsSyn46
		 (AbsVarg.IMatchClause happy_var_1 happy_var_3
	)
happyReduction_91 _ _ _  = notHappyAtAll 

happyReduce_92 = happySpecReduce_1  47 happyReduction_92
happyReduction_92 _
	 =  HappyAbsSyn47
		 (AbsVarg.ThisFunctor
	)

happyReduce_93 = happySpecReduce_1  47 happyReduction_93
happyReduction_93 _
	 =  HappyAbsSyn47
		 (AbsVarg.SuperFunctor
	)

happyReduce_94 = happySpecReduce_1  47 happyReduction_94
happyReduction_94 (HappyAbsSyn6  happy_var_1)
	 =  HappyAbsSyn47
		 (AbsVarg.TypeFunctor happy_var_1
	)
happyReduction_94 _  = notHappyAtAll 

happyReduce_95 = happySpecReduce_1  47 happyReduction_95
happyReduction_95 (HappyAbsSyn7  happy_var_1)
	 =  HappyAbsSyn47
		 (AbsVarg.InstanceFunctor happy_var_1
	)
happyReduction_95 _  = notHappyAtAll 

happyReduce_96 = happySpecReduce_1  47 happyReduction_96
happyReduction_96 (HappyAbsSyn8  happy_var_1)
	 =  HappyAbsSyn47
		 (AbsVarg.MemberFunctor happy_var_1
	)
happyReduction_96 _  = notHappyAtAll 

happyReduce_97 = happySpecReduce_1  48 happyReduction_97
happyReduction_97 (HappyAbsSyn42  happy_var_1)
	 =  HappyAbsSyn48
		 (AbsVarg.ArgExpr happy_var_1
	)
happyReduction_97 _  = notHappyAtAll 

happyReduce_98 = happySpecReduce_1  48 happyReduction_98
happyReduction_98 (HappyAbsSyn47  happy_var_1)
	 =  HappyAbsSyn48
		 (AbsVarg.ArgFunc happy_var_1
	)
happyReduction_98 _  = notHappyAtAll 

happyReduce_99 = happySpecReduce_0  49 happyReduction_99
happyReduction_99  =  HappyAbsSyn49
		 ([]
	)

happyReduce_100 = happySpecReduce_2  49 happyReduction_100
happyReduction_100 (HappyAbsSyn48  happy_var_2)
	(HappyAbsSyn49  happy_var_1)
	 =  HappyAbsSyn49
		 (flip (:) happy_var_1 happy_var_2
	)
happyReduction_100 _ _  = notHappyAtAll 

happyReduce_101 = happySpecReduce_2  50 happyReduction_101
happyReduction_101 (HappyAbsSyn49  happy_var_2)
	(HappyAbsSyn47  happy_var_1)
	 =  HappyAbsSyn42
		 (AbsVarg.EApply happy_var_1 (reverse happy_var_2)
	)
happyReduction_101 _ _  = notHappyAtAll 

happyReduce_102 = happySpecReduce_1  50 happyReduction_102
happyReduction_102 (HappyAbsSyn42  happy_var_1)
	 =  HappyAbsSyn42
		 (happy_var_1
	)
happyReduction_102 _  = notHappyAtAll 

happyReduce_103 = happySpecReduce_1  51 happyReduction_103
happyReduction_103 (HappyAbsSyn42  happy_var_1)
	 =  HappyAbsSyn51
		 (AbsVarg.EListElem happy_var_1
	)
happyReduction_103 _  = notHappyAtAll 

happyReduce_104 = happySpecReduce_0  52 happyReduction_104
happyReduction_104  =  HappyAbsSyn52
		 ([]
	)

happyReduce_105 = happySpecReduce_1  52 happyReduction_105
happyReduction_105 (HappyAbsSyn51  happy_var_1)
	 =  HappyAbsSyn52
		 ((:[]) happy_var_1
	)
happyReduction_105 _  = notHappyAtAll 

happyReduce_106 = happySpecReduce_3  52 happyReduction_106
happyReduction_106 (HappyAbsSyn52  happy_var_3)
	_
	(HappyAbsSyn51  happy_var_1)
	 =  HappyAbsSyn52
		 ((:) happy_var_1 happy_var_3
	)
happyReduction_106 _ _ _  = notHappyAtAll 

happyReduce_107 = happySpecReduce_3  53 happyReduction_107
happyReduction_107 (HappyAbsSyn42  happy_var_3)
	_
	(HappyAbsSyn42  happy_var_1)
	 =  HappyAbsSyn42
		 (AbsVarg.EEq happy_var_1 happy_var_3
	)
happyReduction_107 _ _ _  = notHappyAtAll 

happyReduce_108 = happySpecReduce_3  53 happyReduction_108
happyReduction_108 (HappyAbsSyn42  happy_var_3)
	_
	(HappyAbsSyn42  happy_var_1)
	 =  HappyAbsSyn42
		 (AbsVarg.ELq happy_var_1 happy_var_3
	)
happyReduction_108 _ _ _  = notHappyAtAll 

happyReduce_109 = happySpecReduce_3  53 happyReduction_109
happyReduction_109 (HappyAbsSyn42  happy_var_3)
	_
	(HappyAbsSyn42  happy_var_1)
	 =  HappyAbsSyn42
		 (AbsVarg.EGt happy_var_1 happy_var_3
	)
happyReduction_109 _ _ _  = notHappyAtAll 

happyReduce_110 = happySpecReduce_3  53 happyReduction_110
happyReduction_110 (HappyAbsSyn42  happy_var_3)
	_
	(HappyAbsSyn42  happy_var_1)
	 =  HappyAbsSyn42
		 (AbsVarg.ELeq happy_var_1 happy_var_3
	)
happyReduction_110 _ _ _  = notHappyAtAll 

happyReduce_111 = happySpecReduce_3  53 happyReduction_111
happyReduction_111 (HappyAbsSyn42  happy_var_3)
	_
	(HappyAbsSyn42  happy_var_1)
	 =  HappyAbsSyn42
		 (AbsVarg.EGeq happy_var_1 happy_var_3
	)
happyReduction_111 _ _ _  = notHappyAtAll 

happyReduce_112 = happySpecReduce_1  53 happyReduction_112
happyReduction_112 (HappyAbsSyn42  happy_var_1)
	 =  HappyAbsSyn42
		 (happy_var_1
	)
happyReduction_112 _  = notHappyAtAll 

happyReduce_113 = happySpecReduce_3  54 happyReduction_113
happyReduction_113 (HappyAbsSyn42  happy_var_3)
	_
	(HappyAbsSyn42  happy_var_1)
	 =  HappyAbsSyn42
		 (AbsVarg.EAdd happy_var_1 happy_var_3
	)
happyReduction_113 _ _ _  = notHappyAtAll 

happyReduce_114 = happySpecReduce_3  54 happyReduction_114
happyReduction_114 (HappyAbsSyn42  happy_var_3)
	_
	(HappyAbsSyn42  happy_var_1)
	 =  HappyAbsSyn42
		 (AbsVarg.ESub happy_var_1 happy_var_3
	)
happyReduction_114 _ _ _  = notHappyAtAll 

happyReduce_115 = happySpecReduce_1  54 happyReduction_115
happyReduction_115 (HappyAbsSyn42  happy_var_1)
	 =  HappyAbsSyn42
		 (happy_var_1
	)
happyReduction_115 _  = notHappyAtAll 

happyReduce_116 = happySpecReduce_3  55 happyReduction_116
happyReduction_116 (HappyAbsSyn42  happy_var_3)
	_
	(HappyAbsSyn42  happy_var_1)
	 =  HappyAbsSyn42
		 (AbsVarg.EMul happy_var_1 happy_var_3
	)
happyReduction_116 _ _ _  = notHappyAtAll 

happyReduce_117 = happySpecReduce_3  55 happyReduction_117
happyReduction_117 (HappyAbsSyn42  happy_var_3)
	_
	(HappyAbsSyn42  happy_var_1)
	 =  HappyAbsSyn42
		 (AbsVarg.EDiv happy_var_1 happy_var_3
	)
happyReduction_117 _ _ _  = notHappyAtAll 

happyReduce_118 = happySpecReduce_1  55 happyReduction_118
happyReduction_118 (HappyAbsSyn42  happy_var_1)
	 =  HappyAbsSyn42
		 (happy_var_1
	)
happyReduction_118 _  = notHappyAtAll 

happyReduce_119 = happySpecReduce_3  56 happyReduction_119
happyReduction_119 (HappyAbsSyn42  happy_var_3)
	_
	(HappyAbsSyn42  happy_var_1)
	 =  HappyAbsSyn42
		 (AbsVarg.EPow happy_var_1 happy_var_3
	)
happyReduction_119 _ _ _  = notHappyAtAll 

happyReduce_120 = happySpecReduce_1  56 happyReduction_120
happyReduction_120 (HappyAbsSyn42  happy_var_1)
	 =  HappyAbsSyn42
		 (happy_var_1
	)
happyReduction_120 _  = notHappyAtAll 

happyReduce_121 = happySpecReduce_1  57 happyReduction_121
happyReduction_121 (HappyAbsSyn4  happy_var_1)
	 =  HappyAbsSyn42
		 (AbsVarg.EInt happy_var_1
	)
happyReduction_121 _  = notHappyAtAll 

happyReduce_122 = happySpecReduce_1  57 happyReduction_122
happyReduction_122 (HappyAbsSyn5  happy_var_1)
	 =  HappyAbsSyn42
		 (AbsVarg.EReal happy_var_1
	)
happyReduction_122 _  = notHappyAtAll 

happyReduce_123 = happySpecReduce_1  57 happyReduction_123
happyReduction_123 _
	 =  HappyAbsSyn42
		 (AbsVarg.EWild
	)

happyReduce_124 = happySpecReduce_3  57 happyReduction_124
happyReduction_124 _
	(HappyAbsSyn42  happy_var_2)
	_
	 =  HappyAbsSyn42
		 (happy_var_2
	)
happyReduction_124 _ _ _  = notHappyAtAll 

happyNewToken action sts stk [] =
	action 117 117 notHappyAtAll (HappyState action) sts stk []

happyNewToken action sts stk (tk:tks) =
	let cont i = action i i tk (HappyState action) sts stk tks in
	case tk of {
	PT _ (TS _ 1) -> cont 58;
	PT _ (TS _ 2) -> cont 59;
	PT _ (TS _ 3) -> cont 60;
	PT _ (TS _ 4) -> cont 61;
	PT _ (TS _ 5) -> cont 62;
	PT _ (TS _ 6) -> cont 63;
	PT _ (TS _ 7) -> cont 64;
	PT _ (TS _ 8) -> cont 65;
	PT _ (TS _ 9) -> cont 66;
	PT _ (TS _ 10) -> cont 67;
	PT _ (TS _ 11) -> cont 68;
	PT _ (TS _ 12) -> cont 69;
	PT _ (TS _ 13) -> cont 70;
	PT _ (TS _ 14) -> cont 71;
	PT _ (TS _ 15) -> cont 72;
	PT _ (TS _ 16) -> cont 73;
	PT _ (TS _ 17) -> cont 74;
	PT _ (TS _ 18) -> cont 75;
	PT _ (TS _ 19) -> cont 76;
	PT _ (TS _ 20) -> cont 77;
	PT _ (TS _ 21) -> cont 78;
	PT _ (TS _ 22) -> cont 79;
	PT _ (TS _ 23) -> cont 80;
	PT _ (TS _ 24) -> cont 81;
	PT _ (TS _ 25) -> cont 82;
	PT _ (TS _ 26) -> cont 83;
	PT _ (TS _ 27) -> cont 84;
	PT _ (TS _ 28) -> cont 85;
	PT _ (TS _ 29) -> cont 86;
	PT _ (TS _ 30) -> cont 87;
	PT _ (TS _ 31) -> cont 88;
	PT _ (TS _ 32) -> cont 89;
	PT _ (TS _ 33) -> cont 90;
	PT _ (TS _ 34) -> cont 91;
	PT _ (TS _ 35) -> cont 92;
	PT _ (TS _ 36) -> cont 93;
	PT _ (TS _ 37) -> cont 94;
	PT _ (TS _ 38) -> cont 95;
	PT _ (TS _ 39) -> cont 96;
	PT _ (TS _ 40) -> cont 97;
	PT _ (TS _ 41) -> cont 98;
	PT _ (TS _ 42) -> cont 99;
	PT _ (TS _ 43) -> cont 100;
	PT _ (TS _ 44) -> cont 101;
	PT _ (TS _ 45) -> cont 102;
	PT _ (TS _ 46) -> cont 103;
	PT _ (TS _ 47) -> cont 104;
	PT _ (TS _ 48) -> cont 105;
	PT _ (TS _ 49) -> cont 106;
	PT _ (TS _ 50) -> cont 107;
	PT _ (TS _ 51) -> cont 108;
	PT _ (TS _ 52) -> cont 109;
	PT _ (TS _ 53) -> cont 110;
	PT _ (TS _ 54) -> cont 111;
	PT _ (TI happy_dollar_dollar) -> cont 112;
	PT _ (TD happy_dollar_dollar) -> cont 113;
	PT _ (T_UIdent happy_dollar_dollar) -> cont 114;
	PT _ (T_LIdent happy_dollar_dollar) -> cont 115;
	PT _ (T_MFun happy_dollar_dollar) -> cont 116;
	_ -> happyError' ((tk:tks), [])
	}

happyError_ explist 117 tk tks = happyError' (tks, explist)
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
