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
	| HappyAbsSyn13 ([ConstrTypeParam])
	| HappyAbsSyn14 (ConstrTypeParam)
	| HappyAbsSyn15 (TypeDef)
	| HappyAbsSyn17 ([TypeDef])
	| HappyAbsSyn18 (PrimFreeType)
	| HappyAbsSyn19 (FreeTypeDef)
	| HappyAbsSyn21 ([FreeTypeDef])
	| HappyAbsSyn22 ([PrimFreeType])
	| HappyAbsSyn23 ([ArgDef])
	| HappyAbsSyn24 (ArgDef)
	| HappyAbsSyn25 (SuperclassType)
	| HappyAbsSyn26 ([SuperclassType])
	| HappyAbsSyn27 (ClassDef)
	| HappyAbsSyn28 (IsImplementing)
	| HappyAbsSyn29 (IsDeriving)
	| HappyAbsSyn30 ([ClassModifier])
	| HappyAbsSyn31 (ClassModifier)
	| HappyAbsSyn32 (ClassContents)
	| HappyAbsSyn33 (MemberDef)
	| HappyAbsSyn34 ([MemberDef])
	| HappyAbsSyn35 (FunDef)
	| HappyAbsSyn36 (RetType)
	| HappyAbsSyn37 (AbsRetType)
	| HappyAbsSyn38 ([FunDef])
	| HappyAbsSyn39 ([FunctionModifier])
	| HappyAbsSyn40 (FunctionModifier)
	| HappyAbsSyn41 (ClassField)
	| HappyAbsSyn42 ([ClassField])
	| HappyAbsSyn43 (FieldModifier)
	| HappyAbsSyn44 (Expr)
	| HappyAbsSyn45 ([AsDef])
	| HappyAbsSyn46 (AsDef)
	| HappyAbsSyn47 ([MatchClause])
	| HappyAbsSyn48 (MatchClause)
	| HappyAbsSyn49 (Functorial)
	| HappyAbsSyn50 (Arg)
	| HappyAbsSyn51 ([Arg])
	| HappyAbsSyn53 (ListElem)
	| HappyAbsSyn54 ([ListElem])

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
 action_218,
 action_219,
 action_220,
 action_221,
 action_222,
 action_223,
 action_224,
 action_225,
 action_226,
 action_227,
 action_228,
 action_229,
 action_230,
 action_231,
 action_232,
 action_233,
 action_234,
 action_235,
 action_236,
 action_237 :: () => Int -> ({-HappyReduction (Err) = -}
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
 happyReduce_124,
 happyReduce_125,
 happyReduce_126,
 happyReduce_127,
 happyReduce_128,
 happyReduce_129,
 happyReduce_130,
 happyReduce_131,
 happyReduce_132,
 happyReduce_133,
 happyReduce_134 :: () => ({-HappyReduction (Err) = -}
	   Int 
	-> (Token)
	-> HappyState (Token) (HappyStk HappyAbsSyn -> [(Token)] -> (Err) HappyAbsSyn)
	-> [HappyState (Token) (HappyStk HappyAbsSyn -> [(Token)] -> (Err) HappyAbsSyn)] 
	-> HappyStk HappyAbsSyn 
	-> [(Token)] -> (Err) HappyAbsSyn)

happyExpList :: Happy_Data_Array.Array Int Int
happyExpList = Happy_Data_Array.listArray (0,855) ([0,0,0,0,0,0,0,0,0,0,0,0,0,0,64,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,64,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,4096,0,0,0,0,16,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,64,1380,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,256,0,0,0,0,0,0,16384,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1024,0,0,0,0,0,1024,0,0,0,0,0,0,0,128,0,0,0,0,2048,0,0,0,12,0,0,0,0,0,0,16,0,0,0,128,768,4,49152,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,2,0,0,0,0,32,0,0,12288,0,0,0,0,0,0,0,0,0,0,0,0,4,0,512,0,0,0,0,0,0,0,0,0,0,0,0,0,8200,32,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,2,0,0,768,0,0,0,0,0,0,256,0,0,0,8192,0,0,0,48,0,0,0,128,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,4,0,0,0,64,0,0,0,0,0,0,2048,0,0,0,12,0,0,0,2,0,0,768,0,0,0,32768,0,0,0,0,0,0,0,64,0,0,0,0,0,0,0,0,0,128,0,0,0,0,0,0,0,2,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,64,128,0,0,0,0,0,4096,8192,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,16,0,0,0,0,0,0,0,0,0,0,0,0,0,32768,0,0,0,192,0,0,0,0,0,0,64,0,0,0,0,0,0,16384,0,0,0,0,4,0,0,0,0,0,0,0,0,0,0,0,0,0,8192,49152,0,0,48,0,0,0,8,48,0,3072,0,0,0,512,0,0,0,3,0,0,32768,0,0,0,192,0,0,0,32,0,0,12288,0,0,0,2048,0,0,0,12,0,0,0,512,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,8200,32,0,0,0,8,0,0,3072,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,2048,0,0,0,12,0,0,0,0,0,0,0,0,0,0,0,0,0,16384,0,0,0,8192,0,0,0,48,0,0,0,0,0,0,0,0,0,0,0,0,256,0,0,0,0,0,0,0,0,8,0,0,0,16384,0,0,0,0,0,0,0,0,0,0,0,0,0,0,4,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,8,0,0,3072,0,0,0,8192,0,0,0,0,0,0,0,0,8,0,0,0,0,0,0,512,0,0,0,0,0,0,32768,0,0,0,0,0,0,0,32,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,16,0,0,0,0,0,0,128,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,2,0,0,768,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,4096,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,12288,33313,0,0,0,0,0,0,0,4096,0,0,0,0,0,0,0,0,0,0,0,0,0,0,16,0,0,0,0,0,8192,32896,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,128,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,32768,0,0,0,0,0,0,0,0,0,0,0,32896,0,0,32768,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,32,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,8192,0,0,0,2048,0,4,0,12,0,0,0,0,0,0,0,0,0,0,128,0,0,49152,0,0,0,0,32,0,0,0,0,0,0,8,8736,33800,7940,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,256,0,0,0,0,0,0,64,0,0,0,0,0,0,50708,0,0,0,0,0,0,4224,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,128,9728,16514,61512,1,0,0,8192,32768,8328,4624,124,0,0,0,0,0,0,0,0,0,0,512,34816,520,53537,7,0,0,32768,0,33314,18496,496,0,0,0,32,34944,4128,31762,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,8,0,0,3072,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,128,0,0,0,0,0,0,512,0,0,0,0,0,512,0,0,0,0,0,0,0,2048,0,0,0,0,8192,32768,8328,4624,124,0,0,0,0,0,0,0,0,0,0,8192,0,0,0,0,0,0,0,0,8,0,0,0,0,0,64,0,0,0,0,0,0,0,0,0,0,0,0,0,0,2,128,8192,1985,0,0,0,128,8192,0,61512,1,0,0,8192,0,8,4608,124,0,0,0,8,512,32768,7940,0,0,0,512,32768,0,49440,7,0,0,32768,0,32,18432,496,0,0,0,32,2048,0,31762,0,0,0,2048,0,2,1152,31,0,0,0,2,128,8192,1985,0,0,0,128,8192,0,61512,1,0,0,8192,0,8,4608,124,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,32,34944,4128,31762,0,0,0,0,0,0,0,0,0,0,0,80,0,0,0,0,0,0,5120,0,0,0,0,0,0,0,5,0,0,0,0,0,0,320,0,0,0,0,0,0,20480,0,0,0,0,0,0,0,66,0,0,0,0,0,0,4224,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,32896,0,0,32768,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,512,34816,520,49441,7,0,0,0,0,0,0,8,0,0,0,16384,0,0,0,0,0,0,2048,8192,2082,1156,31,0,0,0,0,0,0,512,0,0,0,128,8704,16514,61512,1,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,512,34816,520,49441,7,0,0,0,0,2048,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,2,2184,8450,1985,0,0,0,0,0,2048,0,0,0,0,0,0,0,0,0,0,0,0,8,0,0,3072,0,0,0,0,128,0,0,0,0,0,32768,0,33314,18496,496,0,0,0,0,0,0,0,0,0,0,2048,8192,2082,1156,31,0,0,0,128,0,0,0,0,0,0,0,0,0,2048,0,0,0,0,64,0,0,0,0,0,0,8,8736,33800,7940,0,0,0,0,0,0,0,0,0,0,32768,0,33314,18496,496,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,2,2184,8450,1985,0,0,0,256,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	])

{-# NOINLINE happyExpListPerState #-}
happyExpListPerState st =
    token_strs_expected
  where token_strs = ["error","%dummy","%start_pProgramDef","Integer","Double","UIdent","LIdent","MFun","ProgramDef","ListClassDef","ImportDef","ListImportDef","ListConstrTypeParam","ConstrTypeParam","TypeDef","TypeDef1","ListTypeDef","PrimFreeType","FreeTypeDef","FreeTypeDef1","ListFreeTypeDef","ListPrimFreeType","ListArgDef","ArgDef","SuperclassType","ListSuperclassType","ClassDef","IsImplementing","IsDeriving","ListClassModifier","ClassModifier","ClassContents","MemberDef","ListMemberDef","FunDef","RetType","AbsRetType","ListFunDef","ListFunctionModifier","FunctionModifier","ClassField","ListClassField","FieldModifier","Expr","ListAsDef","AsDef","ListMatchClause","MatchClause","Functorial","Arg","ListArg","Expr5","ListElem","ListListElem","Expr1","Expr2","Expr3","Expr4","Expr6","'('","')'","'*'","'+'","','","'-'","'->'","'/'","':'","';'","'<'","'<='","'='","'=='","'=>'","'>'","'>='","'?'","'['","'\\\\'","']'","'^'","'_'","'abstract'","'as'","'class'","'define'","'deriving'","'else'","'final'","'function'","'has'","'if'","'implement'","'implementing'","'import'","'in'","'interface'","'internal'","'match'","'module'","'sealed'","'static'","'struct'","'super'","'template'","'then'","'this'","'unique'","'where'","'with'","'{'","'}'","L_integ","L_doubl","L_UIdent","L_LIdent","L_MFun","%eof"]
        bit_start = st * 118
        bit_end = (st + 1) * 118
        read_bit = readArrayBit happyExpList
        bits = map read_bit [bit_start..bit_end - 1]
        bits_indexed = zip bits [0..117]
        token_strs_expected = concatMap f bits_indexed
        f (False, _) = []
        f (True, nr) = [token_strs !! nr]

action_0 (9) = happyGoto action_3
action_0 (12) = happyGoto action_4
action_0 _ = happyReduce_10

action_1 (113) = happyShift action_2
action_1 _ = happyFail (happyExpListPerState 1)

action_2 _ = happyReduce_1

action_3 (118) = happyAccept
action_3 _ = happyFail (happyExpListPerState 3)

action_4 (95) = happyShift action_7
action_4 (10) = happyGoto action_5
action_4 (11) = happyGoto action_6
action_4 _ = happyReduce_7

action_5 (118) = happyReduce_6
action_5 (27) = happyGoto action_10
action_5 (30) = happyGoto action_11
action_5 _ = happyReduce_53

action_6 _ = happyReduce_11

action_7 (115) = happyShift action_9
action_7 (6) = happyGoto action_8
action_7 _ = happyFail (happyExpListPerState 7)

action_8 (69) = happyShift action_19
action_8 _ = happyFail (happyExpListPerState 8)

action_9 _ = happyReduce_3

action_10 _ = happyReduce_8

action_11 (85) = happyShift action_13
action_11 (97) = happyShift action_14
action_11 (100) = happyShift action_15
action_11 (101) = happyShift action_16
action_11 (103) = happyShift action_17
action_11 (105) = happyShift action_18
action_11 (31) = happyGoto action_12
action_11 _ = happyFail (happyExpListPerState 11)

action_12 _ = happyReduce_54

action_13 (115) = happyShift action_9
action_13 (6) = happyGoto action_22
action_13 _ = happyFail (happyExpListPerState 13)

action_14 _ = happyReduce_56

action_15 _ = happyReduce_55

action_16 _ = happyReduce_57

action_17 (115) = happyShift action_9
action_17 (6) = happyGoto action_21
action_17 _ = happyFail (happyExpListPerState 17)

action_18 (115) = happyShift action_9
action_18 (6) = happyGoto action_20
action_18 _ = happyFail (happyExpListPerState 18)

action_19 _ = happyReduce_9

action_20 (13) = happyGoto action_26
action_20 _ = happyReduce_12

action_21 (109) = happyShift action_25
action_21 _ = happyFail (happyExpListPerState 21)

action_22 (87) = happyShift action_24
action_22 (29) = happyGoto action_23
action_22 _ = happyReduce_52

action_23 (94) = happyShift action_43
action_23 (28) = happyGoto action_42
action_23 _ = happyReduce_50

action_24 (60) = happyShift action_41
action_24 (115) = happyShift action_9
action_24 (116) = happyShift action_34
action_24 (6) = happyGoto action_36
action_24 (7) = happyGoto action_37
action_24 (19) = happyGoto action_38
action_24 (20) = happyGoto action_39
action_24 (25) = happyGoto action_40
action_24 _ = happyFail (happyExpListPerState 24)

action_25 (111) = happyShift action_35
action_25 _ = happyFail (happyExpListPerState 25)

action_26 (60) = happyShift action_31
action_26 (77) = happyShift action_32
action_26 (78) = happyShift action_33
action_26 (87) = happyShift action_24
action_26 (115) = happyShift action_9
action_26 (116) = happyShift action_34
action_26 (6) = happyGoto action_27
action_26 (7) = happyGoto action_28
action_26 (14) = happyGoto action_29
action_26 (29) = happyGoto action_30
action_26 _ = happyReduce_52

action_27 _ = happyReduce_15

action_28 _ = happyReduce_14

action_29 _ = happyReduce_13

action_30 (94) = happyShift action_43
action_30 (28) = happyGoto action_63
action_30 _ = happyReduce_50

action_31 (60) = happyShift action_62
action_31 (115) = happyShift action_9
action_31 (116) = happyShift action_34
action_31 (6) = happyGoto action_58
action_31 (7) = happyGoto action_59
action_31 (15) = happyGoto action_60
action_31 (16) = happyGoto action_61
action_31 _ = happyFail (happyExpListPerState 31)

action_32 _ = happyReduce_16

action_33 (77) = happyShift action_57
action_33 (116) = happyShift action_34
action_33 (7) = happyGoto action_56
action_33 _ = happyFail (happyExpListPerState 33)

action_34 _ = happyReduce_4

action_35 (98) = happyShift action_54
action_35 (108) = happyShift action_55
action_35 (116) = happyShift action_34
action_35 (7) = happyGoto action_50
action_35 (41) = happyGoto action_51
action_35 (42) = happyGoto action_52
action_35 (43) = happyGoto action_53
action_35 _ = happyReduce_82

action_36 (22) = happyGoto action_49
action_36 _ = happyReduce_37

action_37 (22) = happyGoto action_48
action_37 _ = happyReduce_37

action_38 _ = happyReduce_43

action_39 _ = happyReduce_33

action_40 _ = happyReduce_51

action_41 (60) = happyShift action_41
action_41 (115) = happyShift action_9
action_41 (116) = happyShift action_34
action_41 (6) = happyGoto action_36
action_41 (7) = happyGoto action_37
action_41 (19) = happyGoto action_47
action_41 (20) = happyGoto action_39
action_41 _ = happyFail (happyExpListPerState 41)

action_42 (109) = happyShift action_46
action_42 _ = happyFail (happyExpListPerState 42)

action_43 (60) = happyShift action_41
action_43 (115) = happyShift action_9
action_43 (116) = happyShift action_34
action_43 (6) = happyGoto action_36
action_43 (7) = happyGoto action_37
action_43 (19) = happyGoto action_38
action_43 (20) = happyGoto action_39
action_43 (25) = happyGoto action_44
action_43 (26) = happyGoto action_45
action_43 _ = happyFail (happyExpListPerState 43)

action_44 (64) = happyShift action_83
action_44 _ = happyReduce_44

action_45 _ = happyReduce_49

action_46 (111) = happyShift action_82
action_46 _ = happyFail (happyExpListPerState 46)

action_47 (61) = happyShift action_81
action_47 _ = happyFail (happyExpListPerState 47)

action_48 (60) = happyShift action_80
action_48 (115) = happyShift action_9
action_48 (116) = happyShift action_34
action_48 (6) = happyGoto action_77
action_48 (7) = happyGoto action_78
action_48 (18) = happyGoto action_79
action_48 _ = happyReduce_32

action_49 (60) = happyShift action_80
action_49 (115) = happyShift action_9
action_49 (116) = happyShift action_34
action_49 (6) = happyGoto action_77
action_49 (7) = happyGoto action_78
action_49 (18) = happyGoto action_79
action_49 _ = happyReduce_31

action_50 (68) = happyShift action_76
action_50 _ = happyFail (happyExpListPerState 50)

action_51 (69) = happyShift action_75
action_51 _ = happyReduce_83

action_52 (112) = happyShift action_74
action_52 _ = happyFail (happyExpListPerState 52)

action_53 (116) = happyShift action_34
action_53 (7) = happyGoto action_73
action_53 _ = happyFail (happyExpListPerState 53)

action_54 _ = happyReduce_85

action_55 _ = happyReduce_86

action_56 (87) = happyShift action_71
action_56 (104) = happyShift action_72
action_56 _ = happyFail (happyExpListPerState 56)

action_57 (87) = happyShift action_69
action_57 (104) = happyShift action_70
action_57 _ = happyFail (happyExpListPerState 57)

action_58 (13) = happyGoto action_68
action_58 _ = happyReduce_12

action_59 (13) = happyGoto action_67
action_59 _ = happyReduce_12

action_60 (61) = happyShift action_66
action_60 _ = happyFail (happyExpListPerState 60)

action_61 _ = happyReduce_24

action_62 (60) = happyShift action_62
action_62 (115) = happyShift action_9
action_62 (116) = happyShift action_34
action_62 (6) = happyGoto action_58
action_62 (7) = happyGoto action_59
action_62 (15) = happyGoto action_65
action_62 (16) = happyGoto action_61
action_62 _ = happyFail (happyExpListPerState 62)

action_63 (109) = happyShift action_64
action_63 _ = happyFail (happyExpListPerState 63)

action_64 (111) = happyShift action_99
action_64 _ = happyFail (happyExpListPerState 64)

action_65 (61) = happyShift action_98
action_65 _ = happyFail (happyExpListPerState 65)

action_66 _ = happyReduce_17

action_67 (60) = happyShift action_31
action_67 (77) = happyShift action_32
action_67 (78) = happyShift action_33
action_67 (115) = happyShift action_9
action_67 (116) = happyShift action_34
action_67 (6) = happyGoto action_27
action_67 (7) = happyGoto action_28
action_67 (14) = happyGoto action_29
action_67 _ = happyReduce_23

action_68 (60) = happyShift action_31
action_68 (77) = happyShift action_32
action_68 (78) = happyShift action_33
action_68 (115) = happyShift action_9
action_68 (116) = happyShift action_34
action_68 (6) = happyGoto action_27
action_68 (7) = happyGoto action_28
action_68 (14) = happyGoto action_29
action_68 _ = happyReduce_22

action_69 (60) = happyShift action_62
action_69 (115) = happyShift action_9
action_69 (116) = happyShift action_34
action_69 (6) = happyGoto action_58
action_69 (7) = happyGoto action_59
action_69 (15) = happyGoto action_93
action_69 (16) = happyGoto action_61
action_69 (17) = happyGoto action_97
action_69 _ = happyFail (happyExpListPerState 69)

action_70 (60) = happyShift action_62
action_70 (115) = happyShift action_9
action_70 (116) = happyShift action_34
action_70 (6) = happyGoto action_58
action_70 (7) = happyGoto action_59
action_70 (15) = happyGoto action_93
action_70 (16) = happyGoto action_61
action_70 (17) = happyGoto action_96
action_70 _ = happyFail (happyExpListPerState 70)

action_71 (60) = happyShift action_62
action_71 (115) = happyShift action_9
action_71 (116) = happyShift action_34
action_71 (6) = happyGoto action_58
action_71 (7) = happyGoto action_59
action_71 (15) = happyGoto action_93
action_71 (16) = happyGoto action_61
action_71 (17) = happyGoto action_95
action_71 _ = happyFail (happyExpListPerState 71)

action_72 (60) = happyShift action_62
action_72 (115) = happyShift action_9
action_72 (116) = happyShift action_34
action_72 (6) = happyGoto action_58
action_72 (7) = happyGoto action_59
action_72 (15) = happyGoto action_93
action_72 (16) = happyGoto action_61
action_72 (17) = happyGoto action_94
action_72 _ = happyFail (happyExpListPerState 72)

action_73 (68) = happyShift action_92
action_73 _ = happyFail (happyExpListPerState 73)

action_74 _ = happyReduce_46

action_75 (98) = happyShift action_54
action_75 (108) = happyShift action_55
action_75 (116) = happyShift action_34
action_75 (7) = happyGoto action_50
action_75 (41) = happyGoto action_51
action_75 (42) = happyGoto action_91
action_75 (43) = happyGoto action_53
action_75 _ = happyReduce_82

action_76 (60) = happyShift action_41
action_76 (115) = happyShift action_9
action_76 (116) = happyShift action_34
action_76 (6) = happyGoto action_36
action_76 (7) = happyGoto action_37
action_76 (19) = happyGoto action_90
action_76 (20) = happyGoto action_39
action_76 _ = happyFail (happyExpListPerState 76)

action_77 _ = happyReduce_30

action_78 _ = happyReduce_29

action_79 _ = happyReduce_38

action_80 (60) = happyShift action_41
action_80 (115) = happyShift action_9
action_80 (116) = happyShift action_34
action_80 (6) = happyGoto action_36
action_80 (7) = happyGoto action_37
action_80 (19) = happyGoto action_89
action_80 (20) = happyGoto action_39
action_80 _ = happyFail (happyExpListPerState 80)

action_81 _ = happyReduce_34

action_82 (115) = happyShift action_9
action_82 (6) = happyGoto action_85
action_82 (32) = happyGoto action_86
action_82 (33) = happyGoto action_87
action_82 (34) = happyGoto action_88
action_82 _ = happyReduce_61

action_83 (60) = happyShift action_41
action_83 (115) = happyShift action_9
action_83 (116) = happyShift action_34
action_83 (6) = happyGoto action_36
action_83 (7) = happyGoto action_37
action_83 (19) = happyGoto action_38
action_83 (20) = happyGoto action_39
action_83 (25) = happyGoto action_44
action_83 (26) = happyGoto action_84
action_83 _ = happyFail (happyExpListPerState 83)

action_84 _ = happyReduce_45

action_85 (91) = happyShift action_113
action_85 _ = happyReduce_59

action_86 (112) = happyShift action_112
action_86 _ = happyFail (happyExpListPerState 86)

action_87 (69) = happyShift action_111
action_87 _ = happyReduce_62

action_88 (112) = happyReduce_70
action_88 (35) = happyGoto action_108
action_88 (38) = happyGoto action_109
action_88 (39) = happyGoto action_110
action_88 _ = happyReduce_73

action_89 (61) = happyShift action_107
action_89 _ = happyFail (happyExpListPerState 89)

action_90 _ = happyReduce_81

action_91 _ = happyReduce_84

action_92 (60) = happyShift action_41
action_92 (115) = happyShift action_9
action_92 (116) = happyShift action_34
action_92 (6) = happyGoto action_36
action_92 (7) = happyGoto action_37
action_92 (19) = happyGoto action_106
action_92 (20) = happyGoto action_39
action_92 _ = happyFail (happyExpListPerState 92)

action_93 (64) = happyShift action_105
action_93 _ = happyReduce_26

action_94 (80) = happyShift action_104
action_94 _ = happyFail (happyExpListPerState 94)

action_95 (80) = happyShift action_103
action_95 _ = happyFail (happyExpListPerState 95)

action_96 (80) = happyShift action_102
action_96 _ = happyFail (happyExpListPerState 96)

action_97 (80) = happyShift action_101
action_97 _ = happyFail (happyExpListPerState 97)

action_98 _ = happyReduce_25

action_99 (115) = happyShift action_9
action_99 (6) = happyGoto action_85
action_99 (32) = happyGoto action_100
action_99 (33) = happyGoto action_87
action_99 (34) = happyGoto action_88
action_99 _ = happyReduce_61

action_100 (112) = happyShift action_125
action_100 _ = happyFail (happyExpListPerState 100)

action_101 _ = happyReduce_21

action_102 _ = happyReduce_19

action_103 _ = happyReduce_20

action_104 _ = happyReduce_18

action_105 (60) = happyShift action_62
action_105 (115) = happyShift action_9
action_105 (116) = happyShift action_34
action_105 (6) = happyGoto action_58
action_105 (7) = happyGoto action_59
action_105 (15) = happyGoto action_93
action_105 (16) = happyGoto action_61
action_105 (17) = happyGoto action_124
action_105 _ = happyFail (happyExpListPerState 105)

action_106 _ = happyReduce_80

action_107 _ = happyReduce_28

action_108 (69) = happyShift action_123
action_108 _ = happyReduce_71

action_109 _ = happyReduce_58

action_110 (89) = happyShift action_117
action_110 (90) = happyShift action_118
action_110 (93) = happyShift action_119
action_110 (98) = happyShift action_120
action_110 (102) = happyShift action_121
action_110 (108) = happyShift action_122
action_110 (40) = happyGoto action_116
action_110 _ = happyFail (happyExpListPerState 110)

action_111 (115) = happyShift action_9
action_111 (6) = happyGoto action_85
action_111 (33) = happyGoto action_87
action_111 (34) = happyGoto action_115
action_111 _ = happyReduce_61

action_112 _ = happyReduce_47

action_113 (111) = happyShift action_114
action_113 _ = happyFail (happyExpListPerState 113)

action_114 (98) = happyShift action_54
action_114 (108) = happyShift action_55
action_114 (116) = happyShift action_34
action_114 (7) = happyGoto action_50
action_114 (41) = happyGoto action_51
action_114 (42) = happyGoto action_128
action_114 (43) = happyGoto action_53
action_114 _ = happyReduce_82

action_115 _ = happyReduce_63

action_116 _ = happyReduce_74

action_117 _ = happyReduce_78

action_118 (116) = happyShift action_34
action_118 (7) = happyGoto action_127
action_118 _ = happyFail (happyExpListPerState 118)

action_119 _ = happyReduce_77

action_120 _ = happyReduce_76

action_121 _ = happyReduce_75

action_122 _ = happyReduce_79

action_123 (112) = happyReduce_70
action_123 (35) = happyGoto action_108
action_123 (38) = happyGoto action_126
action_123 (39) = happyGoto action_110
action_123 _ = happyReduce_73

action_124 _ = happyReduce_27

action_125 _ = happyReduce_48

action_126 _ = happyReduce_72

action_127 (23) = happyGoto action_130
action_127 _ = happyReduce_39

action_128 (112) = happyShift action_129
action_128 _ = happyFail (happyExpListPerState 128)

action_129 _ = happyReduce_60

action_130 (60) = happyShift action_135
action_130 (68) = happyShift action_136
action_130 (72) = happyReduce_67
action_130 (116) = happyShift action_34
action_130 (7) = happyGoto action_131
action_130 (24) = happyGoto action_132
action_130 (36) = happyGoto action_133
action_130 (37) = happyGoto action_134
action_130 _ = happyReduce_69

action_131 _ = happyReduce_42

action_132 _ = happyReduce_40

action_133 (72) = happyShift action_140
action_133 _ = happyFail (happyExpListPerState 133)

action_134 _ = happyReduce_65

action_135 (116) = happyShift action_34
action_135 (7) = happyGoto action_139
action_135 _ = happyFail (happyExpListPerState 135)

action_136 (60) = happyShift action_41
action_136 (83) = happyShift action_138
action_136 (115) = happyShift action_9
action_136 (116) = happyShift action_34
action_136 (6) = happyGoto action_36
action_136 (7) = happyGoto action_37
action_136 (19) = happyGoto action_137
action_136 (20) = happyGoto action_39
action_136 _ = happyFail (happyExpListPerState 136)

action_137 _ = happyReduce_66

action_138 (60) = happyShift action_41
action_138 (115) = happyShift action_9
action_138 (116) = happyShift action_34
action_138 (6) = happyGoto action_36
action_138 (7) = happyGoto action_37
action_138 (19) = happyGoto action_165
action_138 (20) = happyGoto action_39
action_138 _ = happyFail (happyExpListPerState 138)

action_139 (68) = happyShift action_164
action_139 _ = happyFail (happyExpListPerState 139)

action_140 (60) = happyShift action_154
action_140 (78) = happyShift action_155
action_140 (82) = happyShift action_156
action_140 (86) = happyShift action_157
action_140 (92) = happyShift action_158
action_140 (99) = happyShift action_159
action_140 (104) = happyShift action_160
action_140 (107) = happyShift action_161
action_140 (113) = happyShift action_2
action_140 (114) = happyShift action_162
action_140 (115) = happyShift action_9
action_140 (116) = happyShift action_34
action_140 (117) = happyShift action_163
action_140 (4) = happyGoto action_141
action_140 (5) = happyGoto action_142
action_140 (6) = happyGoto action_143
action_140 (7) = happyGoto action_144
action_140 (8) = happyGoto action_145
action_140 (44) = happyGoto action_146
action_140 (49) = happyGoto action_147
action_140 (52) = happyGoto action_148
action_140 (55) = happyGoto action_149
action_140 (56) = happyGoto action_150
action_140 (57) = happyGoto action_151
action_140 (58) = happyGoto action_152
action_140 (59) = happyGoto action_153
action_140 _ = happyFail (happyExpListPerState 140)

action_141 _ = happyReduce_131

action_142 _ = happyReduce_132

action_143 _ = happyReduce_104

action_144 _ = happyReduce_105

action_145 _ = happyReduce_106

action_146 _ = happyReduce_64

action_147 (51) = happyGoto action_187
action_147 _ = happyReduce_109

action_148 (81) = happyShift action_186
action_148 _ = happyReduce_130

action_149 (73) = happyShift action_185
action_149 _ = happyReduce_93

action_150 (63) = happyShift action_179
action_150 (65) = happyShift action_180
action_150 (70) = happyShift action_181
action_150 (71) = happyShift action_182
action_150 (75) = happyShift action_183
action_150 (76) = happyShift action_184
action_150 _ = happyReduce_122

action_151 (62) = happyShift action_177
action_151 (67) = happyShift action_178
action_151 _ = happyReduce_125

action_152 _ = happyReduce_128

action_153 _ = happyReduce_112

action_154 (60) = happyShift action_154
action_154 (78) = happyShift action_155
action_154 (79) = happyShift action_176
action_154 (82) = happyShift action_156
action_154 (86) = happyShift action_157
action_154 (92) = happyShift action_158
action_154 (99) = happyShift action_159
action_154 (104) = happyShift action_160
action_154 (107) = happyShift action_161
action_154 (113) = happyShift action_2
action_154 (114) = happyShift action_162
action_154 (115) = happyShift action_9
action_154 (116) = happyShift action_34
action_154 (117) = happyShift action_163
action_154 (4) = happyGoto action_141
action_154 (5) = happyGoto action_142
action_154 (6) = happyGoto action_143
action_154 (7) = happyGoto action_144
action_154 (8) = happyGoto action_145
action_154 (44) = happyGoto action_175
action_154 (49) = happyGoto action_147
action_154 (52) = happyGoto action_148
action_154 (55) = happyGoto action_149
action_154 (56) = happyGoto action_150
action_154 (57) = happyGoto action_151
action_154 (58) = happyGoto action_152
action_154 (59) = happyGoto action_153
action_154 _ = happyFail (happyExpListPerState 154)

action_155 (60) = happyShift action_154
action_155 (78) = happyShift action_155
action_155 (82) = happyShift action_156
action_155 (86) = happyShift action_157
action_155 (92) = happyShift action_158
action_155 (99) = happyShift action_159
action_155 (104) = happyShift action_160
action_155 (107) = happyShift action_161
action_155 (113) = happyShift action_2
action_155 (114) = happyShift action_162
action_155 (115) = happyShift action_9
action_155 (116) = happyShift action_34
action_155 (117) = happyShift action_163
action_155 (4) = happyGoto action_141
action_155 (5) = happyGoto action_142
action_155 (6) = happyGoto action_143
action_155 (7) = happyGoto action_144
action_155 (8) = happyGoto action_145
action_155 (44) = happyGoto action_172
action_155 (49) = happyGoto action_147
action_155 (52) = happyGoto action_148
action_155 (53) = happyGoto action_173
action_155 (54) = happyGoto action_174
action_155 (55) = happyGoto action_149
action_155 (56) = happyGoto action_150
action_155 (57) = happyGoto action_151
action_155 (58) = happyGoto action_152
action_155 (59) = happyGoto action_153
action_155 _ = happyReduce_114

action_156 _ = happyReduce_133

action_157 (60) = happyShift action_154
action_157 (78) = happyShift action_155
action_157 (82) = happyShift action_156
action_157 (86) = happyShift action_157
action_157 (92) = happyShift action_158
action_157 (99) = happyShift action_159
action_157 (104) = happyShift action_160
action_157 (107) = happyShift action_161
action_157 (111) = happyShift action_171
action_157 (113) = happyShift action_2
action_157 (114) = happyShift action_162
action_157 (115) = happyShift action_9
action_157 (116) = happyShift action_34
action_157 (117) = happyShift action_163
action_157 (4) = happyGoto action_141
action_157 (5) = happyGoto action_142
action_157 (6) = happyGoto action_143
action_157 (7) = happyGoto action_144
action_157 (8) = happyGoto action_145
action_157 (44) = happyGoto action_169
action_157 (46) = happyGoto action_170
action_157 (49) = happyGoto action_147
action_157 (52) = happyGoto action_148
action_157 (55) = happyGoto action_149
action_157 (56) = happyGoto action_150
action_157 (57) = happyGoto action_151
action_157 (58) = happyGoto action_152
action_157 (59) = happyGoto action_153
action_157 _ = happyFail (happyExpListPerState 157)

action_158 (60) = happyShift action_154
action_158 (78) = happyShift action_155
action_158 (82) = happyShift action_156
action_158 (86) = happyShift action_157
action_158 (92) = happyShift action_158
action_158 (99) = happyShift action_159
action_158 (104) = happyShift action_160
action_158 (107) = happyShift action_161
action_158 (113) = happyShift action_2
action_158 (114) = happyShift action_162
action_158 (115) = happyShift action_9
action_158 (116) = happyShift action_34
action_158 (117) = happyShift action_163
action_158 (4) = happyGoto action_141
action_158 (5) = happyGoto action_142
action_158 (6) = happyGoto action_143
action_158 (7) = happyGoto action_144
action_158 (8) = happyGoto action_145
action_158 (44) = happyGoto action_168
action_158 (49) = happyGoto action_147
action_158 (52) = happyGoto action_148
action_158 (55) = happyGoto action_149
action_158 (56) = happyGoto action_150
action_158 (57) = happyGoto action_151
action_158 (58) = happyGoto action_152
action_158 (59) = happyGoto action_153
action_158 _ = happyFail (happyExpListPerState 158)

action_159 (60) = happyShift action_154
action_159 (78) = happyShift action_155
action_159 (82) = happyShift action_156
action_159 (86) = happyShift action_157
action_159 (92) = happyShift action_158
action_159 (99) = happyShift action_159
action_159 (104) = happyShift action_160
action_159 (107) = happyShift action_161
action_159 (113) = happyShift action_2
action_159 (114) = happyShift action_162
action_159 (115) = happyShift action_9
action_159 (116) = happyShift action_34
action_159 (117) = happyShift action_163
action_159 (4) = happyGoto action_141
action_159 (5) = happyGoto action_142
action_159 (6) = happyGoto action_143
action_159 (7) = happyGoto action_144
action_159 (8) = happyGoto action_145
action_159 (44) = happyGoto action_167
action_159 (49) = happyGoto action_147
action_159 (52) = happyGoto action_148
action_159 (55) = happyGoto action_149
action_159 (56) = happyGoto action_150
action_159 (57) = happyGoto action_151
action_159 (58) = happyGoto action_152
action_159 (59) = happyGoto action_153
action_159 _ = happyFail (happyExpListPerState 159)

action_160 _ = happyReduce_103

action_161 _ = happyReduce_102

action_162 _ = happyReduce_2

action_163 _ = happyReduce_5

action_164 (60) = happyShift action_62
action_164 (115) = happyShift action_9
action_164 (116) = happyShift action_34
action_164 (6) = happyGoto action_58
action_164 (7) = happyGoto action_59
action_164 (15) = happyGoto action_166
action_164 (16) = happyGoto action_61
action_164 _ = happyFail (happyExpListPerState 164)

action_165 _ = happyReduce_68

action_166 (61) = happyShift action_212
action_166 _ = happyFail (happyExpListPerState 166)

action_167 (110) = happyShift action_211
action_167 _ = happyFail (happyExpListPerState 167)

action_168 (106) = happyShift action_210
action_168 _ = happyFail (happyExpListPerState 168)

action_169 (84) = happyShift action_209
action_169 _ = happyFail (happyExpListPerState 169)

action_170 (96) = happyShift action_208
action_170 _ = happyFail (happyExpListPerState 170)

action_171 (60) = happyShift action_154
action_171 (78) = happyShift action_155
action_171 (82) = happyShift action_156
action_171 (86) = happyShift action_157
action_171 (92) = happyShift action_158
action_171 (99) = happyShift action_159
action_171 (104) = happyShift action_160
action_171 (107) = happyShift action_161
action_171 (113) = happyShift action_2
action_171 (114) = happyShift action_162
action_171 (115) = happyShift action_9
action_171 (116) = happyShift action_34
action_171 (117) = happyShift action_163
action_171 (4) = happyGoto action_141
action_171 (5) = happyGoto action_142
action_171 (6) = happyGoto action_143
action_171 (7) = happyGoto action_144
action_171 (8) = happyGoto action_145
action_171 (44) = happyGoto action_169
action_171 (45) = happyGoto action_206
action_171 (46) = happyGoto action_207
action_171 (49) = happyGoto action_147
action_171 (52) = happyGoto action_148
action_171 (55) = happyGoto action_149
action_171 (56) = happyGoto action_150
action_171 (57) = happyGoto action_151
action_171 (58) = happyGoto action_152
action_171 (59) = happyGoto action_153
action_171 _ = happyReduce_94

action_172 _ = happyReduce_113

action_173 (64) = happyShift action_205
action_173 _ = happyReduce_115

action_174 (80) = happyShift action_204
action_174 _ = happyFail (happyExpListPerState 174)

action_175 (61) = happyShift action_203
action_175 _ = happyFail (happyExpListPerState 175)

action_176 (23) = happyGoto action_202
action_176 _ = happyReduce_39

action_177 (60) = happyShift action_191
action_177 (82) = happyShift action_156
action_177 (104) = happyShift action_160
action_177 (107) = happyShift action_161
action_177 (113) = happyShift action_2
action_177 (114) = happyShift action_162
action_177 (115) = happyShift action_9
action_177 (116) = happyShift action_34
action_177 (117) = happyShift action_163
action_177 (4) = happyGoto action_141
action_177 (5) = happyGoto action_142
action_177 (6) = happyGoto action_143
action_177 (7) = happyGoto action_144
action_177 (8) = happyGoto action_145
action_177 (49) = happyGoto action_147
action_177 (52) = happyGoto action_148
action_177 (58) = happyGoto action_201
action_177 (59) = happyGoto action_153
action_177 _ = happyFail (happyExpListPerState 177)

action_178 (60) = happyShift action_191
action_178 (82) = happyShift action_156
action_178 (104) = happyShift action_160
action_178 (107) = happyShift action_161
action_178 (113) = happyShift action_2
action_178 (114) = happyShift action_162
action_178 (115) = happyShift action_9
action_178 (116) = happyShift action_34
action_178 (117) = happyShift action_163
action_178 (4) = happyGoto action_141
action_178 (5) = happyGoto action_142
action_178 (6) = happyGoto action_143
action_178 (7) = happyGoto action_144
action_178 (8) = happyGoto action_145
action_178 (49) = happyGoto action_147
action_178 (52) = happyGoto action_148
action_178 (58) = happyGoto action_200
action_178 (59) = happyGoto action_153
action_178 _ = happyFail (happyExpListPerState 178)

action_179 (60) = happyShift action_191
action_179 (82) = happyShift action_156
action_179 (104) = happyShift action_160
action_179 (107) = happyShift action_161
action_179 (113) = happyShift action_2
action_179 (114) = happyShift action_162
action_179 (115) = happyShift action_9
action_179 (116) = happyShift action_34
action_179 (117) = happyShift action_163
action_179 (4) = happyGoto action_141
action_179 (5) = happyGoto action_142
action_179 (6) = happyGoto action_143
action_179 (7) = happyGoto action_144
action_179 (8) = happyGoto action_145
action_179 (49) = happyGoto action_147
action_179 (52) = happyGoto action_148
action_179 (57) = happyGoto action_199
action_179 (58) = happyGoto action_152
action_179 (59) = happyGoto action_153
action_179 _ = happyFail (happyExpListPerState 179)

action_180 (60) = happyShift action_191
action_180 (82) = happyShift action_156
action_180 (104) = happyShift action_160
action_180 (107) = happyShift action_161
action_180 (113) = happyShift action_2
action_180 (114) = happyShift action_162
action_180 (115) = happyShift action_9
action_180 (116) = happyShift action_34
action_180 (117) = happyShift action_163
action_180 (4) = happyGoto action_141
action_180 (5) = happyGoto action_142
action_180 (6) = happyGoto action_143
action_180 (7) = happyGoto action_144
action_180 (8) = happyGoto action_145
action_180 (49) = happyGoto action_147
action_180 (52) = happyGoto action_148
action_180 (57) = happyGoto action_198
action_180 (58) = happyGoto action_152
action_180 (59) = happyGoto action_153
action_180 _ = happyFail (happyExpListPerState 180)

action_181 (60) = happyShift action_191
action_181 (82) = happyShift action_156
action_181 (104) = happyShift action_160
action_181 (107) = happyShift action_161
action_181 (113) = happyShift action_2
action_181 (114) = happyShift action_162
action_181 (115) = happyShift action_9
action_181 (116) = happyShift action_34
action_181 (117) = happyShift action_163
action_181 (4) = happyGoto action_141
action_181 (5) = happyGoto action_142
action_181 (6) = happyGoto action_143
action_181 (7) = happyGoto action_144
action_181 (8) = happyGoto action_145
action_181 (49) = happyGoto action_147
action_181 (52) = happyGoto action_148
action_181 (56) = happyGoto action_197
action_181 (57) = happyGoto action_151
action_181 (58) = happyGoto action_152
action_181 (59) = happyGoto action_153
action_181 _ = happyFail (happyExpListPerState 181)

action_182 (60) = happyShift action_191
action_182 (82) = happyShift action_156
action_182 (104) = happyShift action_160
action_182 (107) = happyShift action_161
action_182 (113) = happyShift action_2
action_182 (114) = happyShift action_162
action_182 (115) = happyShift action_9
action_182 (116) = happyShift action_34
action_182 (117) = happyShift action_163
action_182 (4) = happyGoto action_141
action_182 (5) = happyGoto action_142
action_182 (6) = happyGoto action_143
action_182 (7) = happyGoto action_144
action_182 (8) = happyGoto action_145
action_182 (49) = happyGoto action_147
action_182 (52) = happyGoto action_148
action_182 (56) = happyGoto action_196
action_182 (57) = happyGoto action_151
action_182 (58) = happyGoto action_152
action_182 (59) = happyGoto action_153
action_182 _ = happyFail (happyExpListPerState 182)

action_183 (60) = happyShift action_191
action_183 (82) = happyShift action_156
action_183 (104) = happyShift action_160
action_183 (107) = happyShift action_161
action_183 (113) = happyShift action_2
action_183 (114) = happyShift action_162
action_183 (115) = happyShift action_9
action_183 (116) = happyShift action_34
action_183 (117) = happyShift action_163
action_183 (4) = happyGoto action_141
action_183 (5) = happyGoto action_142
action_183 (6) = happyGoto action_143
action_183 (7) = happyGoto action_144
action_183 (8) = happyGoto action_145
action_183 (49) = happyGoto action_147
action_183 (52) = happyGoto action_148
action_183 (56) = happyGoto action_195
action_183 (57) = happyGoto action_151
action_183 (58) = happyGoto action_152
action_183 (59) = happyGoto action_153
action_183 _ = happyFail (happyExpListPerState 183)

action_184 (60) = happyShift action_191
action_184 (82) = happyShift action_156
action_184 (104) = happyShift action_160
action_184 (107) = happyShift action_161
action_184 (113) = happyShift action_2
action_184 (114) = happyShift action_162
action_184 (115) = happyShift action_9
action_184 (116) = happyShift action_34
action_184 (117) = happyShift action_163
action_184 (4) = happyGoto action_141
action_184 (5) = happyGoto action_142
action_184 (6) = happyGoto action_143
action_184 (7) = happyGoto action_144
action_184 (8) = happyGoto action_145
action_184 (49) = happyGoto action_147
action_184 (52) = happyGoto action_148
action_184 (56) = happyGoto action_194
action_184 (57) = happyGoto action_151
action_184 (58) = happyGoto action_152
action_184 (59) = happyGoto action_153
action_184 _ = happyFail (happyExpListPerState 184)

action_185 (60) = happyShift action_191
action_185 (82) = happyShift action_156
action_185 (104) = happyShift action_160
action_185 (107) = happyShift action_161
action_185 (113) = happyShift action_2
action_185 (114) = happyShift action_162
action_185 (115) = happyShift action_9
action_185 (116) = happyShift action_34
action_185 (117) = happyShift action_163
action_185 (4) = happyGoto action_141
action_185 (5) = happyGoto action_142
action_185 (6) = happyGoto action_143
action_185 (7) = happyGoto action_144
action_185 (8) = happyGoto action_145
action_185 (49) = happyGoto action_147
action_185 (52) = happyGoto action_148
action_185 (56) = happyGoto action_193
action_185 (57) = happyGoto action_151
action_185 (58) = happyGoto action_152
action_185 (59) = happyGoto action_153
action_185 _ = happyFail (happyExpListPerState 185)

action_186 (60) = happyShift action_191
action_186 (82) = happyShift action_156
action_186 (104) = happyShift action_160
action_186 (107) = happyShift action_161
action_186 (113) = happyShift action_2
action_186 (114) = happyShift action_162
action_186 (115) = happyShift action_9
action_186 (116) = happyShift action_34
action_186 (117) = happyShift action_163
action_186 (4) = happyGoto action_141
action_186 (5) = happyGoto action_142
action_186 (6) = happyGoto action_143
action_186 (7) = happyGoto action_144
action_186 (8) = happyGoto action_145
action_186 (49) = happyGoto action_147
action_186 (52) = happyGoto action_148
action_186 (58) = happyGoto action_192
action_186 (59) = happyGoto action_153
action_186 _ = happyFail (happyExpListPerState 186)

action_187 (60) = happyShift action_191
action_187 (82) = happyShift action_156
action_187 (104) = happyShift action_160
action_187 (107) = happyShift action_161
action_187 (113) = happyShift action_2
action_187 (114) = happyShift action_162
action_187 (115) = happyShift action_9
action_187 (116) = happyShift action_34
action_187 (117) = happyShift action_163
action_187 (4) = happyGoto action_141
action_187 (5) = happyGoto action_142
action_187 (6) = happyGoto action_143
action_187 (7) = happyGoto action_144
action_187 (8) = happyGoto action_145
action_187 (49) = happyGoto action_188
action_187 (50) = happyGoto action_189
action_187 (59) = happyGoto action_190
action_187 _ = happyReduce_111

action_188 _ = happyReduce_108

action_189 _ = happyReduce_110

action_190 _ = happyReduce_107

action_191 (60) = happyShift action_154
action_191 (78) = happyShift action_155
action_191 (82) = happyShift action_156
action_191 (86) = happyShift action_157
action_191 (92) = happyShift action_158
action_191 (99) = happyShift action_159
action_191 (104) = happyShift action_160
action_191 (107) = happyShift action_161
action_191 (113) = happyShift action_2
action_191 (114) = happyShift action_162
action_191 (115) = happyShift action_9
action_191 (116) = happyShift action_34
action_191 (117) = happyShift action_163
action_191 (4) = happyGoto action_141
action_191 (5) = happyGoto action_142
action_191 (6) = happyGoto action_143
action_191 (7) = happyGoto action_144
action_191 (8) = happyGoto action_145
action_191 (44) = happyGoto action_175
action_191 (49) = happyGoto action_147
action_191 (52) = happyGoto action_148
action_191 (55) = happyGoto action_149
action_191 (56) = happyGoto action_150
action_191 (57) = happyGoto action_151
action_191 (58) = happyGoto action_152
action_191 (59) = happyGoto action_153
action_191 _ = happyFail (happyExpListPerState 191)

action_192 _ = happyReduce_129

action_193 (63) = happyShift action_179
action_193 (65) = happyShift action_180
action_193 _ = happyReduce_117

action_194 (63) = happyShift action_179
action_194 (65) = happyShift action_180
action_194 _ = happyReduce_121

action_195 (63) = happyShift action_179
action_195 (65) = happyShift action_180
action_195 _ = happyReduce_119

action_196 (63) = happyShift action_179
action_196 (65) = happyShift action_180
action_196 _ = happyReduce_120

action_197 (63) = happyShift action_179
action_197 (65) = happyShift action_180
action_197 _ = happyReduce_118

action_198 (62) = happyShift action_177
action_198 (67) = happyShift action_178
action_198 _ = happyReduce_124

action_199 (62) = happyShift action_177
action_199 (67) = happyShift action_178
action_199 _ = happyReduce_123

action_200 _ = happyReduce_127

action_201 _ = happyReduce_126

action_202 (60) = happyShift action_135
action_202 (68) = happyShift action_220
action_202 (116) = happyShift action_34
action_202 (7) = happyGoto action_131
action_202 (24) = happyGoto action_132
action_202 _ = happyFail (happyExpListPerState 202)

action_203 _ = happyReduce_134

action_204 _ = happyReduce_92

action_205 (60) = happyShift action_154
action_205 (78) = happyShift action_155
action_205 (82) = happyShift action_156
action_205 (86) = happyShift action_157
action_205 (92) = happyShift action_158
action_205 (99) = happyShift action_159
action_205 (104) = happyShift action_160
action_205 (107) = happyShift action_161
action_205 (113) = happyShift action_2
action_205 (114) = happyShift action_162
action_205 (115) = happyShift action_9
action_205 (116) = happyShift action_34
action_205 (117) = happyShift action_163
action_205 (4) = happyGoto action_141
action_205 (5) = happyGoto action_142
action_205 (6) = happyGoto action_143
action_205 (7) = happyGoto action_144
action_205 (8) = happyGoto action_145
action_205 (44) = happyGoto action_172
action_205 (49) = happyGoto action_147
action_205 (52) = happyGoto action_148
action_205 (53) = happyGoto action_173
action_205 (54) = happyGoto action_219
action_205 (55) = happyGoto action_149
action_205 (56) = happyGoto action_150
action_205 (57) = happyGoto action_151
action_205 (58) = happyGoto action_152
action_205 (59) = happyGoto action_153
action_205 _ = happyReduce_114

action_206 (112) = happyShift action_218
action_206 _ = happyFail (happyExpListPerState 206)

action_207 (69) = happyShift action_217
action_207 _ = happyReduce_95

action_208 (60) = happyShift action_154
action_208 (78) = happyShift action_155
action_208 (82) = happyShift action_156
action_208 (86) = happyShift action_157
action_208 (92) = happyShift action_158
action_208 (99) = happyShift action_159
action_208 (104) = happyShift action_160
action_208 (107) = happyShift action_161
action_208 (113) = happyShift action_2
action_208 (114) = happyShift action_162
action_208 (115) = happyShift action_9
action_208 (116) = happyShift action_34
action_208 (117) = happyShift action_163
action_208 (4) = happyGoto action_141
action_208 (5) = happyGoto action_142
action_208 (6) = happyGoto action_143
action_208 (7) = happyGoto action_144
action_208 (8) = happyGoto action_145
action_208 (44) = happyGoto action_216
action_208 (49) = happyGoto action_147
action_208 (52) = happyGoto action_148
action_208 (55) = happyGoto action_149
action_208 (56) = happyGoto action_150
action_208 (57) = happyGoto action_151
action_208 (58) = happyGoto action_152
action_208 (59) = happyGoto action_153
action_208 _ = happyFail (happyExpListPerState 208)

action_209 (116) = happyShift action_34
action_209 (7) = happyGoto action_215
action_209 _ = happyFail (happyExpListPerState 209)

action_210 (60) = happyShift action_154
action_210 (78) = happyShift action_155
action_210 (82) = happyShift action_156
action_210 (86) = happyShift action_157
action_210 (92) = happyShift action_158
action_210 (99) = happyShift action_159
action_210 (104) = happyShift action_160
action_210 (107) = happyShift action_161
action_210 (113) = happyShift action_2
action_210 (114) = happyShift action_162
action_210 (115) = happyShift action_9
action_210 (116) = happyShift action_34
action_210 (117) = happyShift action_163
action_210 (4) = happyGoto action_141
action_210 (5) = happyGoto action_142
action_210 (6) = happyGoto action_143
action_210 (7) = happyGoto action_144
action_210 (8) = happyGoto action_145
action_210 (44) = happyGoto action_214
action_210 (49) = happyGoto action_147
action_210 (52) = happyGoto action_148
action_210 (55) = happyGoto action_149
action_210 (56) = happyGoto action_150
action_210 (57) = happyGoto action_151
action_210 (58) = happyGoto action_152
action_210 (59) = happyGoto action_153
action_210 _ = happyFail (happyExpListPerState 210)

action_211 (111) = happyShift action_213
action_211 _ = happyFail (happyExpListPerState 211)

action_212 _ = happyReduce_41

action_213 (60) = happyShift action_154
action_213 (78) = happyShift action_155
action_213 (82) = happyShift action_156
action_213 (86) = happyShift action_157
action_213 (92) = happyShift action_158
action_213 (99) = happyShift action_159
action_213 (104) = happyShift action_160
action_213 (107) = happyShift action_161
action_213 (113) = happyShift action_2
action_213 (114) = happyShift action_162
action_213 (115) = happyShift action_9
action_213 (116) = happyShift action_34
action_213 (117) = happyShift action_163
action_213 (4) = happyGoto action_141
action_213 (5) = happyGoto action_142
action_213 (6) = happyGoto action_143
action_213 (7) = happyGoto action_144
action_213 (8) = happyGoto action_145
action_213 (44) = happyGoto action_225
action_213 (47) = happyGoto action_226
action_213 (48) = happyGoto action_227
action_213 (49) = happyGoto action_147
action_213 (52) = happyGoto action_148
action_213 (55) = happyGoto action_149
action_213 (56) = happyGoto action_150
action_213 (57) = happyGoto action_151
action_213 (58) = happyGoto action_152
action_213 (59) = happyGoto action_153
action_213 _ = happyReduce_98

action_214 (88) = happyShift action_224
action_214 _ = happyFail (happyExpListPerState 214)

action_215 _ = happyReduce_97

action_216 _ = happyReduce_88

action_217 (60) = happyShift action_154
action_217 (78) = happyShift action_155
action_217 (82) = happyShift action_156
action_217 (86) = happyShift action_157
action_217 (92) = happyShift action_158
action_217 (99) = happyShift action_159
action_217 (104) = happyShift action_160
action_217 (107) = happyShift action_161
action_217 (113) = happyShift action_2
action_217 (114) = happyShift action_162
action_217 (115) = happyShift action_9
action_217 (116) = happyShift action_34
action_217 (117) = happyShift action_163
action_217 (4) = happyGoto action_141
action_217 (5) = happyGoto action_142
action_217 (6) = happyGoto action_143
action_217 (7) = happyGoto action_144
action_217 (8) = happyGoto action_145
action_217 (44) = happyGoto action_169
action_217 (45) = happyGoto action_223
action_217 (46) = happyGoto action_207
action_217 (49) = happyGoto action_147
action_217 (52) = happyGoto action_148
action_217 (55) = happyGoto action_149
action_217 (56) = happyGoto action_150
action_217 (57) = happyGoto action_151
action_217 (58) = happyGoto action_152
action_217 (59) = happyGoto action_153
action_217 _ = happyReduce_94

action_218 (96) = happyShift action_222
action_218 _ = happyFail (happyExpListPerState 218)

action_219 _ = happyReduce_116

action_220 (60) = happyShift action_62
action_220 (115) = happyShift action_9
action_220 (116) = happyShift action_34
action_220 (6) = happyGoto action_58
action_220 (7) = happyGoto action_59
action_220 (15) = happyGoto action_221
action_220 (16) = happyGoto action_61
action_220 _ = happyFail (happyExpListPerState 220)

action_221 (74) = happyShift action_233
action_221 _ = happyFail (happyExpListPerState 221)

action_222 (60) = happyShift action_154
action_222 (78) = happyShift action_155
action_222 (82) = happyShift action_156
action_222 (86) = happyShift action_157
action_222 (92) = happyShift action_158
action_222 (99) = happyShift action_159
action_222 (104) = happyShift action_160
action_222 (107) = happyShift action_161
action_222 (113) = happyShift action_2
action_222 (114) = happyShift action_162
action_222 (115) = happyShift action_9
action_222 (116) = happyShift action_34
action_222 (117) = happyShift action_163
action_222 (4) = happyGoto action_141
action_222 (5) = happyGoto action_142
action_222 (6) = happyGoto action_143
action_222 (7) = happyGoto action_144
action_222 (8) = happyGoto action_145
action_222 (44) = happyGoto action_232
action_222 (49) = happyGoto action_147
action_222 (52) = happyGoto action_148
action_222 (55) = happyGoto action_149
action_222 (56) = happyGoto action_150
action_222 (57) = happyGoto action_151
action_222 (58) = happyGoto action_152
action_222 (59) = happyGoto action_153
action_222 _ = happyFail (happyExpListPerState 222)

action_223 _ = happyReduce_96

action_224 (60) = happyShift action_154
action_224 (78) = happyShift action_155
action_224 (82) = happyShift action_156
action_224 (86) = happyShift action_157
action_224 (92) = happyShift action_158
action_224 (99) = happyShift action_159
action_224 (104) = happyShift action_160
action_224 (107) = happyShift action_161
action_224 (113) = happyShift action_2
action_224 (114) = happyShift action_162
action_224 (115) = happyShift action_9
action_224 (116) = happyShift action_34
action_224 (117) = happyShift action_163
action_224 (4) = happyGoto action_141
action_224 (5) = happyGoto action_142
action_224 (6) = happyGoto action_143
action_224 (7) = happyGoto action_144
action_224 (8) = happyGoto action_145
action_224 (44) = happyGoto action_231
action_224 (49) = happyGoto action_147
action_224 (52) = happyGoto action_148
action_224 (55) = happyGoto action_149
action_224 (56) = happyGoto action_150
action_224 (57) = happyGoto action_151
action_224 (58) = happyGoto action_152
action_224 (59) = happyGoto action_153
action_224 _ = happyFail (happyExpListPerState 224)

action_225 (66) = happyShift action_230
action_225 _ = happyFail (happyExpListPerState 225)

action_226 (112) = happyShift action_229
action_226 _ = happyFail (happyExpListPerState 226)

action_227 (69) = happyShift action_228
action_227 _ = happyReduce_99

action_228 (60) = happyShift action_154
action_228 (78) = happyShift action_155
action_228 (82) = happyShift action_156
action_228 (86) = happyShift action_157
action_228 (92) = happyShift action_158
action_228 (99) = happyShift action_159
action_228 (104) = happyShift action_160
action_228 (107) = happyShift action_161
action_228 (113) = happyShift action_2
action_228 (114) = happyShift action_162
action_228 (115) = happyShift action_9
action_228 (116) = happyShift action_34
action_228 (117) = happyShift action_163
action_228 (4) = happyGoto action_141
action_228 (5) = happyGoto action_142
action_228 (6) = happyGoto action_143
action_228 (7) = happyGoto action_144
action_228 (8) = happyGoto action_145
action_228 (44) = happyGoto action_225
action_228 (47) = happyGoto action_236
action_228 (48) = happyGoto action_227
action_228 (49) = happyGoto action_147
action_228 (52) = happyGoto action_148
action_228 (55) = happyGoto action_149
action_228 (56) = happyGoto action_150
action_228 (57) = happyGoto action_151
action_228 (58) = happyGoto action_152
action_228 (59) = happyGoto action_153
action_228 _ = happyReduce_98

action_229 _ = happyReduce_89

action_230 (60) = happyShift action_154
action_230 (78) = happyShift action_155
action_230 (82) = happyShift action_156
action_230 (86) = happyShift action_157
action_230 (92) = happyShift action_158
action_230 (99) = happyShift action_159
action_230 (104) = happyShift action_160
action_230 (107) = happyShift action_161
action_230 (113) = happyShift action_2
action_230 (114) = happyShift action_162
action_230 (115) = happyShift action_9
action_230 (116) = happyShift action_34
action_230 (117) = happyShift action_163
action_230 (4) = happyGoto action_141
action_230 (5) = happyGoto action_142
action_230 (6) = happyGoto action_143
action_230 (7) = happyGoto action_144
action_230 (8) = happyGoto action_145
action_230 (44) = happyGoto action_235
action_230 (49) = happyGoto action_147
action_230 (52) = happyGoto action_148
action_230 (55) = happyGoto action_149
action_230 (56) = happyGoto action_150
action_230 (57) = happyGoto action_151
action_230 (58) = happyGoto action_152
action_230 (59) = happyGoto action_153
action_230 _ = happyFail (happyExpListPerState 230)

action_231 _ = happyReduce_90

action_232 _ = happyReduce_87

action_233 (60) = happyShift action_154
action_233 (78) = happyShift action_155
action_233 (82) = happyShift action_156
action_233 (86) = happyShift action_157
action_233 (92) = happyShift action_158
action_233 (99) = happyShift action_159
action_233 (104) = happyShift action_160
action_233 (107) = happyShift action_161
action_233 (113) = happyShift action_2
action_233 (114) = happyShift action_162
action_233 (115) = happyShift action_9
action_233 (116) = happyShift action_34
action_233 (117) = happyShift action_163
action_233 (4) = happyGoto action_141
action_233 (5) = happyGoto action_142
action_233 (6) = happyGoto action_143
action_233 (7) = happyGoto action_144
action_233 (8) = happyGoto action_145
action_233 (44) = happyGoto action_234
action_233 (49) = happyGoto action_147
action_233 (52) = happyGoto action_148
action_233 (55) = happyGoto action_149
action_233 (56) = happyGoto action_150
action_233 (57) = happyGoto action_151
action_233 (58) = happyGoto action_152
action_233 (59) = happyGoto action_153
action_233 _ = happyFail (happyExpListPerState 233)

action_234 (61) = happyShift action_237
action_234 _ = happyFail (happyExpListPerState 234)

action_235 _ = happyReduce_101

action_236 _ = happyReduce_100

action_237 _ = happyReduce_91

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
happyReduction_8 (HappyAbsSyn27  happy_var_2)
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

happyReduce_12 = happySpecReduce_0  13 happyReduction_12
happyReduction_12  =  HappyAbsSyn13
		 ([]
	)

happyReduce_13 = happySpecReduce_2  13 happyReduction_13
happyReduction_13 (HappyAbsSyn14  happy_var_2)
	(HappyAbsSyn13  happy_var_1)
	 =  HappyAbsSyn13
		 (flip (:) happy_var_1 happy_var_2
	)
happyReduction_13 _ _  = notHappyAtAll 

happyReduce_14 = happySpecReduce_1  14 happyReduction_14
happyReduction_14 (HappyAbsSyn7  happy_var_1)
	 =  HappyAbsSyn14
		 (AbsVarg.InferredTypeParam happy_var_1
	)
happyReduction_14 _  = notHappyAtAll 

happyReduce_15 = happySpecReduce_1  14 happyReduction_15
happyReduction_15 (HappyAbsSyn6  happy_var_1)
	 =  HappyAbsSyn14
		 (AbsVarg.ConcreteTypeParam happy_var_1
	)
happyReduction_15 _  = notHappyAtAll 

happyReduce_16 = happySpecReduce_1  14 happyReduction_16
happyReduction_16 _
	 =  HappyAbsSyn14
		 (AbsVarg.WildcardTypeParam
	)

happyReduce_17 = happySpecReduce_3  14 happyReduction_17
happyReduction_17 _
	(HappyAbsSyn15  happy_var_2)
	_
	 =  HappyAbsSyn14
		 (AbsVarg.AnotherClassTypeParam happy_var_2
	)
happyReduction_17 _ _ _  = notHappyAtAll 

happyReduce_18 = happyReduce 5 14 happyReduction_18
happyReduction_18 (_ `HappyStk`
	(HappyAbsSyn17  happy_var_4) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn7  happy_var_2) `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn14
		 (AbsVarg.SuperConstrainedTypeParam happy_var_2 happy_var_4
	) `HappyStk` happyRest

happyReduce_19 = happyReduce 5 14 happyReduction_19
happyReduction_19 (_ `HappyStk`
	(HappyAbsSyn17  happy_var_4) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn14
		 (AbsVarg.AnySuperConstrainedTypeParam happy_var_4
	) `HappyStk` happyRest

happyReduce_20 = happyReduce 5 14 happyReduction_20
happyReduction_20 (_ `HappyStk`
	(HappyAbsSyn17  happy_var_4) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn7  happy_var_2) `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn14
		 (AbsVarg.DerivingConstrainedTypeParam happy_var_2 happy_var_4
	) `HappyStk` happyRest

happyReduce_21 = happyReduce 5 14 happyReduction_21
happyReduction_21 (_ `HappyStk`
	(HappyAbsSyn17  happy_var_4) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn14
		 (AbsVarg.AnyDerivingConstrainedTypeParam happy_var_4
	) `HappyStk` happyRest

happyReduce_22 = happySpecReduce_2  15 happyReduction_22
happyReduction_22 (HappyAbsSyn13  happy_var_2)
	(HappyAbsSyn6  happy_var_1)
	 =  HappyAbsSyn15
		 (AbsVarg.ConcreteType happy_var_1 (reverse happy_var_2)
	)
happyReduction_22 _ _  = notHappyAtAll 

happyReduce_23 = happySpecReduce_2  15 happyReduction_23
happyReduction_23 (HappyAbsSyn13  happy_var_2)
	(HappyAbsSyn7  happy_var_1)
	 =  HappyAbsSyn15
		 (AbsVarg.InferredType happy_var_1 (reverse happy_var_2)
	)
happyReduction_23 _ _  = notHappyAtAll 

happyReduce_24 = happySpecReduce_1  15 happyReduction_24
happyReduction_24 (HappyAbsSyn15  happy_var_1)
	 =  HappyAbsSyn15
		 (happy_var_1
	)
happyReduction_24 _  = notHappyAtAll 

happyReduce_25 = happySpecReduce_3  16 happyReduction_25
happyReduction_25 _
	(HappyAbsSyn15  happy_var_2)
	_
	 =  HappyAbsSyn15
		 (happy_var_2
	)
happyReduction_25 _ _ _  = notHappyAtAll 

happyReduce_26 = happySpecReduce_1  17 happyReduction_26
happyReduction_26 (HappyAbsSyn15  happy_var_1)
	 =  HappyAbsSyn17
		 ((:[]) happy_var_1
	)
happyReduction_26 _  = notHappyAtAll 

happyReduce_27 = happySpecReduce_3  17 happyReduction_27
happyReduction_27 (HappyAbsSyn17  happy_var_3)
	_
	(HappyAbsSyn15  happy_var_1)
	 =  HappyAbsSyn17
		 ((:) happy_var_1 happy_var_3
	)
happyReduction_27 _ _ _  = notHappyAtAll 

happyReduce_28 = happySpecReduce_3  18 happyReduction_28
happyReduction_28 _
	(HappyAbsSyn19  happy_var_2)
	_
	 =  HappyAbsSyn18
		 (AbsVarg.ConcreteTypeFreeType happy_var_2
	)
happyReduction_28 _ _ _  = notHappyAtAll 

happyReduce_29 = happySpecReduce_1  18 happyReduction_29
happyReduction_29 (HappyAbsSyn7  happy_var_1)
	 =  HappyAbsSyn18
		 (AbsVarg.TemplateFreeType happy_var_1
	)
happyReduction_29 _  = notHappyAtAll 

happyReduce_30 = happySpecReduce_1  18 happyReduction_30
happyReduction_30 (HappyAbsSyn6  happy_var_1)
	 =  HappyAbsSyn18
		 (AbsVarg.ConcreteFreeType happy_var_1
	)
happyReduction_30 _  = notHappyAtAll 

happyReduce_31 = happySpecReduce_2  19 happyReduction_31
happyReduction_31 (HappyAbsSyn22  happy_var_2)
	(HappyAbsSyn6  happy_var_1)
	 =  HappyAbsSyn19
		 (AbsVarg.FreeType happy_var_1 (reverse happy_var_2)
	)
happyReduction_31 _ _  = notHappyAtAll 

happyReduce_32 = happySpecReduce_2  19 happyReduction_32
happyReduction_32 (HappyAbsSyn22  happy_var_2)
	(HappyAbsSyn7  happy_var_1)
	 =  HappyAbsSyn19
		 (AbsVarg.InferredFreeType happy_var_1 (reverse happy_var_2)
	)
happyReduction_32 _ _  = notHappyAtAll 

happyReduce_33 = happySpecReduce_1  19 happyReduction_33
happyReduction_33 (HappyAbsSyn19  happy_var_1)
	 =  HappyAbsSyn19
		 (happy_var_1
	)
happyReduction_33 _  = notHappyAtAll 

happyReduce_34 = happySpecReduce_3  20 happyReduction_34
happyReduction_34 _
	(HappyAbsSyn19  happy_var_2)
	_
	 =  HappyAbsSyn19
		 (happy_var_2
	)
happyReduction_34 _ _ _  = notHappyAtAll 

happyReduce_35 = happySpecReduce_1  21 happyReduction_35
happyReduction_35 (HappyAbsSyn19  happy_var_1)
	 =  HappyAbsSyn21
		 ((:[]) happy_var_1
	)
happyReduction_35 _  = notHappyAtAll 

happyReduce_36 = happySpecReduce_3  21 happyReduction_36
happyReduction_36 (HappyAbsSyn21  happy_var_3)
	_
	(HappyAbsSyn19  happy_var_1)
	 =  HappyAbsSyn21
		 ((:) happy_var_1 happy_var_3
	)
happyReduction_36 _ _ _  = notHappyAtAll 

happyReduce_37 = happySpecReduce_0  22 happyReduction_37
happyReduction_37  =  HappyAbsSyn22
		 ([]
	)

happyReduce_38 = happySpecReduce_2  22 happyReduction_38
happyReduction_38 (HappyAbsSyn18  happy_var_2)
	(HappyAbsSyn22  happy_var_1)
	 =  HappyAbsSyn22
		 (flip (:) happy_var_1 happy_var_2
	)
happyReduction_38 _ _  = notHappyAtAll 

happyReduce_39 = happySpecReduce_0  23 happyReduction_39
happyReduction_39  =  HappyAbsSyn23
		 ([]
	)

happyReduce_40 = happySpecReduce_2  23 happyReduction_40
happyReduction_40 (HappyAbsSyn24  happy_var_2)
	(HappyAbsSyn23  happy_var_1)
	 =  HappyAbsSyn23
		 (flip (:) happy_var_1 happy_var_2
	)
happyReduction_40 _ _  = notHappyAtAll 

happyReduce_41 = happyReduce 5 24 happyReduction_41
happyReduction_41 (_ `HappyStk`
	(HappyAbsSyn15  happy_var_4) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn7  happy_var_2) `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn24
		 (AbsVarg.ArgumentDefinition happy_var_2 happy_var_4
	) `HappyStk` happyRest

happyReduce_42 = happySpecReduce_1  24 happyReduction_42
happyReduction_42 (HappyAbsSyn7  happy_var_1)
	 =  HappyAbsSyn24
		 (AbsVarg.InferredArgumentDef happy_var_1
	)
happyReduction_42 _  = notHappyAtAll 

happyReduce_43 = happySpecReduce_1  25 happyReduction_43
happyReduction_43 (HappyAbsSyn19  happy_var_1)
	 =  HappyAbsSyn25
		 (AbsVarg.Superclass happy_var_1
	)
happyReduction_43 _  = notHappyAtAll 

happyReduce_44 = happySpecReduce_1  26 happyReduction_44
happyReduction_44 (HappyAbsSyn25  happy_var_1)
	 =  HappyAbsSyn26
		 ((:[]) happy_var_1
	)
happyReduction_44 _  = notHappyAtAll 

happyReduce_45 = happySpecReduce_3  26 happyReduction_45
happyReduction_45 (HappyAbsSyn26  happy_var_3)
	_
	(HappyAbsSyn25  happy_var_1)
	 =  HappyAbsSyn26
		 ((:) happy_var_1 happy_var_3
	)
happyReduction_45 _ _ _  = notHappyAtAll 

happyReduce_46 = happyReduce 7 27 happyReduction_46
happyReduction_46 (_ `HappyStk`
	(HappyAbsSyn42  happy_var_6) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn6  happy_var_3) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn30  happy_var_1) `HappyStk`
	happyRest)
	 = HappyAbsSyn27
		 (AbsVarg.StructDefinition (reverse happy_var_1) happy_var_3 happy_var_6
	) `HappyStk` happyRest

happyReduce_47 = happyReduce 9 27 happyReduction_47
happyReduction_47 (_ `HappyStk`
	(HappyAbsSyn32  happy_var_8) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn28  happy_var_5) `HappyStk`
	(HappyAbsSyn29  happy_var_4) `HappyStk`
	(HappyAbsSyn6  happy_var_3) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn30  happy_var_1) `HappyStk`
	happyRest)
	 = HappyAbsSyn27
		 (AbsVarg.ClassDefinition (reverse happy_var_1) happy_var_3 happy_var_4 happy_var_5 happy_var_8
	) `HappyStk` happyRest

happyReduce_48 = happyReduce 10 27 happyReduction_48
happyReduction_48 (_ `HappyStk`
	(HappyAbsSyn32  happy_var_9) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn28  happy_var_6) `HappyStk`
	(HappyAbsSyn29  happy_var_5) `HappyStk`
	(HappyAbsSyn13  happy_var_4) `HappyStk`
	(HappyAbsSyn6  happy_var_3) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn30  happy_var_1) `HappyStk`
	happyRest)
	 = HappyAbsSyn27
		 (AbsVarg.TemplateDefinition (reverse happy_var_1) happy_var_3 (reverse happy_var_4) happy_var_5 happy_var_6 happy_var_9
	) `HappyStk` happyRest

happyReduce_49 = happySpecReduce_2  28 happyReduction_49
happyReduction_49 (HappyAbsSyn26  happy_var_2)
	_
	 =  HappyAbsSyn28
		 (AbsVarg.Implementing happy_var_2
	)
happyReduction_49 _ _  = notHappyAtAll 

happyReduce_50 = happySpecReduce_0  28 happyReduction_50
happyReduction_50  =  HappyAbsSyn28
		 (AbsVarg.NotImplementing
	)

happyReduce_51 = happySpecReduce_2  29 happyReduction_51
happyReduction_51 (HappyAbsSyn25  happy_var_2)
	_
	 =  HappyAbsSyn29
		 (AbsVarg.Deriving happy_var_2
	)
happyReduction_51 _ _  = notHappyAtAll 

happyReduce_52 = happySpecReduce_0  29 happyReduction_52
happyReduction_52  =  HappyAbsSyn29
		 (AbsVarg.NotDeriving
	)

happyReduce_53 = happySpecReduce_0  30 happyReduction_53
happyReduction_53  =  HappyAbsSyn30
		 ([]
	)

happyReduce_54 = happySpecReduce_2  30 happyReduction_54
happyReduction_54 (HappyAbsSyn31  happy_var_2)
	(HappyAbsSyn30  happy_var_1)
	 =  HappyAbsSyn30
		 (flip (:) happy_var_1 happy_var_2
	)
happyReduction_54 _ _  = notHappyAtAll 

happyReduce_55 = happySpecReduce_1  31 happyReduction_55
happyReduction_55 _
	 =  HappyAbsSyn31
		 (AbsVarg.ClassModifier_module
	)

happyReduce_56 = happySpecReduce_1  31 happyReduction_56
happyReduction_56 _
	 =  HappyAbsSyn31
		 (AbsVarg.ClassModifier_interface
	)

happyReduce_57 = happySpecReduce_1  31 happyReduction_57
happyReduction_57 _
	 =  HappyAbsSyn31
		 (AbsVarg.ClassModifier_sealed
	)

happyReduce_58 = happySpecReduce_2  32 happyReduction_58
happyReduction_58 (HappyAbsSyn38  happy_var_2)
	(HappyAbsSyn34  happy_var_1)
	 =  HappyAbsSyn32
		 (AbsVarg.ClassContent happy_var_1 happy_var_2
	)
happyReduction_58 _ _  = notHappyAtAll 

happyReduce_59 = happySpecReduce_1  33 happyReduction_59
happyReduction_59 (HappyAbsSyn6  happy_var_1)
	 =  HappyAbsSyn33
		 (AbsVarg.EmptyMemberDefinition happy_var_1
	)
happyReduction_59 _  = notHappyAtAll 

happyReduce_60 = happyReduce 5 33 happyReduction_60
happyReduction_60 (_ `HappyStk`
	(HappyAbsSyn42  happy_var_4) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn6  happy_var_1) `HappyStk`
	happyRest)
	 = HappyAbsSyn33
		 (AbsVarg.MemberDefinition happy_var_1 happy_var_4
	) `HappyStk` happyRest

happyReduce_61 = happySpecReduce_0  34 happyReduction_61
happyReduction_61  =  HappyAbsSyn34
		 ([]
	)

happyReduce_62 = happySpecReduce_1  34 happyReduction_62
happyReduction_62 (HappyAbsSyn33  happy_var_1)
	 =  HappyAbsSyn34
		 ((:[]) happy_var_1
	)
happyReduction_62 _  = notHappyAtAll 

happyReduce_63 = happySpecReduce_3  34 happyReduction_63
happyReduction_63 (HappyAbsSyn34  happy_var_3)
	_
	(HappyAbsSyn33  happy_var_1)
	 =  HappyAbsSyn34
		 ((:) happy_var_1 happy_var_3
	)
happyReduction_63 _ _ _  = notHappyAtAll 

happyReduce_64 = happyReduce 7 35 happyReduction_64
happyReduction_64 ((HappyAbsSyn44  happy_var_7) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn36  happy_var_5) `HappyStk`
	(HappyAbsSyn23  happy_var_4) `HappyStk`
	(HappyAbsSyn7  happy_var_3) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn39  happy_var_1) `HappyStk`
	happyRest)
	 = HappyAbsSyn35
		 (AbsVarg.MemberFunctionDefinition (reverse happy_var_1) happy_var_3 (reverse happy_var_4) happy_var_5 happy_var_7
	) `HappyStk` happyRest

happyReduce_65 = happyReduce 5 35 happyReduction_65
happyReduction_65 ((HappyAbsSyn37  happy_var_5) `HappyStk`
	(HappyAbsSyn23  happy_var_4) `HappyStk`
	(HappyAbsSyn7  happy_var_3) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn39  happy_var_1) `HappyStk`
	happyRest)
	 = HappyAbsSyn35
		 (AbsVarg.AbstractFunctionDefinition (reverse happy_var_1) happy_var_3 (reverse happy_var_4) happy_var_5
	) `HappyStk` happyRest

happyReduce_66 = happySpecReduce_2  36 happyReduction_66
happyReduction_66 (HappyAbsSyn19  happy_var_2)
	_
	 =  HappyAbsSyn36
		 (AbsVarg.ReturnType happy_var_2
	)
happyReduction_66 _ _  = notHappyAtAll 

happyReduce_67 = happySpecReduce_0  36 happyReduction_67
happyReduction_67  =  HappyAbsSyn36
		 (AbsVarg.InferredReturnType
	)

happyReduce_68 = happySpecReduce_3  37 happyReduction_68
happyReduction_68 (HappyAbsSyn19  happy_var_3)
	_
	_
	 =  HappyAbsSyn37
		 (AbsVarg.AbsReturnType happy_var_3
	)
happyReduction_68 _ _ _  = notHappyAtAll 

happyReduce_69 = happySpecReduce_0  37 happyReduction_69
happyReduction_69  =  HappyAbsSyn37
		 (AbsVarg.AbsInferredReturnType
	)

happyReduce_70 = happySpecReduce_0  38 happyReduction_70
happyReduction_70  =  HappyAbsSyn38
		 ([]
	)

happyReduce_71 = happySpecReduce_1  38 happyReduction_71
happyReduction_71 (HappyAbsSyn35  happy_var_1)
	 =  HappyAbsSyn38
		 ((:[]) happy_var_1
	)
happyReduction_71 _  = notHappyAtAll 

happyReduce_72 = happySpecReduce_3  38 happyReduction_72
happyReduction_72 (HappyAbsSyn38  happy_var_3)
	_
	(HappyAbsSyn35  happy_var_1)
	 =  HappyAbsSyn38
		 ((:) happy_var_1 happy_var_3
	)
happyReduction_72 _ _ _  = notHappyAtAll 

happyReduce_73 = happySpecReduce_0  39 happyReduction_73
happyReduction_73  =  HappyAbsSyn39
		 ([]
	)

happyReduce_74 = happySpecReduce_2  39 happyReduction_74
happyReduction_74 (HappyAbsSyn40  happy_var_2)
	(HappyAbsSyn39  happy_var_1)
	 =  HappyAbsSyn39
		 (flip (:) happy_var_1 happy_var_2
	)
happyReduction_74 _ _  = notHappyAtAll 

happyReduce_75 = happySpecReduce_1  40 happyReduction_75
happyReduction_75 _
	 =  HappyAbsSyn40
		 (AbsVarg.FunctionModifier_static
	)

happyReduce_76 = happySpecReduce_1  40 happyReduction_76
happyReduction_76 _
	 =  HappyAbsSyn40
		 (AbsVarg.FunctionModifier_internal
	)

happyReduce_77 = happySpecReduce_1  40 happyReduction_77
happyReduction_77 _
	 =  HappyAbsSyn40
		 (AbsVarg.FunctionModifier_implement
	)

happyReduce_78 = happySpecReduce_1  40 happyReduction_78
happyReduction_78 _
	 =  HappyAbsSyn40
		 (AbsVarg.FunctionModifier_final
	)

happyReduce_79 = happySpecReduce_1  40 happyReduction_79
happyReduction_79 _
	 =  HappyAbsSyn40
		 (AbsVarg.FunctionModifier_unique
	)

happyReduce_80 = happyReduce 4 41 happyReduction_80
happyReduction_80 ((HappyAbsSyn19  happy_var_4) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn7  happy_var_2) `HappyStk`
	(HappyAbsSyn43  happy_var_1) `HappyStk`
	happyRest)
	 = HappyAbsSyn41
		 (AbsVarg.ModifiedClassField happy_var_1 happy_var_2 happy_var_4
	) `HappyStk` happyRest

happyReduce_81 = happySpecReduce_3  41 happyReduction_81
happyReduction_81 (HappyAbsSyn19  happy_var_3)
	_
	(HappyAbsSyn7  happy_var_1)
	 =  HappyAbsSyn41
		 (AbsVarg.NormalClassField happy_var_1 happy_var_3
	)
happyReduction_81 _ _ _  = notHappyAtAll 

happyReduce_82 = happySpecReduce_0  42 happyReduction_82
happyReduction_82  =  HappyAbsSyn42
		 ([]
	)

happyReduce_83 = happySpecReduce_1  42 happyReduction_83
happyReduction_83 (HappyAbsSyn41  happy_var_1)
	 =  HappyAbsSyn42
		 ((:[]) happy_var_1
	)
happyReduction_83 _  = notHappyAtAll 

happyReduce_84 = happySpecReduce_3  42 happyReduction_84
happyReduction_84 (HappyAbsSyn42  happy_var_3)
	_
	(HappyAbsSyn41  happy_var_1)
	 =  HappyAbsSyn42
		 ((:) happy_var_1 happy_var_3
	)
happyReduction_84 _ _ _  = notHappyAtAll 

happyReduce_85 = happySpecReduce_1  43 happyReduction_85
happyReduction_85 _
	 =  HappyAbsSyn43
		 (AbsVarg.FieldModifier_internal
	)

happyReduce_86 = happySpecReduce_1  43 happyReduction_86
happyReduction_86 _
	 =  HappyAbsSyn43
		 (AbsVarg.FieldModifier_unique
	)

happyReduce_87 = happyReduce 6 44 happyReduction_87
happyReduction_87 ((HappyAbsSyn44  happy_var_6) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn45  happy_var_3) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn44
		 (AbsVarg.EDefinitionsList happy_var_3 happy_var_6
	) `HappyStk` happyRest

happyReduce_88 = happyReduce 4 44 happyReduction_88
happyReduction_88 ((HappyAbsSyn44  happy_var_4) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn46  happy_var_2) `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn44
		 (AbsVarg.EDefinition happy_var_2 happy_var_4
	) `HappyStk` happyRest

happyReduce_89 = happyReduce 6 44 happyReduction_89
happyReduction_89 (_ `HappyStk`
	(HappyAbsSyn47  happy_var_5) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn44  happy_var_2) `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn44
		 (AbsVarg.EMatch happy_var_2 happy_var_5
	) `HappyStk` happyRest

happyReduce_90 = happyReduce 6 44 happyReduction_90
happyReduction_90 ((HappyAbsSyn44  happy_var_6) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn44  happy_var_4) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn44  happy_var_2) `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn44
		 (AbsVarg.EIfThenElse happy_var_2 happy_var_4 happy_var_6
	) `HappyStk` happyRest

happyReduce_91 = happyReduce 8 44 happyReduction_91
happyReduction_91 (_ `HappyStk`
	(HappyAbsSyn44  happy_var_7) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn15  happy_var_5) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn23  happy_var_3) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn44
		 (AbsVarg.ELambda (reverse happy_var_3) happy_var_5 happy_var_7
	) `HappyStk` happyRest

happyReduce_92 = happySpecReduce_3  44 happyReduction_92
happyReduction_92 _
	(HappyAbsSyn54  happy_var_2)
	_
	 =  HappyAbsSyn44
		 (AbsVarg.EList happy_var_2
	)
happyReduction_92 _ _ _  = notHappyAtAll 

happyReduce_93 = happySpecReduce_1  44 happyReduction_93
happyReduction_93 (HappyAbsSyn44  happy_var_1)
	 =  HappyAbsSyn44
		 (happy_var_1
	)
happyReduction_93 _  = notHappyAtAll 

happyReduce_94 = happySpecReduce_0  45 happyReduction_94
happyReduction_94  =  HappyAbsSyn45
		 ([]
	)

happyReduce_95 = happySpecReduce_1  45 happyReduction_95
happyReduction_95 (HappyAbsSyn46  happy_var_1)
	 =  HappyAbsSyn45
		 ((:[]) happy_var_1
	)
happyReduction_95 _  = notHappyAtAll 

happyReduce_96 = happySpecReduce_3  45 happyReduction_96
happyReduction_96 (HappyAbsSyn45  happy_var_3)
	_
	(HappyAbsSyn46  happy_var_1)
	 =  HappyAbsSyn45
		 ((:) happy_var_1 happy_var_3
	)
happyReduction_96 _ _ _  = notHappyAtAll 

happyReduce_97 = happySpecReduce_3  46 happyReduction_97
happyReduction_97 (HappyAbsSyn7  happy_var_3)
	_
	(HappyAbsSyn44  happy_var_1)
	 =  HappyAbsSyn46
		 (AbsVarg.IDefinition happy_var_1 happy_var_3
	)
happyReduction_97 _ _ _  = notHappyAtAll 

happyReduce_98 = happySpecReduce_0  47 happyReduction_98
happyReduction_98  =  HappyAbsSyn47
		 ([]
	)

happyReduce_99 = happySpecReduce_1  47 happyReduction_99
happyReduction_99 (HappyAbsSyn48  happy_var_1)
	 =  HappyAbsSyn47
		 ((:[]) happy_var_1
	)
happyReduction_99 _  = notHappyAtAll 

happyReduce_100 = happySpecReduce_3  47 happyReduction_100
happyReduction_100 (HappyAbsSyn47  happy_var_3)
	_
	(HappyAbsSyn48  happy_var_1)
	 =  HappyAbsSyn47
		 ((:) happy_var_1 happy_var_3
	)
happyReduction_100 _ _ _  = notHappyAtAll 

happyReduce_101 = happySpecReduce_3  48 happyReduction_101
happyReduction_101 (HappyAbsSyn44  happy_var_3)
	_
	(HappyAbsSyn44  happy_var_1)
	 =  HappyAbsSyn48
		 (AbsVarg.IMatchClause happy_var_1 happy_var_3
	)
happyReduction_101 _ _ _  = notHappyAtAll 

happyReduce_102 = happySpecReduce_1  49 happyReduction_102
happyReduction_102 _
	 =  HappyAbsSyn49
		 (AbsVarg.ThisFunctor
	)

happyReduce_103 = happySpecReduce_1  49 happyReduction_103
happyReduction_103 _
	 =  HappyAbsSyn49
		 (AbsVarg.SuperFunctor
	)

happyReduce_104 = happySpecReduce_1  49 happyReduction_104
happyReduction_104 (HappyAbsSyn6  happy_var_1)
	 =  HappyAbsSyn49
		 (AbsVarg.TypeFunctor happy_var_1
	)
happyReduction_104 _  = notHappyAtAll 

happyReduce_105 = happySpecReduce_1  49 happyReduction_105
happyReduction_105 (HappyAbsSyn7  happy_var_1)
	 =  HappyAbsSyn49
		 (AbsVarg.InstanceFunctor happy_var_1
	)
happyReduction_105 _  = notHappyAtAll 

happyReduce_106 = happySpecReduce_1  49 happyReduction_106
happyReduction_106 (HappyAbsSyn8  happy_var_1)
	 =  HappyAbsSyn49
		 (AbsVarg.MemberFunctor happy_var_1
	)
happyReduction_106 _  = notHappyAtAll 

happyReduce_107 = happySpecReduce_1  50 happyReduction_107
happyReduction_107 (HappyAbsSyn44  happy_var_1)
	 =  HappyAbsSyn50
		 (AbsVarg.ArgExpr happy_var_1
	)
happyReduction_107 _  = notHappyAtAll 

happyReduce_108 = happySpecReduce_1  50 happyReduction_108
happyReduction_108 (HappyAbsSyn49  happy_var_1)
	 =  HappyAbsSyn50
		 (AbsVarg.ArgFunc happy_var_1
	)
happyReduction_108 _  = notHappyAtAll 

happyReduce_109 = happySpecReduce_0  51 happyReduction_109
happyReduction_109  =  HappyAbsSyn51
		 ([]
	)

happyReduce_110 = happySpecReduce_2  51 happyReduction_110
happyReduction_110 (HappyAbsSyn50  happy_var_2)
	(HappyAbsSyn51  happy_var_1)
	 =  HappyAbsSyn51
		 (flip (:) happy_var_1 happy_var_2
	)
happyReduction_110 _ _  = notHappyAtAll 

happyReduce_111 = happySpecReduce_2  52 happyReduction_111
happyReduction_111 (HappyAbsSyn51  happy_var_2)
	(HappyAbsSyn49  happy_var_1)
	 =  HappyAbsSyn44
		 (AbsVarg.EApply happy_var_1 (reverse happy_var_2)
	)
happyReduction_111 _ _  = notHappyAtAll 

happyReduce_112 = happySpecReduce_1  52 happyReduction_112
happyReduction_112 (HappyAbsSyn44  happy_var_1)
	 =  HappyAbsSyn44
		 (happy_var_1
	)
happyReduction_112 _  = notHappyAtAll 

happyReduce_113 = happySpecReduce_1  53 happyReduction_113
happyReduction_113 (HappyAbsSyn44  happy_var_1)
	 =  HappyAbsSyn53
		 (AbsVarg.EListElem happy_var_1
	)
happyReduction_113 _  = notHappyAtAll 

happyReduce_114 = happySpecReduce_0  54 happyReduction_114
happyReduction_114  =  HappyAbsSyn54
		 ([]
	)

happyReduce_115 = happySpecReduce_1  54 happyReduction_115
happyReduction_115 (HappyAbsSyn53  happy_var_1)
	 =  HappyAbsSyn54
		 ((:[]) happy_var_1
	)
happyReduction_115 _  = notHappyAtAll 

happyReduce_116 = happySpecReduce_3  54 happyReduction_116
happyReduction_116 (HappyAbsSyn54  happy_var_3)
	_
	(HappyAbsSyn53  happy_var_1)
	 =  HappyAbsSyn54
		 ((:) happy_var_1 happy_var_3
	)
happyReduction_116 _ _ _  = notHappyAtAll 

happyReduce_117 = happySpecReduce_3  55 happyReduction_117
happyReduction_117 (HappyAbsSyn44  happy_var_3)
	_
	(HappyAbsSyn44  happy_var_1)
	 =  HappyAbsSyn44
		 (AbsVarg.EEq happy_var_1 happy_var_3
	)
happyReduction_117 _ _ _  = notHappyAtAll 

happyReduce_118 = happySpecReduce_3  55 happyReduction_118
happyReduction_118 (HappyAbsSyn44  happy_var_3)
	_
	(HappyAbsSyn44  happy_var_1)
	 =  HappyAbsSyn44
		 (AbsVarg.ELq happy_var_1 happy_var_3
	)
happyReduction_118 _ _ _  = notHappyAtAll 

happyReduce_119 = happySpecReduce_3  55 happyReduction_119
happyReduction_119 (HappyAbsSyn44  happy_var_3)
	_
	(HappyAbsSyn44  happy_var_1)
	 =  HappyAbsSyn44
		 (AbsVarg.EGt happy_var_1 happy_var_3
	)
happyReduction_119 _ _ _  = notHappyAtAll 

happyReduce_120 = happySpecReduce_3  55 happyReduction_120
happyReduction_120 (HappyAbsSyn44  happy_var_3)
	_
	(HappyAbsSyn44  happy_var_1)
	 =  HappyAbsSyn44
		 (AbsVarg.ELeq happy_var_1 happy_var_3
	)
happyReduction_120 _ _ _  = notHappyAtAll 

happyReduce_121 = happySpecReduce_3  55 happyReduction_121
happyReduction_121 (HappyAbsSyn44  happy_var_3)
	_
	(HappyAbsSyn44  happy_var_1)
	 =  HappyAbsSyn44
		 (AbsVarg.EGeq happy_var_1 happy_var_3
	)
happyReduction_121 _ _ _  = notHappyAtAll 

happyReduce_122 = happySpecReduce_1  55 happyReduction_122
happyReduction_122 (HappyAbsSyn44  happy_var_1)
	 =  HappyAbsSyn44
		 (happy_var_1
	)
happyReduction_122 _  = notHappyAtAll 

happyReduce_123 = happySpecReduce_3  56 happyReduction_123
happyReduction_123 (HappyAbsSyn44  happy_var_3)
	_
	(HappyAbsSyn44  happy_var_1)
	 =  HappyAbsSyn44
		 (AbsVarg.EAdd happy_var_1 happy_var_3
	)
happyReduction_123 _ _ _  = notHappyAtAll 

happyReduce_124 = happySpecReduce_3  56 happyReduction_124
happyReduction_124 (HappyAbsSyn44  happy_var_3)
	_
	(HappyAbsSyn44  happy_var_1)
	 =  HappyAbsSyn44
		 (AbsVarg.ESub happy_var_1 happy_var_3
	)
happyReduction_124 _ _ _  = notHappyAtAll 

happyReduce_125 = happySpecReduce_1  56 happyReduction_125
happyReduction_125 (HappyAbsSyn44  happy_var_1)
	 =  HappyAbsSyn44
		 (happy_var_1
	)
happyReduction_125 _  = notHappyAtAll 

happyReduce_126 = happySpecReduce_3  57 happyReduction_126
happyReduction_126 (HappyAbsSyn44  happy_var_3)
	_
	(HappyAbsSyn44  happy_var_1)
	 =  HappyAbsSyn44
		 (AbsVarg.EMul happy_var_1 happy_var_3
	)
happyReduction_126 _ _ _  = notHappyAtAll 

happyReduce_127 = happySpecReduce_3  57 happyReduction_127
happyReduction_127 (HappyAbsSyn44  happy_var_3)
	_
	(HappyAbsSyn44  happy_var_1)
	 =  HappyAbsSyn44
		 (AbsVarg.EDiv happy_var_1 happy_var_3
	)
happyReduction_127 _ _ _  = notHappyAtAll 

happyReduce_128 = happySpecReduce_1  57 happyReduction_128
happyReduction_128 (HappyAbsSyn44  happy_var_1)
	 =  HappyAbsSyn44
		 (happy_var_1
	)
happyReduction_128 _  = notHappyAtAll 

happyReduce_129 = happySpecReduce_3  58 happyReduction_129
happyReduction_129 (HappyAbsSyn44  happy_var_3)
	_
	(HappyAbsSyn44  happy_var_1)
	 =  HappyAbsSyn44
		 (AbsVarg.EPow happy_var_1 happy_var_3
	)
happyReduction_129 _ _ _  = notHappyAtAll 

happyReduce_130 = happySpecReduce_1  58 happyReduction_130
happyReduction_130 (HappyAbsSyn44  happy_var_1)
	 =  HappyAbsSyn44
		 (happy_var_1
	)
happyReduction_130 _  = notHappyAtAll 

happyReduce_131 = happySpecReduce_1  59 happyReduction_131
happyReduction_131 (HappyAbsSyn4  happy_var_1)
	 =  HappyAbsSyn44
		 (AbsVarg.EInt happy_var_1
	)
happyReduction_131 _  = notHappyAtAll 

happyReduce_132 = happySpecReduce_1  59 happyReduction_132
happyReduction_132 (HappyAbsSyn5  happy_var_1)
	 =  HappyAbsSyn44
		 (AbsVarg.EReal happy_var_1
	)
happyReduction_132 _  = notHappyAtAll 

happyReduce_133 = happySpecReduce_1  59 happyReduction_133
happyReduction_133 _
	 =  HappyAbsSyn44
		 (AbsVarg.EWild
	)

happyReduce_134 = happySpecReduce_3  59 happyReduction_134
happyReduction_134 _
	(HappyAbsSyn44  happy_var_2)
	_
	 =  HappyAbsSyn44
		 (happy_var_2
	)
happyReduction_134 _ _ _  = notHappyAtAll 

happyNewToken action sts stk [] =
	action 118 118 notHappyAtAll (HappyState action) sts stk []

happyNewToken action sts stk (tk:tks) =
	let cont i = action i i tk (HappyState action) sts stk tks in
	case tk of {
	PT _ (TS _ 1) -> cont 60;
	PT _ (TS _ 2) -> cont 61;
	PT _ (TS _ 3) -> cont 62;
	PT _ (TS _ 4) -> cont 63;
	PT _ (TS _ 5) -> cont 64;
	PT _ (TS _ 6) -> cont 65;
	PT _ (TS _ 7) -> cont 66;
	PT _ (TS _ 8) -> cont 67;
	PT _ (TS _ 9) -> cont 68;
	PT _ (TS _ 10) -> cont 69;
	PT _ (TS _ 11) -> cont 70;
	PT _ (TS _ 12) -> cont 71;
	PT _ (TS _ 13) -> cont 72;
	PT _ (TS _ 14) -> cont 73;
	PT _ (TS _ 15) -> cont 74;
	PT _ (TS _ 16) -> cont 75;
	PT _ (TS _ 17) -> cont 76;
	PT _ (TS _ 18) -> cont 77;
	PT _ (TS _ 19) -> cont 78;
	PT _ (TS _ 20) -> cont 79;
	PT _ (TS _ 21) -> cont 80;
	PT _ (TS _ 22) -> cont 81;
	PT _ (TS _ 23) -> cont 82;
	PT _ (TS _ 24) -> cont 83;
	PT _ (TS _ 25) -> cont 84;
	PT _ (TS _ 26) -> cont 85;
	PT _ (TS _ 27) -> cont 86;
	PT _ (TS _ 28) -> cont 87;
	PT _ (TS _ 29) -> cont 88;
	PT _ (TS _ 30) -> cont 89;
	PT _ (TS _ 31) -> cont 90;
	PT _ (TS _ 32) -> cont 91;
	PT _ (TS _ 33) -> cont 92;
	PT _ (TS _ 34) -> cont 93;
	PT _ (TS _ 35) -> cont 94;
	PT _ (TS _ 36) -> cont 95;
	PT _ (TS _ 37) -> cont 96;
	PT _ (TS _ 38) -> cont 97;
	PT _ (TS _ 39) -> cont 98;
	PT _ (TS _ 40) -> cont 99;
	PT _ (TS _ 41) -> cont 100;
	PT _ (TS _ 42) -> cont 101;
	PT _ (TS _ 43) -> cont 102;
	PT _ (TS _ 44) -> cont 103;
	PT _ (TS _ 45) -> cont 104;
	PT _ (TS _ 46) -> cont 105;
	PT _ (TS _ 47) -> cont 106;
	PT _ (TS _ 48) -> cont 107;
	PT _ (TS _ 49) -> cont 108;
	PT _ (TS _ 50) -> cont 109;
	PT _ (TS _ 51) -> cont 110;
	PT _ (TS _ 52) -> cont 111;
	PT _ (TS _ 53) -> cont 112;
	PT _ (TI happy_dollar_dollar) -> cont 113;
	PT _ (TD happy_dollar_dollar) -> cont 114;
	PT _ (T_UIdent happy_dollar_dollar) -> cont 115;
	PT _ (T_LIdent happy_dollar_dollar) -> cont 116;
	PT _ (T_MFun happy_dollar_dollar) -> cont 117;
	_ -> happyError' ((tk:tks), [])
	}

happyError_ explist 118 tk tks = happyError' (tks, explist)
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
