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
	| HappyAbsSyn6 (Char)
	| HappyAbsSyn7 (String)
	| HappyAbsSyn8 (UIdent)
	| HappyAbsSyn9 (LIdent)
	| HappyAbsSyn10 (MFun)
	| HappyAbsSyn11 (ProgramDef)
	| HappyAbsSyn12 ([ClassDef])
	| HappyAbsSyn13 (ImportDef)
	| HappyAbsSyn14 ([ImportDef])
	| HappyAbsSyn15 ([ConstrTypeParam])
	| HappyAbsSyn16 (ConstrTypeParam)
	| HappyAbsSyn17 (TypeDef)
	| HappyAbsSyn19 ([TypeDef])
	| HappyAbsSyn20 (PrimFreeType)
	| HappyAbsSyn21 (FreeTypeDef)
	| HappyAbsSyn23 ([PrimFreeType])
	| HappyAbsSyn24 ([ArgDef])
	| HappyAbsSyn25 (ArgDef)
	| HappyAbsSyn26 (SuperclassType)
	| HappyAbsSyn27 ([SuperclassType])
	| HappyAbsSyn28 (ClassDef)
	| HappyAbsSyn29 (IsImplementing)
	| HappyAbsSyn30 (IsDeriving)
	| HappyAbsSyn31 ([ClassModifier])
	| HappyAbsSyn32 (ClassModifier)
	| HappyAbsSyn33 (ClassContents)
	| HappyAbsSyn34 (MemberDef)
	| HappyAbsSyn35 ([MemberDef])
	| HappyAbsSyn36 (FunDef)
	| HappyAbsSyn37 (RetType)
	| HappyAbsSyn38 (FunctionName)
	| HappyAbsSyn39 (Operator)
	| HappyAbsSyn40 (AbsRetType)
	| HappyAbsSyn41 (FunTemplateParams)
	| HappyAbsSyn42 (TemplateParam)
	| HappyAbsSyn43 ([TemplateParam])
	| HappyAbsSyn44 ([FunDef])
	| HappyAbsSyn45 ([FunctionModifier])
	| HappyAbsSyn46 (FunctionModifier)
	| HappyAbsSyn47 (ClassField)
	| HappyAbsSyn48 ([ClassField])
	| HappyAbsSyn49 (FieldModifier)
	| HappyAbsSyn50 (Expr)
	| HappyAbsSyn51 ([AsDef])
	| HappyAbsSyn52 (AsDef)
	| HappyAbsSyn53 ([MatchClause])
	| HappyAbsSyn54 (MatchClause)
	| HappyAbsSyn55 (Functorial)
	| HappyAbsSyn56 (Arg)
	| HappyAbsSyn57 ([Arg])
	| HappyAbsSyn59 (ListElem)
	| HappyAbsSyn60 ([ListElem])
	| HappyAbsSyn66 (Boolean)

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
 action_237,
 action_238,
 action_239,
 action_240,
 action_241,
 action_242,
 action_243,
 action_244,
 action_245,
 action_246,
 action_247,
 action_248,
 action_249,
 action_250,
 action_251,
 action_252,
 action_253,
 action_254,
 action_255,
 action_256,
 action_257,
 action_258,
 action_259,
 action_260,
 action_261,
 action_262,
 action_263,
 action_264,
 action_265,
 action_266,
 action_267,
 action_268,
 action_269,
 action_270,
 action_271,
 action_272,
 action_273,
 action_274 :: () => Int -> ({-HappyReduction (Err) = -}
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
 happyReduce_134,
 happyReduce_135,
 happyReduce_136,
 happyReduce_137,
 happyReduce_138,
 happyReduce_139,
 happyReduce_140,
 happyReduce_141,
 happyReduce_142,
 happyReduce_143,
 happyReduce_144,
 happyReduce_145,
 happyReduce_146,
 happyReduce_147,
 happyReduce_148,
 happyReduce_149,
 happyReduce_150,
 happyReduce_151,
 happyReduce_152,
 happyReduce_153,
 happyReduce_154,
 happyReduce_155,
 happyReduce_156,
 happyReduce_157,
 happyReduce_158 :: () => ({-HappyReduction (Err) = -}
	   Int 
	-> (Token)
	-> HappyState (Token) (HappyStk HappyAbsSyn -> [(Token)] -> (Err) HappyAbsSyn)
	-> [HappyState (Token) (HappyStk HappyAbsSyn -> [(Token)] -> (Err) HappyAbsSyn)] 
	-> HappyStk HappyAbsSyn 
	-> [(Token)] -> (Err) HappyAbsSyn)

happyExpList :: Happy_Data_Array.Array Int Int
happyExpList = Happy_Data_Array.listArray (0,949) ([0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,256,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,4096,0,0,0,0,8192,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,512,44608,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,16,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,256,0,0,0,0,0,0,0,4096,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,2048,0,0,0,0,0,0,0,0,128,0,0,0,0,0,256,0,0,0,48,0,0,0,0,0,0,0,4,0,0,0,0,0,2054,0,12288,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,8,0,0,0,0,0,0,0,0,0,0,0,0,0,0,512,0,0,32,0,0,0,0,0,0,0,0,0,0,0,0,0,0,128,8200,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,256,0,0,0,48,0,0,0,0,0,0,0,1,0,0,0,0,1,0,0,12288,0,0,0,0,256,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,4,0,0,0,0,2,0,0,0,0,0,0,0,16,0,0,0,3,0,0,0,256,0,0,0,48,0,0,0,0,16,0,0,0,0,0,0,0,512,0,0,0,0,0,0,0,0,0,0,2048,0,0,0,0,0,0,0,0,32,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,32768,0,4,0,0,0,0,0,0,8,64,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,64,0,0,0,0,16,0,0,0,3,0,0,0,256,0,0,0,48,0,0,0,4096,0,0,0,768,0,0,0,0,1,0,0,12288,0,0,0,0,4096,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,32776,512,0,0,0,0,1,0,0,12288,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,12288,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,16,0,0,0,4096,0,0,0,768,0,0,0,0,0,0,0,0,0,0,0,0,0,0,16,0,0,0,0,0,0,0,0,32768,0,0,0,0,0,32,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,32,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,12288,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,256,0,0,0,0,0,0,256,0,0,0,48,0,0,0,0,0,1,0,0,0,0,0,0,0,16,0,0,0,0,0,0,0,256,0,0,0,0,0,0,0,0,0,0,16,0,0,0,0,0,0,0,8,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,8192,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,16,0,0,0,3,0,0,0,0,1536,0,0,48,0,0,0,0,24576,0,0,768,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,2,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,49152,5252,8,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,4,0,0,0,0,0,0,128,8200,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,8192,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1024,0,0,0,0,0,0,0,51904,538,0,0,0,0,0,0,0,0,0,32768,0,0,0,0,0,0,0,0,0,0,0,0,0,2,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,4096,0,0,0,512,0,0,0,0,0,6,0,12288,0,0,0,0,0,0,0,0,0,0,0,0,4096,0,0,0,0,0,0,0,0,2048,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,4096,0,0,0,0,0,0,0,256,0,0,0,32,0,0,0,0,0,0,0,512,0,0,0,0,0,0,0,0,0,0,0,0,4096,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,256,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,16,2048,0,0,3,0,0,0,0,0,0,0,0,0,0,0,0,24576,0,0,768,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,256,0,0,0,48,0,0,0,7168,16384,8772,25616,1840,0,0,0,0,1,0,0,12288,0,0,0,0,32,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,512,0,0,0,0,0,0,0,32,0,0,0,0,0,0,32768,6338,0,0,0,0,0,0,0,132,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,2048,0,0,0,0,0,0,0,16384,0,0,0,0,44480,28076,548,1601,115,0,0,0,7168,16384,8772,25616,1840,0,0,0,0,0,0,0,0,0,0,0,0,28,17472,4130,13412,7,0,0,0,0,0,0,0,0,0,0,0,7168,16384,8772,25616,1840,0,0,0,49152,1,9284,16642,29446,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,2,0,0,0,0,0,0,0,1,0,0,0,0,0,4096,0,0,0,0,0,0,0,0,8192,0,0,0,0,0,7168,16384,8772,25616,1840,0,0,0,0,0,0,0,0,0,0,0,0,256,0,0,0,0,0,0,0,0,4096,0,0,0,0,0,0,8192,0,0,0,0,0,0,0,0,2,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,256,0,0,0,32,0,0,0,2048,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,4,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,7168,0,516,25600,1840,0,0,0,49152,1,8256,16384,29446,0,0,0,0,28,1024,2,12388,7,0,0,0,448,16384,32,1600,115,0,0,0,7168,0,516,25600,1840,0,0,0,49152,1,8256,16384,29446,0,0,0,0,28,1024,2,12388,7,0,0,0,448,16384,32,1600,115,0,0,0,7168,0,516,25600,1840,0,0,0,49152,1,8256,16384,29446,0,0,0,0,28,1024,2,12388,7,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,44480,26028,548,1601,115,0,0,0,0,0,0,0,0,0,0,0,0,40,0,0,0,0,0,0,0,640,0,0,0,0,0,0,0,10240,0,0,0,0,0,0,0,32768,2,0,0,0,0,0,0,0,40,0,0,0,0,0,0,0,2112,0,0,0,0,0,0,0,33792,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,16,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,49152,1,9284,16642,29446,0,0,0,0,0,0,0,2048,0,0,0,0,0,2,0,0,0,0,0,0,7168,16384,8772,25616,1840,0,0,0,0,0,0,0,8192,0,0,0,0,28,17472,4130,12388,7,0,0,0,0,0,0,16384,0,0,0,0,7168,16384,8772,25616,1840,0,0,0,0,0,4096,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,7168,16384,8772,25616,1840,0,0,0,0,0,0,32,0,0,0,0,0,0,0,0,0,0,0,0,0,256,0,0,0,48,0,0,0,0,1024,0,0,0,0,0,0,49152,1,9284,16642,29446,0,0,0,0,0,0,0,0,0,0,0,0,448,17408,548,1601,115,0,0,0,0,4,0,0,0,0,0,0,0,0,0,0,128,0,0,0,0,8192,0,0,0,0,0,0,0,448,17408,548,1601,115,0,0,0,0,0,0,0,0,0,0,0,49152,1,9284,16642,29446,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,7168,16384,8772,25616,1840,0,0,0,0,2,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	])

{-# NOINLINE happyExpListPerState #-}
happyExpListPerState st =
    token_strs_expected
  where token_strs = ["error","%dummy","%start_pProgramDef","Integer","Double","Char","String","UIdent","LIdent","MFun","ProgramDef","ListClassDef","ImportDef","ListImportDef","ListConstrTypeParam","ConstrTypeParam","TypeDef","TypeDef1","ListTypeDef","PrimFreeType","FreeTypeDef","FreeTypeDef1","ListPrimFreeType","ListArgDef","ArgDef","SuperclassType","ListSuperclassType","ClassDef","IsImplementing","IsDeriving","ListClassModifier","ClassModifier","ClassContents","MemberDef","ListMemberDef","FunDef","RetType","FunctionName","Operator","AbsRetType","FunTemplateParams","TemplateParam","ListTemplateParam","ListFunDef","ListFunctionModifier","FunctionModifier","ClassField","ListClassField","FieldModifier","Expr","ListAsDef","AsDef","ListMatchClause","MatchClause","Functorial","Arg","ListArg","Expr5","ListElem","ListListElem","Expr1","Expr2","Expr3","Expr4","Expr6","Boolean","'\\\"'","'\\''","'('","')'","'*'","'+'","','","'-'","'->'","'/'","':'","';'","'<'","'<='","'='","'=='","'=>'","'>'","'>='","'?'","'['","'\\\\'","']'","'^'","'_'","'abstract'","'as'","'class'","'define'","'deriving'","'else'","'false'","'final'","'function'","'has'","'if'","'implement'","'implementing'","'import'","'in'","'interface'","'internal'","'match'","'module'","'native'","'sealed'","'static'","'struct'","'super'","'template'","'then'","'this'","'true'","'unique'","'where'","'with'","'{'","'}'","L_integ","L_doubl","L_charac","L_quoted","L_UIdent","L_LIdent","L_MFun","%eof"]
        bit_start = st * 132
        bit_end = (st + 1) * 132
        read_bit = readArrayBit happyExpList
        bits = map read_bit [bit_start..bit_end - 1]
        bits_indexed = zip bits [0..131]
        token_strs_expected = concatMap f bits_indexed
        f (False, _) = []
        f (True, nr) = [token_strs !! nr]

action_0 (11) = happyGoto action_3
action_0 (14) = happyGoto action_4
action_0 _ = happyReduce_12

action_1 (125) = happyShift action_2
action_1 _ = happyFail (happyExpListPerState 1)

action_2 _ = happyReduce_1

action_3 (132) = happyAccept
action_3 _ = happyFail (happyExpListPerState 3)

action_4 (105) = happyShift action_7
action_4 (12) = happyGoto action_5
action_4 (13) = happyGoto action_6
action_4 _ = happyReduce_9

action_5 (132) = happyReduce_8
action_5 (28) = happyGoto action_10
action_5 (31) = happyGoto action_11
action_5 _ = happyReduce_52

action_6 _ = happyReduce_13

action_7 (129) = happyShift action_9
action_7 (8) = happyGoto action_8
action_7 _ = happyFail (happyExpListPerState 7)

action_8 (78) = happyShift action_20
action_8 _ = happyFail (happyExpListPerState 8)

action_9 _ = happyReduce_5

action_10 _ = happyReduce_10

action_11 (94) = happyShift action_13
action_11 (107) = happyShift action_14
action_11 (110) = happyShift action_15
action_11 (111) = happyShift action_16
action_11 (112) = happyShift action_17
action_11 (114) = happyShift action_18
action_11 (116) = happyShift action_19
action_11 (32) = happyGoto action_12
action_11 _ = happyFail (happyExpListPerState 11)

action_12 _ = happyReduce_53

action_13 (129) = happyShift action_9
action_13 (8) = happyGoto action_23
action_13 _ = happyFail (happyExpListPerState 13)

action_14 _ = happyReduce_55

action_15 _ = happyReduce_54

action_16 _ = happyReduce_57

action_17 _ = happyReduce_56

action_18 (129) = happyShift action_9
action_18 (8) = happyGoto action_22
action_18 _ = happyFail (happyExpListPerState 18)

action_19 (129) = happyShift action_9
action_19 (8) = happyGoto action_21
action_19 _ = happyFail (happyExpListPerState 19)

action_20 _ = happyReduce_11

action_21 (15) = happyGoto action_27
action_21 _ = happyReduce_14

action_22 (121) = happyShift action_26
action_22 _ = happyFail (happyExpListPerState 22)

action_23 (96) = happyShift action_25
action_23 (30) = happyGoto action_24
action_23 _ = happyReduce_51

action_24 (104) = happyShift action_43
action_24 (29) = happyGoto action_42
action_24 _ = happyReduce_49

action_25 (69) = happyShift action_41
action_25 (129) = happyShift action_9
action_25 (130) = happyShift action_34
action_25 (8) = happyGoto action_36
action_25 (9) = happyGoto action_37
action_25 (21) = happyGoto action_38
action_25 (22) = happyGoto action_39
action_25 (26) = happyGoto action_40
action_25 _ = happyFail (happyExpListPerState 25)

action_26 (123) = happyShift action_35
action_26 _ = happyFail (happyExpListPerState 26)

action_27 (86) = happyShift action_32
action_27 (87) = happyShift action_33
action_27 (96) = happyShift action_25
action_27 (129) = happyShift action_9
action_27 (130) = happyShift action_34
action_27 (8) = happyGoto action_28
action_27 (9) = happyGoto action_29
action_27 (16) = happyGoto action_30
action_27 (30) = happyGoto action_31
action_27 _ = happyReduce_51

action_28 _ = happyReduce_17

action_29 _ = happyReduce_16

action_30 _ = happyReduce_15

action_31 (104) = happyShift action_43
action_31 (29) = happyGoto action_58
action_31 _ = happyReduce_49

action_32 _ = happyReduce_18

action_33 (86) = happyShift action_57
action_33 (130) = happyShift action_34
action_33 (9) = happyGoto action_56
action_33 _ = happyFail (happyExpListPerState 33)

action_34 _ = happyReduce_6

action_35 (108) = happyShift action_54
action_35 (120) = happyShift action_55
action_35 (130) = happyShift action_34
action_35 (9) = happyGoto action_50
action_35 (47) = happyGoto action_51
action_35 (48) = happyGoto action_52
action_35 (49) = happyGoto action_53
action_35 _ = happyReduce_100

action_36 (23) = happyGoto action_49
action_36 _ = happyReduce_36

action_37 (23) = happyGoto action_48
action_37 _ = happyReduce_36

action_38 _ = happyReduce_42

action_39 _ = happyReduce_34

action_40 _ = happyReduce_50

action_41 (69) = happyShift action_41
action_41 (129) = happyShift action_9
action_41 (130) = happyShift action_34
action_41 (8) = happyGoto action_36
action_41 (9) = happyGoto action_37
action_41 (21) = happyGoto action_47
action_41 (22) = happyGoto action_39
action_41 _ = happyFail (happyExpListPerState 41)

action_42 (121) = happyShift action_46
action_42 _ = happyFail (happyExpListPerState 42)

action_43 (69) = happyShift action_41
action_43 (129) = happyShift action_9
action_43 (130) = happyShift action_34
action_43 (8) = happyGoto action_36
action_43 (9) = happyGoto action_37
action_43 (21) = happyGoto action_38
action_43 (22) = happyGoto action_39
action_43 (26) = happyGoto action_44
action_43 (27) = happyGoto action_45
action_43 _ = happyFail (happyExpListPerState 43)

action_44 (73) = happyShift action_74
action_44 _ = happyReduce_43

action_45 _ = happyReduce_48

action_46 (123) = happyShift action_73
action_46 _ = happyFail (happyExpListPerState 46)

action_47 (70) = happyShift action_72
action_47 _ = happyFail (happyExpListPerState 47)

action_48 (69) = happyShift action_71
action_48 (129) = happyShift action_9
action_48 (130) = happyShift action_34
action_48 (8) = happyGoto action_68
action_48 (9) = happyGoto action_69
action_48 (20) = happyGoto action_70
action_48 _ = happyReduce_33

action_49 (69) = happyShift action_71
action_49 (129) = happyShift action_9
action_49 (130) = happyShift action_34
action_49 (8) = happyGoto action_68
action_49 (9) = happyGoto action_69
action_49 (20) = happyGoto action_70
action_49 _ = happyReduce_32

action_50 (77) = happyShift action_67
action_50 _ = happyFail (happyExpListPerState 50)

action_51 (78) = happyShift action_66
action_51 _ = happyReduce_101

action_52 (124) = happyShift action_65
action_52 _ = happyFail (happyExpListPerState 52)

action_53 (130) = happyShift action_34
action_53 (9) = happyGoto action_64
action_53 _ = happyFail (happyExpListPerState 53)

action_54 _ = happyReduce_103

action_55 _ = happyReduce_104

action_56 (96) = happyShift action_62
action_56 (115) = happyShift action_63
action_56 _ = happyFail (happyExpListPerState 56)

action_57 (96) = happyShift action_60
action_57 (115) = happyShift action_61
action_57 _ = happyFail (happyExpListPerState 57)

action_58 (121) = happyShift action_59
action_58 _ = happyFail (happyExpListPerState 58)

action_59 (123) = happyShift action_93
action_59 _ = happyFail (happyExpListPerState 59)

action_60 (69) = happyShift action_89
action_60 (129) = happyShift action_9
action_60 (130) = happyShift action_34
action_60 (8) = happyGoto action_84
action_60 (9) = happyGoto action_85
action_60 (17) = happyGoto action_86
action_60 (18) = happyGoto action_87
action_60 (19) = happyGoto action_92
action_60 _ = happyFail (happyExpListPerState 60)

action_61 (69) = happyShift action_89
action_61 (129) = happyShift action_9
action_61 (130) = happyShift action_34
action_61 (8) = happyGoto action_84
action_61 (9) = happyGoto action_85
action_61 (17) = happyGoto action_86
action_61 (18) = happyGoto action_87
action_61 (19) = happyGoto action_91
action_61 _ = happyFail (happyExpListPerState 61)

action_62 (69) = happyShift action_89
action_62 (129) = happyShift action_9
action_62 (130) = happyShift action_34
action_62 (8) = happyGoto action_84
action_62 (9) = happyGoto action_85
action_62 (17) = happyGoto action_86
action_62 (18) = happyGoto action_87
action_62 (19) = happyGoto action_90
action_62 _ = happyFail (happyExpListPerState 62)

action_63 (69) = happyShift action_89
action_63 (129) = happyShift action_9
action_63 (130) = happyShift action_34
action_63 (8) = happyGoto action_84
action_63 (9) = happyGoto action_85
action_63 (17) = happyGoto action_86
action_63 (18) = happyGoto action_87
action_63 (19) = happyGoto action_88
action_63 _ = happyFail (happyExpListPerState 63)

action_64 (77) = happyShift action_83
action_64 _ = happyFail (happyExpListPerState 64)

action_65 _ = happyReduce_45

action_66 (108) = happyShift action_54
action_66 (120) = happyShift action_55
action_66 (130) = happyShift action_34
action_66 (9) = happyGoto action_50
action_66 (47) = happyGoto action_51
action_66 (48) = happyGoto action_82
action_66 (49) = happyGoto action_53
action_66 _ = happyReduce_100

action_67 (69) = happyShift action_41
action_67 (129) = happyShift action_9
action_67 (130) = happyShift action_34
action_67 (8) = happyGoto action_36
action_67 (9) = happyGoto action_37
action_67 (21) = happyGoto action_81
action_67 (22) = happyGoto action_39
action_67 _ = happyFail (happyExpListPerState 67)

action_68 _ = happyReduce_31

action_69 _ = happyReduce_30

action_70 _ = happyReduce_37

action_71 (69) = happyShift action_41
action_71 (129) = happyShift action_9
action_71 (130) = happyShift action_34
action_71 (8) = happyGoto action_36
action_71 (9) = happyGoto action_37
action_71 (21) = happyGoto action_80
action_71 (22) = happyGoto action_39
action_71 _ = happyFail (happyExpListPerState 71)

action_72 _ = happyReduce_35

action_73 (129) = happyShift action_9
action_73 (8) = happyGoto action_76
action_73 (33) = happyGoto action_77
action_73 (34) = happyGoto action_78
action_73 (35) = happyGoto action_79
action_73 _ = happyReduce_61

action_74 (69) = happyShift action_41
action_74 (129) = happyShift action_9
action_74 (130) = happyShift action_34
action_74 (8) = happyGoto action_36
action_74 (9) = happyGoto action_37
action_74 (21) = happyGoto action_38
action_74 (22) = happyGoto action_39
action_74 (26) = happyGoto action_44
action_74 (27) = happyGoto action_75
action_74 _ = happyFail (happyExpListPerState 74)

action_75 _ = happyReduce_44

action_76 (101) = happyShift action_110
action_76 _ = happyReduce_59

action_77 (124) = happyShift action_109
action_77 _ = happyFail (happyExpListPerState 77)

action_78 (78) = happyShift action_108
action_78 _ = happyReduce_62

action_79 (124) = happyReduce_87
action_79 (36) = happyGoto action_105
action_79 (44) = happyGoto action_106
action_79 (45) = happyGoto action_107
action_79 _ = happyReduce_90

action_80 (70) = happyShift action_104
action_80 _ = happyFail (happyExpListPerState 80)

action_81 _ = happyReduce_99

action_82 _ = happyReduce_102

action_83 (69) = happyShift action_41
action_83 (129) = happyShift action_9
action_83 (130) = happyShift action_34
action_83 (8) = happyGoto action_36
action_83 (9) = happyGoto action_37
action_83 (21) = happyGoto action_103
action_83 (22) = happyGoto action_39
action_83 _ = happyFail (happyExpListPerState 83)

action_84 (15) = happyGoto action_102
action_84 _ = happyReduce_14

action_85 (15) = happyGoto action_101
action_85 _ = happyReduce_14

action_86 (73) = happyShift action_100
action_86 _ = happyReduce_27

action_87 _ = happyReduce_25

action_88 (89) = happyShift action_99
action_88 _ = happyFail (happyExpListPerState 88)

action_89 (69) = happyShift action_89
action_89 (129) = happyShift action_9
action_89 (130) = happyShift action_34
action_89 (8) = happyGoto action_84
action_89 (9) = happyGoto action_85
action_89 (17) = happyGoto action_98
action_89 (18) = happyGoto action_87
action_89 _ = happyFail (happyExpListPerState 89)

action_90 (89) = happyShift action_97
action_90 _ = happyFail (happyExpListPerState 90)

action_91 (89) = happyShift action_96
action_91 _ = happyFail (happyExpListPerState 91)

action_92 (89) = happyShift action_95
action_92 _ = happyFail (happyExpListPerState 92)

action_93 (129) = happyShift action_9
action_93 (8) = happyGoto action_76
action_93 (33) = happyGoto action_94
action_93 (34) = happyGoto action_78
action_93 (35) = happyGoto action_79
action_93 _ = happyReduce_61

action_94 (124) = happyShift action_124
action_94 _ = happyFail (happyExpListPerState 94)

action_95 _ = happyReduce_22

action_96 _ = happyReduce_20

action_97 _ = happyReduce_21

action_98 (70) = happyShift action_123
action_98 _ = happyFail (happyExpListPerState 98)

action_99 _ = happyReduce_19

action_100 (69) = happyShift action_89
action_100 (129) = happyShift action_9
action_100 (130) = happyShift action_34
action_100 (8) = happyGoto action_84
action_100 (9) = happyGoto action_85
action_100 (17) = happyGoto action_86
action_100 (18) = happyGoto action_87
action_100 (19) = happyGoto action_122
action_100 _ = happyFail (happyExpListPerState 100)

action_101 (86) = happyShift action_32
action_101 (87) = happyShift action_33
action_101 (129) = happyShift action_9
action_101 (130) = happyShift action_34
action_101 (8) = happyGoto action_28
action_101 (9) = happyGoto action_29
action_101 (16) = happyGoto action_30
action_101 _ = happyReduce_24

action_102 (86) = happyShift action_32
action_102 (87) = happyShift action_33
action_102 (129) = happyShift action_9
action_102 (130) = happyShift action_34
action_102 (8) = happyGoto action_28
action_102 (9) = happyGoto action_29
action_102 (16) = happyGoto action_30
action_102 _ = happyReduce_23

action_103 _ = happyReduce_98

action_104 _ = happyReduce_29

action_105 (78) = happyShift action_121
action_105 _ = happyReduce_88

action_106 _ = happyReduce_58

action_107 (99) = happyShift action_114
action_107 (100) = happyShift action_115
action_107 (103) = happyShift action_116
action_107 (108) = happyShift action_117
action_107 (111) = happyShift action_118
action_107 (113) = happyShift action_119
action_107 (120) = happyShift action_120
action_107 (46) = happyGoto action_113
action_107 _ = happyFail (happyExpListPerState 107)

action_108 (129) = happyShift action_9
action_108 (8) = happyGoto action_76
action_108 (34) = happyGoto action_78
action_108 (35) = happyGoto action_112
action_108 _ = happyReduce_61

action_109 _ = happyReduce_46

action_110 (123) = happyShift action_111
action_110 _ = happyFail (happyExpListPerState 110)

action_111 (108) = happyShift action_54
action_111 (120) = happyShift action_55
action_111 (130) = happyShift action_34
action_111 (9) = happyGoto action_50
action_111 (47) = happyGoto action_51
action_111 (48) = happyGoto action_129
action_111 (49) = happyGoto action_53
action_111 _ = happyReduce_100

action_112 _ = happyReduce_63

action_113 _ = happyReduce_91

action_114 _ = happyReduce_95

action_115 (69) = happyShift action_128
action_115 (130) = happyShift action_34
action_115 (9) = happyGoto action_126
action_115 (38) = happyGoto action_127
action_115 _ = happyFail (happyExpListPerState 115)

action_116 _ = happyReduce_94

action_117 _ = happyReduce_93

action_118 _ = happyReduce_97

action_119 _ = happyReduce_92

action_120 _ = happyReduce_96

action_121 (124) = happyReduce_87
action_121 (36) = happyGoto action_105
action_121 (44) = happyGoto action_125
action_121 (45) = happyGoto action_107
action_121 _ = happyReduce_90

action_122 _ = happyReduce_28

action_123 _ = happyReduce_26

action_124 _ = happyReduce_47

action_125 _ = happyReduce_89

action_126 _ = happyReduce_68

action_127 (79) = happyShift action_143
action_127 (41) = happyGoto action_142
action_127 _ = happyReduce_82

action_128 (71) = happyShift action_132
action_128 (72) = happyShift action_133
action_128 (74) = happyShift action_134
action_128 (76) = happyShift action_135
action_128 (79) = happyShift action_136
action_128 (80) = happyShift action_137
action_128 (82) = happyShift action_138
action_128 (84) = happyShift action_139
action_128 (85) = happyShift action_140
action_128 (90) = happyShift action_141
action_128 (39) = happyGoto action_131
action_128 _ = happyFail (happyExpListPerState 128)

action_129 (124) = happyShift action_130
action_129 _ = happyFail (happyExpListPerState 129)

action_130 _ = happyReduce_60

action_131 (70) = happyShift action_151
action_131 _ = happyFail (happyExpListPerState 131)

action_132 _ = happyReduce_72

action_133 _ = happyReduce_70

action_134 _ = happyReduce_71

action_135 _ = happyReduce_73

action_136 _ = happyReduce_75

action_137 _ = happyReduce_77

action_138 _ = happyReduce_79

action_139 _ = happyReduce_76

action_140 _ = happyReduce_78

action_141 _ = happyReduce_74

action_142 (69) = happyShift action_150
action_142 (130) = happyShift action_34
action_142 (9) = happyGoto action_147
action_142 (24) = happyGoto action_148
action_142 (25) = happyGoto action_149
action_142 _ = happyFail (happyExpListPerState 142)

action_143 (86) = happyShift action_32
action_143 (87) = happyShift action_33
action_143 (129) = happyShift action_9
action_143 (130) = happyShift action_34
action_143 (8) = happyGoto action_28
action_143 (9) = happyGoto action_29
action_143 (16) = happyGoto action_144
action_143 (42) = happyGoto action_145
action_143 (43) = happyGoto action_146
action_143 _ = happyFail (happyExpListPerState 143)

action_144 _ = happyReduce_84

action_145 (73) = happyShift action_158
action_145 _ = happyReduce_85

action_146 (84) = happyShift action_157
action_146 _ = happyFail (happyExpListPerState 146)

action_147 _ = happyReduce_41

action_148 (77) = happyShift action_156
action_148 (81) = happyReduce_67
action_148 (37) = happyGoto action_154
action_148 (40) = happyGoto action_155
action_148 _ = happyReduce_81

action_149 (69) = happyShift action_150
action_149 (130) = happyShift action_34
action_149 (9) = happyGoto action_147
action_149 (24) = happyGoto action_153
action_149 (25) = happyGoto action_149
action_149 _ = happyReduce_38

action_150 (130) = happyShift action_34
action_150 (9) = happyGoto action_152
action_150 _ = happyFail (happyExpListPerState 150)

action_151 _ = happyReduce_69

action_152 (77) = happyShift action_163
action_152 _ = happyFail (happyExpListPerState 152)

action_153 _ = happyReduce_39

action_154 (81) = happyShift action_162
action_154 _ = happyFail (happyExpListPerState 154)

action_155 _ = happyReduce_65

action_156 (69) = happyShift action_41
action_156 (92) = happyShift action_161
action_156 (129) = happyShift action_9
action_156 (130) = happyShift action_34
action_156 (8) = happyGoto action_36
action_156 (9) = happyGoto action_37
action_156 (21) = happyGoto action_160
action_156 (22) = happyGoto action_39
action_156 _ = happyFail (happyExpListPerState 156)

action_157 _ = happyReduce_83

action_158 (86) = happyShift action_32
action_158 (87) = happyShift action_33
action_158 (129) = happyShift action_9
action_158 (130) = happyShift action_34
action_158 (8) = happyGoto action_28
action_158 (9) = happyGoto action_29
action_158 (16) = happyGoto action_144
action_158 (42) = happyGoto action_145
action_158 (43) = happyGoto action_159
action_158 _ = happyFail (happyExpListPerState 158)

action_159 _ = happyReduce_86

action_160 _ = happyReduce_66

action_161 (69) = happyShift action_41
action_161 (129) = happyShift action_9
action_161 (130) = happyShift action_34
action_161 (8) = happyGoto action_36
action_161 (9) = happyGoto action_37
action_161 (21) = happyGoto action_193
action_161 (22) = happyGoto action_39
action_161 _ = happyFail (happyExpListPerState 161)

action_162 (67) = happyShift action_179
action_162 (68) = happyShift action_180
action_162 (69) = happyShift action_181
action_162 (87) = happyShift action_182
action_162 (91) = happyShift action_183
action_162 (95) = happyShift action_184
action_162 (98) = happyShift action_185
action_162 (102) = happyShift action_186
action_162 (109) = happyShift action_187
action_162 (115) = happyShift action_188
action_162 (118) = happyShift action_189
action_162 (119) = happyShift action_190
action_162 (125) = happyShift action_2
action_162 (126) = happyShift action_191
action_162 (129) = happyShift action_9
action_162 (130) = happyShift action_34
action_162 (131) = happyShift action_192
action_162 (4) = happyGoto action_165
action_162 (5) = happyGoto action_166
action_162 (8) = happyGoto action_167
action_162 (9) = happyGoto action_168
action_162 (10) = happyGoto action_169
action_162 (50) = happyGoto action_170
action_162 (55) = happyGoto action_171
action_162 (58) = happyGoto action_172
action_162 (61) = happyGoto action_173
action_162 (62) = happyGoto action_174
action_162 (63) = happyGoto action_175
action_162 (64) = happyGoto action_176
action_162 (65) = happyGoto action_177
action_162 (66) = happyGoto action_178
action_162 _ = happyFail (happyExpListPerState 162)

action_163 (69) = happyShift action_41
action_163 (129) = happyShift action_9
action_163 (130) = happyShift action_34
action_163 (8) = happyGoto action_36
action_163 (9) = happyGoto action_37
action_163 (21) = happyGoto action_164
action_163 (22) = happyGoto action_39
action_163 _ = happyFail (happyExpListPerState 163)

action_164 (70) = happyShift action_221
action_164 _ = happyFail (happyExpListPerState 164)

action_165 _ = happyReduce_151

action_166 _ = happyReduce_152

action_167 _ = happyReduce_121

action_168 _ = happyReduce_122

action_169 _ = happyReduce_123

action_170 _ = happyReduce_64

action_171 (57) = happyGoto action_220
action_171 _ = happyReduce_128

action_172 (90) = happyShift action_219
action_172 _ = happyReduce_149

action_173 (82) = happyShift action_218
action_173 _ = happyReduce_111

action_174 (72) = happyShift action_212
action_174 (74) = happyShift action_213
action_174 (79) = happyShift action_214
action_174 (80) = happyShift action_215
action_174 (84) = happyShift action_216
action_174 (85) = happyShift action_217
action_174 _ = happyReduce_141

action_175 (71) = happyShift action_210
action_175 (76) = happyShift action_211
action_175 _ = happyReduce_144

action_176 _ = happyReduce_147

action_177 _ = happyReduce_131

action_178 _ = happyReduce_150

action_179 (128) = happyShift action_209
action_179 (7) = happyGoto action_208
action_179 _ = happyFail (happyExpListPerState 179)

action_180 (127) = happyShift action_207
action_180 (6) = happyGoto action_206
action_180 _ = happyFail (happyExpListPerState 180)

action_181 (67) = happyShift action_179
action_181 (68) = happyShift action_180
action_181 (69) = happyShift action_181
action_181 (71) = happyShift action_132
action_181 (72) = happyShift action_133
action_181 (74) = happyShift action_134
action_181 (76) = happyShift action_135
action_181 (79) = happyShift action_136
action_181 (80) = happyShift action_137
action_181 (82) = happyShift action_138
action_181 (84) = happyShift action_139
action_181 (85) = happyShift action_140
action_181 (87) = happyShift action_182
action_181 (88) = happyShift action_205
action_181 (90) = happyShift action_141
action_181 (91) = happyShift action_183
action_181 (95) = happyShift action_184
action_181 (98) = happyShift action_185
action_181 (102) = happyShift action_186
action_181 (109) = happyShift action_187
action_181 (115) = happyShift action_188
action_181 (118) = happyShift action_189
action_181 (119) = happyShift action_190
action_181 (125) = happyShift action_2
action_181 (126) = happyShift action_191
action_181 (129) = happyShift action_9
action_181 (130) = happyShift action_34
action_181 (131) = happyShift action_192
action_181 (4) = happyGoto action_165
action_181 (5) = happyGoto action_166
action_181 (8) = happyGoto action_167
action_181 (9) = happyGoto action_168
action_181 (10) = happyGoto action_169
action_181 (39) = happyGoto action_202
action_181 (50) = happyGoto action_203
action_181 (55) = happyGoto action_171
action_181 (58) = happyGoto action_172
action_181 (61) = happyGoto action_173
action_181 (62) = happyGoto action_174
action_181 (63) = happyGoto action_175
action_181 (64) = happyGoto action_176
action_181 (65) = happyGoto action_204
action_181 (66) = happyGoto action_178
action_181 _ = happyFail (happyExpListPerState 181)

action_182 (67) = happyShift action_179
action_182 (68) = happyShift action_180
action_182 (69) = happyShift action_181
action_182 (87) = happyShift action_182
action_182 (91) = happyShift action_183
action_182 (95) = happyShift action_184
action_182 (98) = happyShift action_185
action_182 (102) = happyShift action_186
action_182 (109) = happyShift action_187
action_182 (115) = happyShift action_188
action_182 (118) = happyShift action_189
action_182 (119) = happyShift action_190
action_182 (125) = happyShift action_2
action_182 (126) = happyShift action_191
action_182 (129) = happyShift action_9
action_182 (130) = happyShift action_34
action_182 (131) = happyShift action_192
action_182 (4) = happyGoto action_165
action_182 (5) = happyGoto action_166
action_182 (8) = happyGoto action_167
action_182 (9) = happyGoto action_168
action_182 (10) = happyGoto action_169
action_182 (50) = happyGoto action_199
action_182 (55) = happyGoto action_171
action_182 (58) = happyGoto action_172
action_182 (59) = happyGoto action_200
action_182 (60) = happyGoto action_201
action_182 (61) = happyGoto action_173
action_182 (62) = happyGoto action_174
action_182 (63) = happyGoto action_175
action_182 (64) = happyGoto action_176
action_182 (65) = happyGoto action_177
action_182 (66) = happyGoto action_178
action_182 _ = happyReduce_133

action_183 _ = happyReduce_155

action_184 (67) = happyShift action_179
action_184 (68) = happyShift action_180
action_184 (69) = happyShift action_181
action_184 (87) = happyShift action_182
action_184 (91) = happyShift action_183
action_184 (95) = happyShift action_184
action_184 (98) = happyShift action_185
action_184 (102) = happyShift action_186
action_184 (109) = happyShift action_187
action_184 (115) = happyShift action_188
action_184 (118) = happyShift action_189
action_184 (119) = happyShift action_190
action_184 (123) = happyShift action_198
action_184 (125) = happyShift action_2
action_184 (126) = happyShift action_191
action_184 (129) = happyShift action_9
action_184 (130) = happyShift action_34
action_184 (131) = happyShift action_192
action_184 (4) = happyGoto action_165
action_184 (5) = happyGoto action_166
action_184 (8) = happyGoto action_167
action_184 (9) = happyGoto action_168
action_184 (10) = happyGoto action_169
action_184 (50) = happyGoto action_196
action_184 (52) = happyGoto action_197
action_184 (55) = happyGoto action_171
action_184 (58) = happyGoto action_172
action_184 (61) = happyGoto action_173
action_184 (62) = happyGoto action_174
action_184 (63) = happyGoto action_175
action_184 (64) = happyGoto action_176
action_184 (65) = happyGoto action_177
action_184 (66) = happyGoto action_178
action_184 _ = happyFail (happyExpListPerState 184)

action_185 _ = happyReduce_158

action_186 (67) = happyShift action_179
action_186 (68) = happyShift action_180
action_186 (69) = happyShift action_181
action_186 (87) = happyShift action_182
action_186 (91) = happyShift action_183
action_186 (95) = happyShift action_184
action_186 (98) = happyShift action_185
action_186 (102) = happyShift action_186
action_186 (109) = happyShift action_187
action_186 (115) = happyShift action_188
action_186 (118) = happyShift action_189
action_186 (119) = happyShift action_190
action_186 (125) = happyShift action_2
action_186 (126) = happyShift action_191
action_186 (129) = happyShift action_9
action_186 (130) = happyShift action_34
action_186 (131) = happyShift action_192
action_186 (4) = happyGoto action_165
action_186 (5) = happyGoto action_166
action_186 (8) = happyGoto action_167
action_186 (9) = happyGoto action_168
action_186 (10) = happyGoto action_169
action_186 (50) = happyGoto action_195
action_186 (55) = happyGoto action_171
action_186 (58) = happyGoto action_172
action_186 (61) = happyGoto action_173
action_186 (62) = happyGoto action_174
action_186 (63) = happyGoto action_175
action_186 (64) = happyGoto action_176
action_186 (65) = happyGoto action_177
action_186 (66) = happyGoto action_178
action_186 _ = happyFail (happyExpListPerState 186)

action_187 (67) = happyShift action_179
action_187 (68) = happyShift action_180
action_187 (69) = happyShift action_181
action_187 (87) = happyShift action_182
action_187 (91) = happyShift action_183
action_187 (95) = happyShift action_184
action_187 (98) = happyShift action_185
action_187 (102) = happyShift action_186
action_187 (109) = happyShift action_187
action_187 (115) = happyShift action_188
action_187 (118) = happyShift action_189
action_187 (119) = happyShift action_190
action_187 (125) = happyShift action_2
action_187 (126) = happyShift action_191
action_187 (129) = happyShift action_9
action_187 (130) = happyShift action_34
action_187 (131) = happyShift action_192
action_187 (4) = happyGoto action_165
action_187 (5) = happyGoto action_166
action_187 (8) = happyGoto action_167
action_187 (9) = happyGoto action_168
action_187 (10) = happyGoto action_169
action_187 (50) = happyGoto action_194
action_187 (55) = happyGoto action_171
action_187 (58) = happyGoto action_172
action_187 (61) = happyGoto action_173
action_187 (62) = happyGoto action_174
action_187 (63) = happyGoto action_175
action_187 (64) = happyGoto action_176
action_187 (65) = happyGoto action_177
action_187 (66) = happyGoto action_178
action_187 _ = happyFail (happyExpListPerState 187)

action_188 _ = happyReduce_120

action_189 _ = happyReduce_119

action_190 _ = happyReduce_157

action_191 _ = happyReduce_2

action_192 _ = happyReduce_7

action_193 _ = happyReduce_80

action_194 (122) = happyShift action_249
action_194 _ = happyFail (happyExpListPerState 194)

action_195 (117) = happyShift action_248
action_195 _ = happyFail (happyExpListPerState 195)

action_196 (93) = happyShift action_247
action_196 _ = happyFail (happyExpListPerState 196)

action_197 (106) = happyShift action_246
action_197 _ = happyFail (happyExpListPerState 197)

action_198 (67) = happyShift action_179
action_198 (68) = happyShift action_180
action_198 (69) = happyShift action_181
action_198 (87) = happyShift action_182
action_198 (91) = happyShift action_183
action_198 (95) = happyShift action_184
action_198 (98) = happyShift action_185
action_198 (102) = happyShift action_186
action_198 (109) = happyShift action_187
action_198 (115) = happyShift action_188
action_198 (118) = happyShift action_189
action_198 (119) = happyShift action_190
action_198 (125) = happyShift action_2
action_198 (126) = happyShift action_191
action_198 (129) = happyShift action_9
action_198 (130) = happyShift action_34
action_198 (131) = happyShift action_192
action_198 (4) = happyGoto action_165
action_198 (5) = happyGoto action_166
action_198 (8) = happyGoto action_167
action_198 (9) = happyGoto action_168
action_198 (10) = happyGoto action_169
action_198 (50) = happyGoto action_196
action_198 (51) = happyGoto action_244
action_198 (52) = happyGoto action_245
action_198 (55) = happyGoto action_171
action_198 (58) = happyGoto action_172
action_198 (61) = happyGoto action_173
action_198 (62) = happyGoto action_174
action_198 (63) = happyGoto action_175
action_198 (64) = happyGoto action_176
action_198 (65) = happyGoto action_177
action_198 (66) = happyGoto action_178
action_198 _ = happyReduce_112

action_199 _ = happyReduce_132

action_200 (73) = happyShift action_243
action_200 _ = happyReduce_134

action_201 (89) = happyShift action_242
action_201 _ = happyFail (happyExpListPerState 201)

action_202 (70) = happyShift action_241
action_202 _ = happyFail (happyExpListPerState 202)

action_203 (70) = happyShift action_240
action_203 _ = happyFail (happyExpListPerState 203)

action_204 (70) = happyShift action_239
action_204 _ = happyReduce_131

action_205 (69) = happyShift action_150
action_205 (130) = happyShift action_34
action_205 (9) = happyGoto action_147
action_205 (24) = happyGoto action_238
action_205 (25) = happyGoto action_149
action_205 _ = happyFail (happyExpListPerState 205)

action_206 (68) = happyShift action_237
action_206 _ = happyFail (happyExpListPerState 206)

action_207 _ = happyReduce_3

action_208 (67) = happyShift action_236
action_208 _ = happyFail (happyExpListPerState 208)

action_209 _ = happyReduce_4

action_210 (67) = happyShift action_179
action_210 (68) = happyShift action_180
action_210 (69) = happyShift action_225
action_210 (91) = happyShift action_183
action_210 (98) = happyShift action_185
action_210 (115) = happyShift action_188
action_210 (118) = happyShift action_189
action_210 (119) = happyShift action_190
action_210 (125) = happyShift action_2
action_210 (126) = happyShift action_191
action_210 (129) = happyShift action_9
action_210 (130) = happyShift action_34
action_210 (131) = happyShift action_192
action_210 (4) = happyGoto action_165
action_210 (5) = happyGoto action_166
action_210 (8) = happyGoto action_167
action_210 (9) = happyGoto action_168
action_210 (10) = happyGoto action_169
action_210 (55) = happyGoto action_171
action_210 (58) = happyGoto action_172
action_210 (64) = happyGoto action_235
action_210 (65) = happyGoto action_177
action_210 (66) = happyGoto action_178
action_210 _ = happyFail (happyExpListPerState 210)

action_211 (67) = happyShift action_179
action_211 (68) = happyShift action_180
action_211 (69) = happyShift action_225
action_211 (91) = happyShift action_183
action_211 (98) = happyShift action_185
action_211 (115) = happyShift action_188
action_211 (118) = happyShift action_189
action_211 (119) = happyShift action_190
action_211 (125) = happyShift action_2
action_211 (126) = happyShift action_191
action_211 (129) = happyShift action_9
action_211 (130) = happyShift action_34
action_211 (131) = happyShift action_192
action_211 (4) = happyGoto action_165
action_211 (5) = happyGoto action_166
action_211 (8) = happyGoto action_167
action_211 (9) = happyGoto action_168
action_211 (10) = happyGoto action_169
action_211 (55) = happyGoto action_171
action_211 (58) = happyGoto action_172
action_211 (64) = happyGoto action_234
action_211 (65) = happyGoto action_177
action_211 (66) = happyGoto action_178
action_211 _ = happyFail (happyExpListPerState 211)

action_212 (67) = happyShift action_179
action_212 (68) = happyShift action_180
action_212 (69) = happyShift action_225
action_212 (91) = happyShift action_183
action_212 (98) = happyShift action_185
action_212 (115) = happyShift action_188
action_212 (118) = happyShift action_189
action_212 (119) = happyShift action_190
action_212 (125) = happyShift action_2
action_212 (126) = happyShift action_191
action_212 (129) = happyShift action_9
action_212 (130) = happyShift action_34
action_212 (131) = happyShift action_192
action_212 (4) = happyGoto action_165
action_212 (5) = happyGoto action_166
action_212 (8) = happyGoto action_167
action_212 (9) = happyGoto action_168
action_212 (10) = happyGoto action_169
action_212 (55) = happyGoto action_171
action_212 (58) = happyGoto action_172
action_212 (63) = happyGoto action_233
action_212 (64) = happyGoto action_176
action_212 (65) = happyGoto action_177
action_212 (66) = happyGoto action_178
action_212 _ = happyFail (happyExpListPerState 212)

action_213 (67) = happyShift action_179
action_213 (68) = happyShift action_180
action_213 (69) = happyShift action_225
action_213 (91) = happyShift action_183
action_213 (98) = happyShift action_185
action_213 (115) = happyShift action_188
action_213 (118) = happyShift action_189
action_213 (119) = happyShift action_190
action_213 (125) = happyShift action_2
action_213 (126) = happyShift action_191
action_213 (129) = happyShift action_9
action_213 (130) = happyShift action_34
action_213 (131) = happyShift action_192
action_213 (4) = happyGoto action_165
action_213 (5) = happyGoto action_166
action_213 (8) = happyGoto action_167
action_213 (9) = happyGoto action_168
action_213 (10) = happyGoto action_169
action_213 (55) = happyGoto action_171
action_213 (58) = happyGoto action_172
action_213 (63) = happyGoto action_232
action_213 (64) = happyGoto action_176
action_213 (65) = happyGoto action_177
action_213 (66) = happyGoto action_178
action_213 _ = happyFail (happyExpListPerState 213)

action_214 (67) = happyShift action_179
action_214 (68) = happyShift action_180
action_214 (69) = happyShift action_225
action_214 (91) = happyShift action_183
action_214 (98) = happyShift action_185
action_214 (115) = happyShift action_188
action_214 (118) = happyShift action_189
action_214 (119) = happyShift action_190
action_214 (125) = happyShift action_2
action_214 (126) = happyShift action_191
action_214 (129) = happyShift action_9
action_214 (130) = happyShift action_34
action_214 (131) = happyShift action_192
action_214 (4) = happyGoto action_165
action_214 (5) = happyGoto action_166
action_214 (8) = happyGoto action_167
action_214 (9) = happyGoto action_168
action_214 (10) = happyGoto action_169
action_214 (55) = happyGoto action_171
action_214 (58) = happyGoto action_172
action_214 (62) = happyGoto action_231
action_214 (63) = happyGoto action_175
action_214 (64) = happyGoto action_176
action_214 (65) = happyGoto action_177
action_214 (66) = happyGoto action_178
action_214 _ = happyFail (happyExpListPerState 214)

action_215 (67) = happyShift action_179
action_215 (68) = happyShift action_180
action_215 (69) = happyShift action_225
action_215 (91) = happyShift action_183
action_215 (98) = happyShift action_185
action_215 (115) = happyShift action_188
action_215 (118) = happyShift action_189
action_215 (119) = happyShift action_190
action_215 (125) = happyShift action_2
action_215 (126) = happyShift action_191
action_215 (129) = happyShift action_9
action_215 (130) = happyShift action_34
action_215 (131) = happyShift action_192
action_215 (4) = happyGoto action_165
action_215 (5) = happyGoto action_166
action_215 (8) = happyGoto action_167
action_215 (9) = happyGoto action_168
action_215 (10) = happyGoto action_169
action_215 (55) = happyGoto action_171
action_215 (58) = happyGoto action_172
action_215 (62) = happyGoto action_230
action_215 (63) = happyGoto action_175
action_215 (64) = happyGoto action_176
action_215 (65) = happyGoto action_177
action_215 (66) = happyGoto action_178
action_215 _ = happyFail (happyExpListPerState 215)

action_216 (67) = happyShift action_179
action_216 (68) = happyShift action_180
action_216 (69) = happyShift action_225
action_216 (91) = happyShift action_183
action_216 (98) = happyShift action_185
action_216 (115) = happyShift action_188
action_216 (118) = happyShift action_189
action_216 (119) = happyShift action_190
action_216 (125) = happyShift action_2
action_216 (126) = happyShift action_191
action_216 (129) = happyShift action_9
action_216 (130) = happyShift action_34
action_216 (131) = happyShift action_192
action_216 (4) = happyGoto action_165
action_216 (5) = happyGoto action_166
action_216 (8) = happyGoto action_167
action_216 (9) = happyGoto action_168
action_216 (10) = happyGoto action_169
action_216 (55) = happyGoto action_171
action_216 (58) = happyGoto action_172
action_216 (62) = happyGoto action_229
action_216 (63) = happyGoto action_175
action_216 (64) = happyGoto action_176
action_216 (65) = happyGoto action_177
action_216 (66) = happyGoto action_178
action_216 _ = happyFail (happyExpListPerState 216)

action_217 (67) = happyShift action_179
action_217 (68) = happyShift action_180
action_217 (69) = happyShift action_225
action_217 (91) = happyShift action_183
action_217 (98) = happyShift action_185
action_217 (115) = happyShift action_188
action_217 (118) = happyShift action_189
action_217 (119) = happyShift action_190
action_217 (125) = happyShift action_2
action_217 (126) = happyShift action_191
action_217 (129) = happyShift action_9
action_217 (130) = happyShift action_34
action_217 (131) = happyShift action_192
action_217 (4) = happyGoto action_165
action_217 (5) = happyGoto action_166
action_217 (8) = happyGoto action_167
action_217 (9) = happyGoto action_168
action_217 (10) = happyGoto action_169
action_217 (55) = happyGoto action_171
action_217 (58) = happyGoto action_172
action_217 (62) = happyGoto action_228
action_217 (63) = happyGoto action_175
action_217 (64) = happyGoto action_176
action_217 (65) = happyGoto action_177
action_217 (66) = happyGoto action_178
action_217 _ = happyFail (happyExpListPerState 217)

action_218 (67) = happyShift action_179
action_218 (68) = happyShift action_180
action_218 (69) = happyShift action_225
action_218 (91) = happyShift action_183
action_218 (98) = happyShift action_185
action_218 (115) = happyShift action_188
action_218 (118) = happyShift action_189
action_218 (119) = happyShift action_190
action_218 (125) = happyShift action_2
action_218 (126) = happyShift action_191
action_218 (129) = happyShift action_9
action_218 (130) = happyShift action_34
action_218 (131) = happyShift action_192
action_218 (4) = happyGoto action_165
action_218 (5) = happyGoto action_166
action_218 (8) = happyGoto action_167
action_218 (9) = happyGoto action_168
action_218 (10) = happyGoto action_169
action_218 (55) = happyGoto action_171
action_218 (58) = happyGoto action_172
action_218 (62) = happyGoto action_227
action_218 (63) = happyGoto action_175
action_218 (64) = happyGoto action_176
action_218 (65) = happyGoto action_177
action_218 (66) = happyGoto action_178
action_218 _ = happyFail (happyExpListPerState 218)

action_219 (67) = happyShift action_179
action_219 (68) = happyShift action_180
action_219 (69) = happyShift action_225
action_219 (91) = happyShift action_183
action_219 (98) = happyShift action_185
action_219 (115) = happyShift action_188
action_219 (118) = happyShift action_189
action_219 (119) = happyShift action_190
action_219 (125) = happyShift action_2
action_219 (126) = happyShift action_191
action_219 (129) = happyShift action_9
action_219 (130) = happyShift action_34
action_219 (131) = happyShift action_192
action_219 (4) = happyGoto action_165
action_219 (5) = happyGoto action_166
action_219 (8) = happyGoto action_167
action_219 (9) = happyGoto action_168
action_219 (10) = happyGoto action_169
action_219 (55) = happyGoto action_171
action_219 (58) = happyGoto action_172
action_219 (64) = happyGoto action_226
action_219 (65) = happyGoto action_177
action_219 (66) = happyGoto action_178
action_219 _ = happyFail (happyExpListPerState 219)

action_220 (67) = happyShift action_179
action_220 (68) = happyShift action_180
action_220 (69) = happyShift action_225
action_220 (91) = happyShift action_183
action_220 (98) = happyShift action_185
action_220 (115) = happyShift action_188
action_220 (118) = happyShift action_189
action_220 (119) = happyShift action_190
action_220 (125) = happyShift action_2
action_220 (126) = happyShift action_191
action_220 (129) = happyShift action_9
action_220 (130) = happyShift action_34
action_220 (131) = happyShift action_192
action_220 (4) = happyGoto action_165
action_220 (5) = happyGoto action_166
action_220 (8) = happyGoto action_167
action_220 (9) = happyGoto action_168
action_220 (10) = happyGoto action_169
action_220 (55) = happyGoto action_222
action_220 (56) = happyGoto action_223
action_220 (65) = happyGoto action_224
action_220 (66) = happyGoto action_178
action_220 _ = happyReduce_130

action_221 _ = happyReduce_40

action_222 _ = happyReduce_127

action_223 _ = happyReduce_129

action_224 _ = happyReduce_126

action_225 (67) = happyShift action_179
action_225 (68) = happyShift action_180
action_225 (69) = happyShift action_181
action_225 (71) = happyShift action_132
action_225 (72) = happyShift action_133
action_225 (74) = happyShift action_134
action_225 (76) = happyShift action_135
action_225 (79) = happyShift action_136
action_225 (80) = happyShift action_137
action_225 (82) = happyShift action_138
action_225 (84) = happyShift action_139
action_225 (85) = happyShift action_140
action_225 (87) = happyShift action_182
action_225 (90) = happyShift action_141
action_225 (91) = happyShift action_183
action_225 (95) = happyShift action_184
action_225 (98) = happyShift action_185
action_225 (102) = happyShift action_186
action_225 (109) = happyShift action_187
action_225 (115) = happyShift action_188
action_225 (118) = happyShift action_189
action_225 (119) = happyShift action_190
action_225 (125) = happyShift action_2
action_225 (126) = happyShift action_191
action_225 (129) = happyShift action_9
action_225 (130) = happyShift action_34
action_225 (131) = happyShift action_192
action_225 (4) = happyGoto action_165
action_225 (5) = happyGoto action_166
action_225 (8) = happyGoto action_167
action_225 (9) = happyGoto action_168
action_225 (10) = happyGoto action_169
action_225 (39) = happyGoto action_202
action_225 (50) = happyGoto action_203
action_225 (55) = happyGoto action_171
action_225 (58) = happyGoto action_172
action_225 (61) = happyGoto action_173
action_225 (62) = happyGoto action_174
action_225 (63) = happyGoto action_175
action_225 (64) = happyGoto action_176
action_225 (65) = happyGoto action_204
action_225 (66) = happyGoto action_178
action_225 _ = happyFail (happyExpListPerState 225)

action_226 _ = happyReduce_148

action_227 (72) = happyShift action_212
action_227 (74) = happyShift action_213
action_227 _ = happyReduce_136

action_228 (72) = happyShift action_212
action_228 (74) = happyShift action_213
action_228 _ = happyReduce_140

action_229 (72) = happyShift action_212
action_229 (74) = happyShift action_213
action_229 _ = happyReduce_138

action_230 (72) = happyShift action_212
action_230 (74) = happyShift action_213
action_230 _ = happyReduce_139

action_231 (72) = happyShift action_212
action_231 (74) = happyShift action_213
action_231 _ = happyReduce_137

action_232 (71) = happyShift action_210
action_232 (76) = happyShift action_211
action_232 _ = happyReduce_143

action_233 (71) = happyShift action_210
action_233 (76) = happyShift action_211
action_233 _ = happyReduce_142

action_234 _ = happyReduce_146

action_235 _ = happyReduce_145

action_236 _ = happyReduce_154

action_237 _ = happyReduce_153

action_238 (77) = happyShift action_257
action_238 _ = happyFail (happyExpListPerState 238)

action_239 _ = happyReduce_125

action_240 _ = happyReduce_156

action_241 _ = happyReduce_124

action_242 _ = happyReduce_110

action_243 (67) = happyShift action_179
action_243 (68) = happyShift action_180
action_243 (69) = happyShift action_181
action_243 (87) = happyShift action_182
action_243 (91) = happyShift action_183
action_243 (95) = happyShift action_184
action_243 (98) = happyShift action_185
action_243 (102) = happyShift action_186
action_243 (109) = happyShift action_187
action_243 (115) = happyShift action_188
action_243 (118) = happyShift action_189
action_243 (119) = happyShift action_190
action_243 (125) = happyShift action_2
action_243 (126) = happyShift action_191
action_243 (129) = happyShift action_9
action_243 (130) = happyShift action_34
action_243 (131) = happyShift action_192
action_243 (4) = happyGoto action_165
action_243 (5) = happyGoto action_166
action_243 (8) = happyGoto action_167
action_243 (9) = happyGoto action_168
action_243 (10) = happyGoto action_169
action_243 (50) = happyGoto action_199
action_243 (55) = happyGoto action_171
action_243 (58) = happyGoto action_172
action_243 (59) = happyGoto action_200
action_243 (60) = happyGoto action_256
action_243 (61) = happyGoto action_173
action_243 (62) = happyGoto action_174
action_243 (63) = happyGoto action_175
action_243 (64) = happyGoto action_176
action_243 (65) = happyGoto action_177
action_243 (66) = happyGoto action_178
action_243 _ = happyReduce_133

action_244 (124) = happyShift action_255
action_244 _ = happyFail (happyExpListPerState 244)

action_245 (78) = happyShift action_254
action_245 _ = happyReduce_113

action_246 (67) = happyShift action_179
action_246 (68) = happyShift action_180
action_246 (69) = happyShift action_181
action_246 (87) = happyShift action_182
action_246 (91) = happyShift action_183
action_246 (95) = happyShift action_184
action_246 (98) = happyShift action_185
action_246 (102) = happyShift action_186
action_246 (109) = happyShift action_187
action_246 (115) = happyShift action_188
action_246 (118) = happyShift action_189
action_246 (119) = happyShift action_190
action_246 (125) = happyShift action_2
action_246 (126) = happyShift action_191
action_246 (129) = happyShift action_9
action_246 (130) = happyShift action_34
action_246 (131) = happyShift action_192
action_246 (4) = happyGoto action_165
action_246 (5) = happyGoto action_166
action_246 (8) = happyGoto action_167
action_246 (9) = happyGoto action_168
action_246 (10) = happyGoto action_169
action_246 (50) = happyGoto action_253
action_246 (55) = happyGoto action_171
action_246 (58) = happyGoto action_172
action_246 (61) = happyGoto action_173
action_246 (62) = happyGoto action_174
action_246 (63) = happyGoto action_175
action_246 (64) = happyGoto action_176
action_246 (65) = happyGoto action_177
action_246 (66) = happyGoto action_178
action_246 _ = happyFail (happyExpListPerState 246)

action_247 (130) = happyShift action_34
action_247 (9) = happyGoto action_252
action_247 _ = happyFail (happyExpListPerState 247)

action_248 (67) = happyShift action_179
action_248 (68) = happyShift action_180
action_248 (69) = happyShift action_181
action_248 (87) = happyShift action_182
action_248 (91) = happyShift action_183
action_248 (95) = happyShift action_184
action_248 (98) = happyShift action_185
action_248 (102) = happyShift action_186
action_248 (109) = happyShift action_187
action_248 (115) = happyShift action_188
action_248 (118) = happyShift action_189
action_248 (119) = happyShift action_190
action_248 (125) = happyShift action_2
action_248 (126) = happyShift action_191
action_248 (129) = happyShift action_9
action_248 (130) = happyShift action_34
action_248 (131) = happyShift action_192
action_248 (4) = happyGoto action_165
action_248 (5) = happyGoto action_166
action_248 (8) = happyGoto action_167
action_248 (9) = happyGoto action_168
action_248 (10) = happyGoto action_169
action_248 (50) = happyGoto action_251
action_248 (55) = happyGoto action_171
action_248 (58) = happyGoto action_172
action_248 (61) = happyGoto action_173
action_248 (62) = happyGoto action_174
action_248 (63) = happyGoto action_175
action_248 (64) = happyGoto action_176
action_248 (65) = happyGoto action_177
action_248 (66) = happyGoto action_178
action_248 _ = happyFail (happyExpListPerState 248)

action_249 (123) = happyShift action_250
action_249 _ = happyFail (happyExpListPerState 249)

action_250 (67) = happyShift action_179
action_250 (68) = happyShift action_180
action_250 (69) = happyShift action_181
action_250 (87) = happyShift action_182
action_250 (91) = happyShift action_183
action_250 (95) = happyShift action_184
action_250 (98) = happyShift action_185
action_250 (102) = happyShift action_186
action_250 (109) = happyShift action_187
action_250 (115) = happyShift action_188
action_250 (118) = happyShift action_189
action_250 (119) = happyShift action_190
action_250 (125) = happyShift action_2
action_250 (126) = happyShift action_191
action_250 (129) = happyShift action_9
action_250 (130) = happyShift action_34
action_250 (131) = happyShift action_192
action_250 (4) = happyGoto action_165
action_250 (5) = happyGoto action_166
action_250 (8) = happyGoto action_167
action_250 (9) = happyGoto action_168
action_250 (10) = happyGoto action_169
action_250 (50) = happyGoto action_262
action_250 (53) = happyGoto action_263
action_250 (54) = happyGoto action_264
action_250 (55) = happyGoto action_171
action_250 (58) = happyGoto action_172
action_250 (61) = happyGoto action_173
action_250 (62) = happyGoto action_174
action_250 (63) = happyGoto action_175
action_250 (64) = happyGoto action_176
action_250 (65) = happyGoto action_177
action_250 (66) = happyGoto action_178
action_250 _ = happyFail (happyExpListPerState 250)

action_251 (97) = happyShift action_261
action_251 _ = happyFail (happyExpListPerState 251)

action_252 _ = happyReduce_115

action_253 _ = happyReduce_106

action_254 (67) = happyShift action_179
action_254 (68) = happyShift action_180
action_254 (69) = happyShift action_181
action_254 (87) = happyShift action_182
action_254 (91) = happyShift action_183
action_254 (95) = happyShift action_184
action_254 (98) = happyShift action_185
action_254 (102) = happyShift action_186
action_254 (109) = happyShift action_187
action_254 (115) = happyShift action_188
action_254 (118) = happyShift action_189
action_254 (119) = happyShift action_190
action_254 (125) = happyShift action_2
action_254 (126) = happyShift action_191
action_254 (129) = happyShift action_9
action_254 (130) = happyShift action_34
action_254 (131) = happyShift action_192
action_254 (4) = happyGoto action_165
action_254 (5) = happyGoto action_166
action_254 (8) = happyGoto action_167
action_254 (9) = happyGoto action_168
action_254 (10) = happyGoto action_169
action_254 (50) = happyGoto action_196
action_254 (51) = happyGoto action_260
action_254 (52) = happyGoto action_245
action_254 (55) = happyGoto action_171
action_254 (58) = happyGoto action_172
action_254 (61) = happyGoto action_173
action_254 (62) = happyGoto action_174
action_254 (63) = happyGoto action_175
action_254 (64) = happyGoto action_176
action_254 (65) = happyGoto action_177
action_254 (66) = happyGoto action_178
action_254 _ = happyReduce_112

action_255 (106) = happyShift action_259
action_255 _ = happyFail (happyExpListPerState 255)

action_256 _ = happyReduce_135

action_257 (69) = happyShift action_89
action_257 (129) = happyShift action_9
action_257 (130) = happyShift action_34
action_257 (8) = happyGoto action_84
action_257 (9) = happyGoto action_85
action_257 (17) = happyGoto action_258
action_257 (18) = happyGoto action_87
action_257 _ = happyFail (happyExpListPerState 257)

action_258 (83) = happyShift action_270
action_258 _ = happyFail (happyExpListPerState 258)

action_259 (67) = happyShift action_179
action_259 (68) = happyShift action_180
action_259 (69) = happyShift action_181
action_259 (87) = happyShift action_182
action_259 (91) = happyShift action_183
action_259 (95) = happyShift action_184
action_259 (98) = happyShift action_185
action_259 (102) = happyShift action_186
action_259 (109) = happyShift action_187
action_259 (115) = happyShift action_188
action_259 (118) = happyShift action_189
action_259 (119) = happyShift action_190
action_259 (125) = happyShift action_2
action_259 (126) = happyShift action_191
action_259 (129) = happyShift action_9
action_259 (130) = happyShift action_34
action_259 (131) = happyShift action_192
action_259 (4) = happyGoto action_165
action_259 (5) = happyGoto action_166
action_259 (8) = happyGoto action_167
action_259 (9) = happyGoto action_168
action_259 (10) = happyGoto action_169
action_259 (50) = happyGoto action_269
action_259 (55) = happyGoto action_171
action_259 (58) = happyGoto action_172
action_259 (61) = happyGoto action_173
action_259 (62) = happyGoto action_174
action_259 (63) = happyGoto action_175
action_259 (64) = happyGoto action_176
action_259 (65) = happyGoto action_177
action_259 (66) = happyGoto action_178
action_259 _ = happyFail (happyExpListPerState 259)

action_260 _ = happyReduce_114

action_261 (67) = happyShift action_179
action_261 (68) = happyShift action_180
action_261 (69) = happyShift action_181
action_261 (87) = happyShift action_182
action_261 (91) = happyShift action_183
action_261 (95) = happyShift action_184
action_261 (98) = happyShift action_185
action_261 (102) = happyShift action_186
action_261 (109) = happyShift action_187
action_261 (115) = happyShift action_188
action_261 (118) = happyShift action_189
action_261 (119) = happyShift action_190
action_261 (125) = happyShift action_2
action_261 (126) = happyShift action_191
action_261 (129) = happyShift action_9
action_261 (130) = happyShift action_34
action_261 (131) = happyShift action_192
action_261 (4) = happyGoto action_165
action_261 (5) = happyGoto action_166
action_261 (8) = happyGoto action_167
action_261 (9) = happyGoto action_168
action_261 (10) = happyGoto action_169
action_261 (50) = happyGoto action_268
action_261 (55) = happyGoto action_171
action_261 (58) = happyGoto action_172
action_261 (61) = happyGoto action_173
action_261 (62) = happyGoto action_174
action_261 (63) = happyGoto action_175
action_261 (64) = happyGoto action_176
action_261 (65) = happyGoto action_177
action_261 (66) = happyGoto action_178
action_261 _ = happyFail (happyExpListPerState 261)

action_262 (75) = happyShift action_267
action_262 _ = happyFail (happyExpListPerState 262)

action_263 (124) = happyShift action_266
action_263 _ = happyFail (happyExpListPerState 263)

action_264 (78) = happyShift action_265
action_264 _ = happyReduce_116

action_265 (67) = happyShift action_179
action_265 (68) = happyShift action_180
action_265 (69) = happyShift action_181
action_265 (87) = happyShift action_182
action_265 (91) = happyShift action_183
action_265 (95) = happyShift action_184
action_265 (98) = happyShift action_185
action_265 (102) = happyShift action_186
action_265 (109) = happyShift action_187
action_265 (115) = happyShift action_188
action_265 (118) = happyShift action_189
action_265 (119) = happyShift action_190
action_265 (125) = happyShift action_2
action_265 (126) = happyShift action_191
action_265 (129) = happyShift action_9
action_265 (130) = happyShift action_34
action_265 (131) = happyShift action_192
action_265 (4) = happyGoto action_165
action_265 (5) = happyGoto action_166
action_265 (8) = happyGoto action_167
action_265 (9) = happyGoto action_168
action_265 (10) = happyGoto action_169
action_265 (50) = happyGoto action_262
action_265 (53) = happyGoto action_273
action_265 (54) = happyGoto action_264
action_265 (55) = happyGoto action_171
action_265 (58) = happyGoto action_172
action_265 (61) = happyGoto action_173
action_265 (62) = happyGoto action_174
action_265 (63) = happyGoto action_175
action_265 (64) = happyGoto action_176
action_265 (65) = happyGoto action_177
action_265 (66) = happyGoto action_178
action_265 _ = happyFail (happyExpListPerState 265)

action_266 _ = happyReduce_107

action_267 (67) = happyShift action_179
action_267 (68) = happyShift action_180
action_267 (69) = happyShift action_181
action_267 (87) = happyShift action_182
action_267 (91) = happyShift action_183
action_267 (95) = happyShift action_184
action_267 (98) = happyShift action_185
action_267 (102) = happyShift action_186
action_267 (109) = happyShift action_187
action_267 (115) = happyShift action_188
action_267 (118) = happyShift action_189
action_267 (119) = happyShift action_190
action_267 (125) = happyShift action_2
action_267 (126) = happyShift action_191
action_267 (129) = happyShift action_9
action_267 (130) = happyShift action_34
action_267 (131) = happyShift action_192
action_267 (4) = happyGoto action_165
action_267 (5) = happyGoto action_166
action_267 (8) = happyGoto action_167
action_267 (9) = happyGoto action_168
action_267 (10) = happyGoto action_169
action_267 (50) = happyGoto action_272
action_267 (55) = happyGoto action_171
action_267 (58) = happyGoto action_172
action_267 (61) = happyGoto action_173
action_267 (62) = happyGoto action_174
action_267 (63) = happyGoto action_175
action_267 (64) = happyGoto action_176
action_267 (65) = happyGoto action_177
action_267 (66) = happyGoto action_178
action_267 _ = happyFail (happyExpListPerState 267)

action_268 _ = happyReduce_108

action_269 _ = happyReduce_105

action_270 (67) = happyShift action_179
action_270 (68) = happyShift action_180
action_270 (69) = happyShift action_181
action_270 (87) = happyShift action_182
action_270 (91) = happyShift action_183
action_270 (95) = happyShift action_184
action_270 (98) = happyShift action_185
action_270 (102) = happyShift action_186
action_270 (109) = happyShift action_187
action_270 (115) = happyShift action_188
action_270 (118) = happyShift action_189
action_270 (119) = happyShift action_190
action_270 (125) = happyShift action_2
action_270 (126) = happyShift action_191
action_270 (129) = happyShift action_9
action_270 (130) = happyShift action_34
action_270 (131) = happyShift action_192
action_270 (4) = happyGoto action_165
action_270 (5) = happyGoto action_166
action_270 (8) = happyGoto action_167
action_270 (9) = happyGoto action_168
action_270 (10) = happyGoto action_169
action_270 (50) = happyGoto action_271
action_270 (55) = happyGoto action_171
action_270 (58) = happyGoto action_172
action_270 (61) = happyGoto action_173
action_270 (62) = happyGoto action_174
action_270 (63) = happyGoto action_175
action_270 (64) = happyGoto action_176
action_270 (65) = happyGoto action_177
action_270 (66) = happyGoto action_178
action_270 _ = happyFail (happyExpListPerState 270)

action_271 (70) = happyShift action_274
action_271 _ = happyFail (happyExpListPerState 271)

action_272 _ = happyReduce_118

action_273 _ = happyReduce_117

action_274 _ = happyReduce_109

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
happyReduction_3 (HappyTerminal (PT _ (TC happy_var_1)))
	 =  HappyAbsSyn6
		 ((read ( happy_var_1)) :: Char
	)
happyReduction_3 _  = notHappyAtAll 

happyReduce_4 = happySpecReduce_1  7 happyReduction_4
happyReduction_4 (HappyTerminal (PT _ (TL happy_var_1)))
	 =  HappyAbsSyn7
		 (happy_var_1
	)
happyReduction_4 _  = notHappyAtAll 

happyReduce_5 = happySpecReduce_1  8 happyReduction_5
happyReduction_5 (HappyTerminal (PT _ (T_UIdent happy_var_1)))
	 =  HappyAbsSyn8
		 (UIdent (happy_var_1)
	)
happyReduction_5 _  = notHappyAtAll 

happyReduce_6 = happySpecReduce_1  9 happyReduction_6
happyReduction_6 (HappyTerminal (PT _ (T_LIdent happy_var_1)))
	 =  HappyAbsSyn9
		 (LIdent (happy_var_1)
	)
happyReduction_6 _  = notHappyAtAll 

happyReduce_7 = happySpecReduce_1  10 happyReduction_7
happyReduction_7 (HappyTerminal (PT _ (T_MFun happy_var_1)))
	 =  HappyAbsSyn10
		 (MFun (happy_var_1)
	)
happyReduction_7 _  = notHappyAtAll 

happyReduce_8 = happySpecReduce_2  11 happyReduction_8
happyReduction_8 (HappyAbsSyn12  happy_var_2)
	(HappyAbsSyn14  happy_var_1)
	 =  HappyAbsSyn11
		 (AbsVarg.Program (reverse happy_var_1) (reverse happy_var_2)
	)
happyReduction_8 _ _  = notHappyAtAll 

happyReduce_9 = happySpecReduce_0  12 happyReduction_9
happyReduction_9  =  HappyAbsSyn12
		 ([]
	)

happyReduce_10 = happySpecReduce_2  12 happyReduction_10
happyReduction_10 (HappyAbsSyn28  happy_var_2)
	(HappyAbsSyn12  happy_var_1)
	 =  HappyAbsSyn12
		 (flip (:) happy_var_1 happy_var_2
	)
happyReduction_10 _ _  = notHappyAtAll 

happyReduce_11 = happySpecReduce_3  13 happyReduction_11
happyReduction_11 _
	(HappyAbsSyn8  happy_var_2)
	_
	 =  HappyAbsSyn13
		 (AbsVarg.Import happy_var_2
	)
happyReduction_11 _ _ _  = notHappyAtAll 

happyReduce_12 = happySpecReduce_0  14 happyReduction_12
happyReduction_12  =  HappyAbsSyn14
		 ([]
	)

happyReduce_13 = happySpecReduce_2  14 happyReduction_13
happyReduction_13 (HappyAbsSyn13  happy_var_2)
	(HappyAbsSyn14  happy_var_1)
	 =  HappyAbsSyn14
		 (flip (:) happy_var_1 happy_var_2
	)
happyReduction_13 _ _  = notHappyAtAll 

happyReduce_14 = happySpecReduce_0  15 happyReduction_14
happyReduction_14  =  HappyAbsSyn15
		 ([]
	)

happyReduce_15 = happySpecReduce_2  15 happyReduction_15
happyReduction_15 (HappyAbsSyn16  happy_var_2)
	(HappyAbsSyn15  happy_var_1)
	 =  HappyAbsSyn15
		 (flip (:) happy_var_1 happy_var_2
	)
happyReduction_15 _ _  = notHappyAtAll 

happyReduce_16 = happySpecReduce_1  16 happyReduction_16
happyReduction_16 (HappyAbsSyn9  happy_var_1)
	 =  HappyAbsSyn16
		 (AbsVarg.InferredTypeParam happy_var_1
	)
happyReduction_16 _  = notHappyAtAll 

happyReduce_17 = happySpecReduce_1  16 happyReduction_17
happyReduction_17 (HappyAbsSyn8  happy_var_1)
	 =  HappyAbsSyn16
		 (AbsVarg.ConcreteTypeParam happy_var_1
	)
happyReduction_17 _  = notHappyAtAll 

happyReduce_18 = happySpecReduce_1  16 happyReduction_18
happyReduction_18 _
	 =  HappyAbsSyn16
		 (AbsVarg.WildcardTypeParam
	)

happyReduce_19 = happyReduce 5 16 happyReduction_19
happyReduction_19 (_ `HappyStk`
	(HappyAbsSyn19  happy_var_4) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn9  happy_var_2) `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn16
		 (AbsVarg.SuperConstrainedTypeParam happy_var_2 happy_var_4
	) `HappyStk` happyRest

happyReduce_20 = happyReduce 5 16 happyReduction_20
happyReduction_20 (_ `HappyStk`
	(HappyAbsSyn19  happy_var_4) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn16
		 (AbsVarg.AnySuperConstrainedTypeParam happy_var_4
	) `HappyStk` happyRest

happyReduce_21 = happyReduce 5 16 happyReduction_21
happyReduction_21 (_ `HappyStk`
	(HappyAbsSyn19  happy_var_4) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn9  happy_var_2) `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn16
		 (AbsVarg.DerivingConstrainedTypeParam happy_var_2 happy_var_4
	) `HappyStk` happyRest

happyReduce_22 = happyReduce 5 16 happyReduction_22
happyReduction_22 (_ `HappyStk`
	(HappyAbsSyn19  happy_var_4) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn16
		 (AbsVarg.AnyDerivingConstrainedTypeParam happy_var_4
	) `HappyStk` happyRest

happyReduce_23 = happySpecReduce_2  17 happyReduction_23
happyReduction_23 (HappyAbsSyn15  happy_var_2)
	(HappyAbsSyn8  happy_var_1)
	 =  HappyAbsSyn17
		 (AbsVarg.ConcreteType happy_var_1 (reverse happy_var_2)
	)
happyReduction_23 _ _  = notHappyAtAll 

happyReduce_24 = happySpecReduce_2  17 happyReduction_24
happyReduction_24 (HappyAbsSyn15  happy_var_2)
	(HappyAbsSyn9  happy_var_1)
	 =  HappyAbsSyn17
		 (AbsVarg.InferredType happy_var_1 (reverse happy_var_2)
	)
happyReduction_24 _ _  = notHappyAtAll 

happyReduce_25 = happySpecReduce_1  17 happyReduction_25
happyReduction_25 (HappyAbsSyn17  happy_var_1)
	 =  HappyAbsSyn17
		 (happy_var_1
	)
happyReduction_25 _  = notHappyAtAll 

happyReduce_26 = happySpecReduce_3  18 happyReduction_26
happyReduction_26 _
	(HappyAbsSyn17  happy_var_2)
	_
	 =  HappyAbsSyn17
		 (happy_var_2
	)
happyReduction_26 _ _ _  = notHappyAtAll 

happyReduce_27 = happySpecReduce_1  19 happyReduction_27
happyReduction_27 (HappyAbsSyn17  happy_var_1)
	 =  HappyAbsSyn19
		 ((:[]) happy_var_1
	)
happyReduction_27 _  = notHappyAtAll 

happyReduce_28 = happySpecReduce_3  19 happyReduction_28
happyReduction_28 (HappyAbsSyn19  happy_var_3)
	_
	(HappyAbsSyn17  happy_var_1)
	 =  HappyAbsSyn19
		 ((:) happy_var_1 happy_var_3
	)
happyReduction_28 _ _ _  = notHappyAtAll 

happyReduce_29 = happySpecReduce_3  20 happyReduction_29
happyReduction_29 _
	(HappyAbsSyn21  happy_var_2)
	_
	 =  HappyAbsSyn20
		 (AbsVarg.ConcreteTypeFreeType happy_var_2
	)
happyReduction_29 _ _ _  = notHappyAtAll 

happyReduce_30 = happySpecReduce_1  20 happyReduction_30
happyReduction_30 (HappyAbsSyn9  happy_var_1)
	 =  HappyAbsSyn20
		 (AbsVarg.TemplateFreeType happy_var_1
	)
happyReduction_30 _  = notHappyAtAll 

happyReduce_31 = happySpecReduce_1  20 happyReduction_31
happyReduction_31 (HappyAbsSyn8  happy_var_1)
	 =  HappyAbsSyn20
		 (AbsVarg.ConcreteFreeType happy_var_1
	)
happyReduction_31 _  = notHappyAtAll 

happyReduce_32 = happySpecReduce_2  21 happyReduction_32
happyReduction_32 (HappyAbsSyn23  happy_var_2)
	(HappyAbsSyn8  happy_var_1)
	 =  HappyAbsSyn21
		 (AbsVarg.FreeType happy_var_1 (reverse happy_var_2)
	)
happyReduction_32 _ _  = notHappyAtAll 

happyReduce_33 = happySpecReduce_2  21 happyReduction_33
happyReduction_33 (HappyAbsSyn23  happy_var_2)
	(HappyAbsSyn9  happy_var_1)
	 =  HappyAbsSyn21
		 (AbsVarg.InferredFreeType happy_var_1 (reverse happy_var_2)
	)
happyReduction_33 _ _  = notHappyAtAll 

happyReduce_34 = happySpecReduce_1  21 happyReduction_34
happyReduction_34 (HappyAbsSyn21  happy_var_1)
	 =  HappyAbsSyn21
		 (happy_var_1
	)
happyReduction_34 _  = notHappyAtAll 

happyReduce_35 = happySpecReduce_3  22 happyReduction_35
happyReduction_35 _
	(HappyAbsSyn21  happy_var_2)
	_
	 =  HappyAbsSyn21
		 (happy_var_2
	)
happyReduction_35 _ _ _  = notHappyAtAll 

happyReduce_36 = happySpecReduce_0  23 happyReduction_36
happyReduction_36  =  HappyAbsSyn23
		 ([]
	)

happyReduce_37 = happySpecReduce_2  23 happyReduction_37
happyReduction_37 (HappyAbsSyn20  happy_var_2)
	(HappyAbsSyn23  happy_var_1)
	 =  HappyAbsSyn23
		 (flip (:) happy_var_1 happy_var_2
	)
happyReduction_37 _ _  = notHappyAtAll 

happyReduce_38 = happySpecReduce_1  24 happyReduction_38
happyReduction_38 (HappyAbsSyn25  happy_var_1)
	 =  HappyAbsSyn24
		 ((:[]) happy_var_1
	)
happyReduction_38 _  = notHappyAtAll 

happyReduce_39 = happySpecReduce_2  24 happyReduction_39
happyReduction_39 (HappyAbsSyn24  happy_var_2)
	(HappyAbsSyn25  happy_var_1)
	 =  HappyAbsSyn24
		 ((:) happy_var_1 happy_var_2
	)
happyReduction_39 _ _  = notHappyAtAll 

happyReduce_40 = happyReduce 5 25 happyReduction_40
happyReduction_40 (_ `HappyStk`
	(HappyAbsSyn21  happy_var_4) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn9  happy_var_2) `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn25
		 (AbsVarg.ArgumentDefinition happy_var_2 happy_var_4
	) `HappyStk` happyRest

happyReduce_41 = happySpecReduce_1  25 happyReduction_41
happyReduction_41 (HappyAbsSyn9  happy_var_1)
	 =  HappyAbsSyn25
		 (AbsVarg.InferredArgumentDef happy_var_1
	)
happyReduction_41 _  = notHappyAtAll 

happyReduce_42 = happySpecReduce_1  26 happyReduction_42
happyReduction_42 (HappyAbsSyn21  happy_var_1)
	 =  HappyAbsSyn26
		 (AbsVarg.Superclass happy_var_1
	)
happyReduction_42 _  = notHappyAtAll 

happyReduce_43 = happySpecReduce_1  27 happyReduction_43
happyReduction_43 (HappyAbsSyn26  happy_var_1)
	 =  HappyAbsSyn27
		 ((:[]) happy_var_1
	)
happyReduction_43 _  = notHappyAtAll 

happyReduce_44 = happySpecReduce_3  27 happyReduction_44
happyReduction_44 (HappyAbsSyn27  happy_var_3)
	_
	(HappyAbsSyn26  happy_var_1)
	 =  HappyAbsSyn27
		 ((:) happy_var_1 happy_var_3
	)
happyReduction_44 _ _ _  = notHappyAtAll 

happyReduce_45 = happyReduce 7 28 happyReduction_45
happyReduction_45 (_ `HappyStk`
	(HappyAbsSyn48  happy_var_6) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn8  happy_var_3) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn31  happy_var_1) `HappyStk`
	happyRest)
	 = HappyAbsSyn28
		 (AbsVarg.StructDefinition (reverse happy_var_1) happy_var_3 happy_var_6
	) `HappyStk` happyRest

happyReduce_46 = happyReduce 9 28 happyReduction_46
happyReduction_46 (_ `HappyStk`
	(HappyAbsSyn33  happy_var_8) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn29  happy_var_5) `HappyStk`
	(HappyAbsSyn30  happy_var_4) `HappyStk`
	(HappyAbsSyn8  happy_var_3) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn31  happy_var_1) `HappyStk`
	happyRest)
	 = HappyAbsSyn28
		 (AbsVarg.ClassDefinition (reverse happy_var_1) happy_var_3 happy_var_4 happy_var_5 happy_var_8
	) `HappyStk` happyRest

happyReduce_47 = happyReduce 10 28 happyReduction_47
happyReduction_47 (_ `HappyStk`
	(HappyAbsSyn33  happy_var_9) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn29  happy_var_6) `HappyStk`
	(HappyAbsSyn30  happy_var_5) `HappyStk`
	(HappyAbsSyn15  happy_var_4) `HappyStk`
	(HappyAbsSyn8  happy_var_3) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn31  happy_var_1) `HappyStk`
	happyRest)
	 = HappyAbsSyn28
		 (AbsVarg.TemplateDefinition (reverse happy_var_1) happy_var_3 (reverse happy_var_4) happy_var_5 happy_var_6 happy_var_9
	) `HappyStk` happyRest

happyReduce_48 = happySpecReduce_2  29 happyReduction_48
happyReduction_48 (HappyAbsSyn27  happy_var_2)
	_
	 =  HappyAbsSyn29
		 (AbsVarg.Implementing happy_var_2
	)
happyReduction_48 _ _  = notHappyAtAll 

happyReduce_49 = happySpecReduce_0  29 happyReduction_49
happyReduction_49  =  HappyAbsSyn29
		 (AbsVarg.NotImplementing
	)

happyReduce_50 = happySpecReduce_2  30 happyReduction_50
happyReduction_50 (HappyAbsSyn26  happy_var_2)
	_
	 =  HappyAbsSyn30
		 (AbsVarg.Deriving happy_var_2
	)
happyReduction_50 _ _  = notHappyAtAll 

happyReduce_51 = happySpecReduce_0  30 happyReduction_51
happyReduction_51  =  HappyAbsSyn30
		 (AbsVarg.NotDeriving
	)

happyReduce_52 = happySpecReduce_0  31 happyReduction_52
happyReduction_52  =  HappyAbsSyn31
		 ([]
	)

happyReduce_53 = happySpecReduce_2  31 happyReduction_53
happyReduction_53 (HappyAbsSyn32  happy_var_2)
	(HappyAbsSyn31  happy_var_1)
	 =  HappyAbsSyn31
		 (flip (:) happy_var_1 happy_var_2
	)
happyReduction_53 _ _  = notHappyAtAll 

happyReduce_54 = happySpecReduce_1  32 happyReduction_54
happyReduction_54 _
	 =  HappyAbsSyn32
		 (AbsVarg.ClassModifier_module
	)

happyReduce_55 = happySpecReduce_1  32 happyReduction_55
happyReduction_55 _
	 =  HappyAbsSyn32
		 (AbsVarg.ClassModifier_interface
	)

happyReduce_56 = happySpecReduce_1  32 happyReduction_56
happyReduction_56 _
	 =  HappyAbsSyn32
		 (AbsVarg.ClassModifier_sealed
	)

happyReduce_57 = happySpecReduce_1  32 happyReduction_57
happyReduction_57 _
	 =  HappyAbsSyn32
		 (AbsVarg.ClassModifier_native
	)

happyReduce_58 = happySpecReduce_2  33 happyReduction_58
happyReduction_58 (HappyAbsSyn44  happy_var_2)
	(HappyAbsSyn35  happy_var_1)
	 =  HappyAbsSyn33
		 (AbsVarg.ClassContent happy_var_1 happy_var_2
	)
happyReduction_58 _ _  = notHappyAtAll 

happyReduce_59 = happySpecReduce_1  34 happyReduction_59
happyReduction_59 (HappyAbsSyn8  happy_var_1)
	 =  HappyAbsSyn34
		 (AbsVarg.EmptyMemberDefinition happy_var_1
	)
happyReduction_59 _  = notHappyAtAll 

happyReduce_60 = happyReduce 5 34 happyReduction_60
happyReduction_60 (_ `HappyStk`
	(HappyAbsSyn48  happy_var_4) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn8  happy_var_1) `HappyStk`
	happyRest)
	 = HappyAbsSyn34
		 (AbsVarg.MemberDefinition happy_var_1 happy_var_4
	) `HappyStk` happyRest

happyReduce_61 = happySpecReduce_0  35 happyReduction_61
happyReduction_61  =  HappyAbsSyn35
		 ([]
	)

happyReduce_62 = happySpecReduce_1  35 happyReduction_62
happyReduction_62 (HappyAbsSyn34  happy_var_1)
	 =  HappyAbsSyn35
		 ((:[]) happy_var_1
	)
happyReduction_62 _  = notHappyAtAll 

happyReduce_63 = happySpecReduce_3  35 happyReduction_63
happyReduction_63 (HappyAbsSyn35  happy_var_3)
	_
	(HappyAbsSyn34  happy_var_1)
	 =  HappyAbsSyn35
		 ((:) happy_var_1 happy_var_3
	)
happyReduction_63 _ _ _  = notHappyAtAll 

happyReduce_64 = happyReduce 8 36 happyReduction_64
happyReduction_64 ((HappyAbsSyn50  happy_var_8) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn37  happy_var_6) `HappyStk`
	(HappyAbsSyn24  happy_var_5) `HappyStk`
	(HappyAbsSyn41  happy_var_4) `HappyStk`
	(HappyAbsSyn38  happy_var_3) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn45  happy_var_1) `HappyStk`
	happyRest)
	 = HappyAbsSyn36
		 (AbsVarg.MemberFunctionDefinition (reverse happy_var_1) happy_var_3 happy_var_4 happy_var_5 happy_var_6 happy_var_8
	) `HappyStk` happyRest

happyReduce_65 = happyReduce 6 36 happyReduction_65
happyReduction_65 ((HappyAbsSyn40  happy_var_6) `HappyStk`
	(HappyAbsSyn24  happy_var_5) `HappyStk`
	(HappyAbsSyn41  happy_var_4) `HappyStk`
	(HappyAbsSyn38  happy_var_3) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn45  happy_var_1) `HappyStk`
	happyRest)
	 = HappyAbsSyn36
		 (AbsVarg.AbstractFunctionDefinition (reverse happy_var_1) happy_var_3 happy_var_4 happy_var_5 happy_var_6
	) `HappyStk` happyRest

happyReduce_66 = happySpecReduce_2  37 happyReduction_66
happyReduction_66 (HappyAbsSyn21  happy_var_2)
	_
	 =  HappyAbsSyn37
		 (AbsVarg.ReturnType happy_var_2
	)
happyReduction_66 _ _  = notHappyAtAll 

happyReduce_67 = happySpecReduce_0  37 happyReduction_67
happyReduction_67  =  HappyAbsSyn37
		 (AbsVarg.InferredReturnType
	)

happyReduce_68 = happySpecReduce_1  38 happyReduction_68
happyReduction_68 (HappyAbsSyn9  happy_var_1)
	 =  HappyAbsSyn38
		 (AbsVarg.FFunction happy_var_1
	)
happyReduction_68 _  = notHappyAtAll 

happyReduce_69 = happySpecReduce_3  38 happyReduction_69
happyReduction_69 _
	(HappyAbsSyn39  happy_var_2)
	_
	 =  HappyAbsSyn38
		 (AbsVarg.FOperator happy_var_2
	)
happyReduction_69 _ _ _  = notHappyAtAll 

happyReduce_70 = happySpecReduce_1  39 happyReduction_70
happyReduction_70 _
	 =  HappyAbsSyn39
		 (AbsVarg.Op_plus
	)

happyReduce_71 = happySpecReduce_1  39 happyReduction_71
happyReduction_71 _
	 =  HappyAbsSyn39
		 (AbsVarg.Op_minus
	)

happyReduce_72 = happySpecReduce_1  39 happyReduction_72
happyReduction_72 _
	 =  HappyAbsSyn39
		 (AbsVarg.Op_mul
	)

happyReduce_73 = happySpecReduce_1  39 happyReduction_73
happyReduction_73 _
	 =  HappyAbsSyn39
		 (AbsVarg.Op_div
	)

happyReduce_74 = happySpecReduce_1  39 happyReduction_74
happyReduction_74 _
	 =  HappyAbsSyn39
		 (AbsVarg.Op_pow
	)

happyReduce_75 = happySpecReduce_1  39 happyReduction_75
happyReduction_75 _
	 =  HappyAbsSyn39
		 (AbsVarg.Op_less
	)

happyReduce_76 = happySpecReduce_1  39 happyReduction_76
happyReduction_76 _
	 =  HappyAbsSyn39
		 (AbsVarg.Op_gr
	)

happyReduce_77 = happySpecReduce_1  39 happyReduction_77
happyReduction_77 _
	 =  HappyAbsSyn39
		 (AbsVarg.Op_leq
	)

happyReduce_78 = happySpecReduce_1  39 happyReduction_78
happyReduction_78 _
	 =  HappyAbsSyn39
		 (AbsVarg.Op_geq
	)

happyReduce_79 = happySpecReduce_1  39 happyReduction_79
happyReduction_79 _
	 =  HappyAbsSyn39
		 (AbsVarg.Op_eq
	)

happyReduce_80 = happySpecReduce_3  40 happyReduction_80
happyReduction_80 (HappyAbsSyn21  happy_var_3)
	_
	_
	 =  HappyAbsSyn40
		 (AbsVarg.AbsReturnType happy_var_3
	)
happyReduction_80 _ _ _  = notHappyAtAll 

happyReduce_81 = happySpecReduce_0  40 happyReduction_81
happyReduction_81  =  HappyAbsSyn40
		 (AbsVarg.AbsInferredReturnType
	)

happyReduce_82 = happySpecReduce_0  41 happyReduction_82
happyReduction_82  =  HappyAbsSyn41
		 (AbsVarg.NoFunctionTemplateParameter
	)

happyReduce_83 = happySpecReduce_3  41 happyReduction_83
happyReduction_83 _
	(HappyAbsSyn43  happy_var_2)
	_
	 =  HappyAbsSyn41
		 (AbsVarg.FunctionTemplateParameters happy_var_2
	)
happyReduction_83 _ _ _  = notHappyAtAll 

happyReduce_84 = happySpecReduce_1  42 happyReduction_84
happyReduction_84 (HappyAbsSyn16  happy_var_1)
	 =  HappyAbsSyn42
		 (AbsVarg.TemplateParameter happy_var_1
	)
happyReduction_84 _  = notHappyAtAll 

happyReduce_85 = happySpecReduce_1  43 happyReduction_85
happyReduction_85 (HappyAbsSyn42  happy_var_1)
	 =  HappyAbsSyn43
		 ((:[]) happy_var_1
	)
happyReduction_85 _  = notHappyAtAll 

happyReduce_86 = happySpecReduce_3  43 happyReduction_86
happyReduction_86 (HappyAbsSyn43  happy_var_3)
	_
	(HappyAbsSyn42  happy_var_1)
	 =  HappyAbsSyn43
		 ((:) happy_var_1 happy_var_3
	)
happyReduction_86 _ _ _  = notHappyAtAll 

happyReduce_87 = happySpecReduce_0  44 happyReduction_87
happyReduction_87  =  HappyAbsSyn44
		 ([]
	)

happyReduce_88 = happySpecReduce_1  44 happyReduction_88
happyReduction_88 (HappyAbsSyn36  happy_var_1)
	 =  HappyAbsSyn44
		 ((:[]) happy_var_1
	)
happyReduction_88 _  = notHappyAtAll 

happyReduce_89 = happySpecReduce_3  44 happyReduction_89
happyReduction_89 (HappyAbsSyn44  happy_var_3)
	_
	(HappyAbsSyn36  happy_var_1)
	 =  HappyAbsSyn44
		 ((:) happy_var_1 happy_var_3
	)
happyReduction_89 _ _ _  = notHappyAtAll 

happyReduce_90 = happySpecReduce_0  45 happyReduction_90
happyReduction_90  =  HappyAbsSyn45
		 ([]
	)

happyReduce_91 = happySpecReduce_2  45 happyReduction_91
happyReduction_91 (HappyAbsSyn46  happy_var_2)
	(HappyAbsSyn45  happy_var_1)
	 =  HappyAbsSyn45
		 (flip (:) happy_var_1 happy_var_2
	)
happyReduction_91 _ _  = notHappyAtAll 

happyReduce_92 = happySpecReduce_1  46 happyReduction_92
happyReduction_92 _
	 =  HappyAbsSyn46
		 (AbsVarg.FunctionModifier_static
	)

happyReduce_93 = happySpecReduce_1  46 happyReduction_93
happyReduction_93 _
	 =  HappyAbsSyn46
		 (AbsVarg.FunctionModifier_internal
	)

happyReduce_94 = happySpecReduce_1  46 happyReduction_94
happyReduction_94 _
	 =  HappyAbsSyn46
		 (AbsVarg.FunctionModifier_implement
	)

happyReduce_95 = happySpecReduce_1  46 happyReduction_95
happyReduction_95 _
	 =  HappyAbsSyn46
		 (AbsVarg.FunctionModifier_final
	)

happyReduce_96 = happySpecReduce_1  46 happyReduction_96
happyReduction_96 _
	 =  HappyAbsSyn46
		 (AbsVarg.FunctionModifier_unique
	)

happyReduce_97 = happySpecReduce_1  46 happyReduction_97
happyReduction_97 _
	 =  HappyAbsSyn46
		 (AbsVarg.FunctionModifier_native
	)

happyReduce_98 = happyReduce 4 47 happyReduction_98
happyReduction_98 ((HappyAbsSyn21  happy_var_4) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn9  happy_var_2) `HappyStk`
	(HappyAbsSyn49  happy_var_1) `HappyStk`
	happyRest)
	 = HappyAbsSyn47
		 (AbsVarg.ModifiedClassField happy_var_1 happy_var_2 happy_var_4
	) `HappyStk` happyRest

happyReduce_99 = happySpecReduce_3  47 happyReduction_99
happyReduction_99 (HappyAbsSyn21  happy_var_3)
	_
	(HappyAbsSyn9  happy_var_1)
	 =  HappyAbsSyn47
		 (AbsVarg.NormalClassField happy_var_1 happy_var_3
	)
happyReduction_99 _ _ _  = notHappyAtAll 

happyReduce_100 = happySpecReduce_0  48 happyReduction_100
happyReduction_100  =  HappyAbsSyn48
		 ([]
	)

happyReduce_101 = happySpecReduce_1  48 happyReduction_101
happyReduction_101 (HappyAbsSyn47  happy_var_1)
	 =  HappyAbsSyn48
		 ((:[]) happy_var_1
	)
happyReduction_101 _  = notHappyAtAll 

happyReduce_102 = happySpecReduce_3  48 happyReduction_102
happyReduction_102 (HappyAbsSyn48  happy_var_3)
	_
	(HappyAbsSyn47  happy_var_1)
	 =  HappyAbsSyn48
		 ((:) happy_var_1 happy_var_3
	)
happyReduction_102 _ _ _  = notHappyAtAll 

happyReduce_103 = happySpecReduce_1  49 happyReduction_103
happyReduction_103 _
	 =  HappyAbsSyn49
		 (AbsVarg.FieldModifier_internal
	)

happyReduce_104 = happySpecReduce_1  49 happyReduction_104
happyReduction_104 _
	 =  HappyAbsSyn49
		 (AbsVarg.FieldModifier_unique
	)

happyReduce_105 = happyReduce 6 50 happyReduction_105
happyReduction_105 ((HappyAbsSyn50  happy_var_6) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn51  happy_var_3) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn50
		 (AbsVarg.EDefinitionsList happy_var_3 happy_var_6
	) `HappyStk` happyRest

happyReduce_106 = happyReduce 4 50 happyReduction_106
happyReduction_106 ((HappyAbsSyn50  happy_var_4) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn52  happy_var_2) `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn50
		 (AbsVarg.EDefinition happy_var_2 happy_var_4
	) `HappyStk` happyRest

happyReduce_107 = happyReduce 6 50 happyReduction_107
happyReduction_107 (_ `HappyStk`
	(HappyAbsSyn53  happy_var_5) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn50  happy_var_2) `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn50
		 (AbsVarg.EMatch happy_var_2 happy_var_5
	) `HappyStk` happyRest

happyReduce_108 = happyReduce 6 50 happyReduction_108
happyReduction_108 ((HappyAbsSyn50  happy_var_6) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn50  happy_var_4) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn50  happy_var_2) `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn50
		 (AbsVarg.EIfThenElse happy_var_2 happy_var_4 happy_var_6
	) `HappyStk` happyRest

happyReduce_109 = happyReduce 8 50 happyReduction_109
happyReduction_109 (_ `HappyStk`
	(HappyAbsSyn50  happy_var_7) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn17  happy_var_5) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn24  happy_var_3) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn50
		 (AbsVarg.ELambda happy_var_3 happy_var_5 happy_var_7
	) `HappyStk` happyRest

happyReduce_110 = happySpecReduce_3  50 happyReduction_110
happyReduction_110 _
	(HappyAbsSyn60  happy_var_2)
	_
	 =  HappyAbsSyn50
		 (AbsVarg.EList happy_var_2
	)
happyReduction_110 _ _ _  = notHappyAtAll 

happyReduce_111 = happySpecReduce_1  50 happyReduction_111
happyReduction_111 (HappyAbsSyn50  happy_var_1)
	 =  HappyAbsSyn50
		 (happy_var_1
	)
happyReduction_111 _  = notHappyAtAll 

happyReduce_112 = happySpecReduce_0  51 happyReduction_112
happyReduction_112  =  HappyAbsSyn51
		 ([]
	)

happyReduce_113 = happySpecReduce_1  51 happyReduction_113
happyReduction_113 (HappyAbsSyn52  happy_var_1)
	 =  HappyAbsSyn51
		 ((:[]) happy_var_1
	)
happyReduction_113 _  = notHappyAtAll 

happyReduce_114 = happySpecReduce_3  51 happyReduction_114
happyReduction_114 (HappyAbsSyn51  happy_var_3)
	_
	(HappyAbsSyn52  happy_var_1)
	 =  HappyAbsSyn51
		 ((:) happy_var_1 happy_var_3
	)
happyReduction_114 _ _ _  = notHappyAtAll 

happyReduce_115 = happySpecReduce_3  52 happyReduction_115
happyReduction_115 (HappyAbsSyn9  happy_var_3)
	_
	(HappyAbsSyn50  happy_var_1)
	 =  HappyAbsSyn52
		 (AbsVarg.IDefinition happy_var_1 happy_var_3
	)
happyReduction_115 _ _ _  = notHappyAtAll 

happyReduce_116 = happySpecReduce_1  53 happyReduction_116
happyReduction_116 (HappyAbsSyn54  happy_var_1)
	 =  HappyAbsSyn53
		 ((:[]) happy_var_1
	)
happyReduction_116 _  = notHappyAtAll 

happyReduce_117 = happySpecReduce_3  53 happyReduction_117
happyReduction_117 (HappyAbsSyn53  happy_var_3)
	_
	(HappyAbsSyn54  happy_var_1)
	 =  HappyAbsSyn53
		 ((:) happy_var_1 happy_var_3
	)
happyReduction_117 _ _ _  = notHappyAtAll 

happyReduce_118 = happySpecReduce_3  54 happyReduction_118
happyReduction_118 (HappyAbsSyn50  happy_var_3)
	_
	(HappyAbsSyn50  happy_var_1)
	 =  HappyAbsSyn54
		 (AbsVarg.IMatchClause happy_var_1 happy_var_3
	)
happyReduction_118 _ _ _  = notHappyAtAll 

happyReduce_119 = happySpecReduce_1  55 happyReduction_119
happyReduction_119 _
	 =  HappyAbsSyn55
		 (AbsVarg.ThisFunctor
	)

happyReduce_120 = happySpecReduce_1  55 happyReduction_120
happyReduction_120 _
	 =  HappyAbsSyn55
		 (AbsVarg.SuperFunctor
	)

happyReduce_121 = happySpecReduce_1  55 happyReduction_121
happyReduction_121 (HappyAbsSyn8  happy_var_1)
	 =  HappyAbsSyn55
		 (AbsVarg.TypeFunctor happy_var_1
	)
happyReduction_121 _  = notHappyAtAll 

happyReduce_122 = happySpecReduce_1  55 happyReduction_122
happyReduction_122 (HappyAbsSyn9  happy_var_1)
	 =  HappyAbsSyn55
		 (AbsVarg.InstanceFunctor happy_var_1
	)
happyReduction_122 _  = notHappyAtAll 

happyReduce_123 = happySpecReduce_1  55 happyReduction_123
happyReduction_123 (HappyAbsSyn10  happy_var_1)
	 =  HappyAbsSyn55
		 (AbsVarg.MemberFunctor happy_var_1
	)
happyReduction_123 _  = notHappyAtAll 

happyReduce_124 = happySpecReduce_3  55 happyReduction_124
happyReduction_124 _
	(HappyAbsSyn39  happy_var_2)
	_
	 =  HappyAbsSyn55
		 (AbsVarg.OperatorFunctor happy_var_2
	)
happyReduction_124 _ _ _  = notHappyAtAll 

happyReduce_125 = happySpecReduce_3  55 happyReduction_125
happyReduction_125 _
	(HappyAbsSyn50  happy_var_2)
	_
	 =  HappyAbsSyn55
		 (AbsVarg.ExprFunctor happy_var_2
	)
happyReduction_125 _ _ _  = notHappyAtAll 

happyReduce_126 = happySpecReduce_1  56 happyReduction_126
happyReduction_126 (HappyAbsSyn50  happy_var_1)
	 =  HappyAbsSyn56
		 (AbsVarg.ArgExpr happy_var_1
	)
happyReduction_126 _  = notHappyAtAll 

happyReduce_127 = happySpecReduce_1  56 happyReduction_127
happyReduction_127 (HappyAbsSyn55  happy_var_1)
	 =  HappyAbsSyn56
		 (AbsVarg.ArgFunc happy_var_1
	)
happyReduction_127 _  = notHappyAtAll 

happyReduce_128 = happySpecReduce_0  57 happyReduction_128
happyReduction_128  =  HappyAbsSyn57
		 ([]
	)

happyReduce_129 = happySpecReduce_2  57 happyReduction_129
happyReduction_129 (HappyAbsSyn56  happy_var_2)
	(HappyAbsSyn57  happy_var_1)
	 =  HappyAbsSyn57
		 (flip (:) happy_var_1 happy_var_2
	)
happyReduction_129 _ _  = notHappyAtAll 

happyReduce_130 = happySpecReduce_2  58 happyReduction_130
happyReduction_130 (HappyAbsSyn57  happy_var_2)
	(HappyAbsSyn55  happy_var_1)
	 =  HappyAbsSyn50
		 (AbsVarg.EApply happy_var_1 (reverse happy_var_2)
	)
happyReduction_130 _ _  = notHappyAtAll 

happyReduce_131 = happySpecReduce_1  58 happyReduction_131
happyReduction_131 (HappyAbsSyn50  happy_var_1)
	 =  HappyAbsSyn50
		 (happy_var_1
	)
happyReduction_131 _  = notHappyAtAll 

happyReduce_132 = happySpecReduce_1  59 happyReduction_132
happyReduction_132 (HappyAbsSyn50  happy_var_1)
	 =  HappyAbsSyn59
		 (AbsVarg.EListElem happy_var_1
	)
happyReduction_132 _  = notHappyAtAll 

happyReduce_133 = happySpecReduce_0  60 happyReduction_133
happyReduction_133  =  HappyAbsSyn60
		 ([]
	)

happyReduce_134 = happySpecReduce_1  60 happyReduction_134
happyReduction_134 (HappyAbsSyn59  happy_var_1)
	 =  HappyAbsSyn60
		 ((:[]) happy_var_1
	)
happyReduction_134 _  = notHappyAtAll 

happyReduce_135 = happySpecReduce_3  60 happyReduction_135
happyReduction_135 (HappyAbsSyn60  happy_var_3)
	_
	(HappyAbsSyn59  happy_var_1)
	 =  HappyAbsSyn60
		 ((:) happy_var_1 happy_var_3
	)
happyReduction_135 _ _ _  = notHappyAtAll 

happyReduce_136 = happySpecReduce_3  61 happyReduction_136
happyReduction_136 (HappyAbsSyn50  happy_var_3)
	_
	(HappyAbsSyn50  happy_var_1)
	 =  HappyAbsSyn50
		 (AbsVarg.EEq happy_var_1 happy_var_3
	)
happyReduction_136 _ _ _  = notHappyAtAll 

happyReduce_137 = happySpecReduce_3  61 happyReduction_137
happyReduction_137 (HappyAbsSyn50  happy_var_3)
	_
	(HappyAbsSyn50  happy_var_1)
	 =  HappyAbsSyn50
		 (AbsVarg.ELe happy_var_1 happy_var_3
	)
happyReduction_137 _ _ _  = notHappyAtAll 

happyReduce_138 = happySpecReduce_3  61 happyReduction_138
happyReduction_138 (HappyAbsSyn50  happy_var_3)
	_
	(HappyAbsSyn50  happy_var_1)
	 =  HappyAbsSyn50
		 (AbsVarg.EGt happy_var_1 happy_var_3
	)
happyReduction_138 _ _ _  = notHappyAtAll 

happyReduce_139 = happySpecReduce_3  61 happyReduction_139
happyReduction_139 (HappyAbsSyn50  happy_var_3)
	_
	(HappyAbsSyn50  happy_var_1)
	 =  HappyAbsSyn50
		 (AbsVarg.ELeq happy_var_1 happy_var_3
	)
happyReduction_139 _ _ _  = notHappyAtAll 

happyReduce_140 = happySpecReduce_3  61 happyReduction_140
happyReduction_140 (HappyAbsSyn50  happy_var_3)
	_
	(HappyAbsSyn50  happy_var_1)
	 =  HappyAbsSyn50
		 (AbsVarg.EGeq happy_var_1 happy_var_3
	)
happyReduction_140 _ _ _  = notHappyAtAll 

happyReduce_141 = happySpecReduce_1  61 happyReduction_141
happyReduction_141 (HappyAbsSyn50  happy_var_1)
	 =  HappyAbsSyn50
		 (happy_var_1
	)
happyReduction_141 _  = notHappyAtAll 

happyReduce_142 = happySpecReduce_3  62 happyReduction_142
happyReduction_142 (HappyAbsSyn50  happy_var_3)
	_
	(HappyAbsSyn50  happy_var_1)
	 =  HappyAbsSyn50
		 (AbsVarg.EAdd happy_var_1 happy_var_3
	)
happyReduction_142 _ _ _  = notHappyAtAll 

happyReduce_143 = happySpecReduce_3  62 happyReduction_143
happyReduction_143 (HappyAbsSyn50  happy_var_3)
	_
	(HappyAbsSyn50  happy_var_1)
	 =  HappyAbsSyn50
		 (AbsVarg.ESub happy_var_1 happy_var_3
	)
happyReduction_143 _ _ _  = notHappyAtAll 

happyReduce_144 = happySpecReduce_1  62 happyReduction_144
happyReduction_144 (HappyAbsSyn50  happy_var_1)
	 =  HappyAbsSyn50
		 (happy_var_1
	)
happyReduction_144 _  = notHappyAtAll 

happyReduce_145 = happySpecReduce_3  63 happyReduction_145
happyReduction_145 (HappyAbsSyn50  happy_var_3)
	_
	(HappyAbsSyn50  happy_var_1)
	 =  HappyAbsSyn50
		 (AbsVarg.EMul happy_var_1 happy_var_3
	)
happyReduction_145 _ _ _  = notHappyAtAll 

happyReduce_146 = happySpecReduce_3  63 happyReduction_146
happyReduction_146 (HappyAbsSyn50  happy_var_3)
	_
	(HappyAbsSyn50  happy_var_1)
	 =  HappyAbsSyn50
		 (AbsVarg.EDiv happy_var_1 happy_var_3
	)
happyReduction_146 _ _ _  = notHappyAtAll 

happyReduce_147 = happySpecReduce_1  63 happyReduction_147
happyReduction_147 (HappyAbsSyn50  happy_var_1)
	 =  HappyAbsSyn50
		 (happy_var_1
	)
happyReduction_147 _  = notHappyAtAll 

happyReduce_148 = happySpecReduce_3  64 happyReduction_148
happyReduction_148 (HappyAbsSyn50  happy_var_3)
	_
	(HappyAbsSyn50  happy_var_1)
	 =  HappyAbsSyn50
		 (AbsVarg.EPow happy_var_1 happy_var_3
	)
happyReduction_148 _ _ _  = notHappyAtAll 

happyReduce_149 = happySpecReduce_1  64 happyReduction_149
happyReduction_149 (HappyAbsSyn50  happy_var_1)
	 =  HappyAbsSyn50
		 (happy_var_1
	)
happyReduction_149 _  = notHappyAtAll 

happyReduce_150 = happySpecReduce_1  65 happyReduction_150
happyReduction_150 (HappyAbsSyn66  happy_var_1)
	 =  HappyAbsSyn50
		 (AbsVarg.EBoolean happy_var_1
	)
happyReduction_150 _  = notHappyAtAll 

happyReduce_151 = happySpecReduce_1  65 happyReduction_151
happyReduction_151 (HappyAbsSyn4  happy_var_1)
	 =  HappyAbsSyn50
		 (AbsVarg.EInt happy_var_1
	)
happyReduction_151 _  = notHappyAtAll 

happyReduce_152 = happySpecReduce_1  65 happyReduction_152
happyReduction_152 (HappyAbsSyn5  happy_var_1)
	 =  HappyAbsSyn50
		 (AbsVarg.EReal happy_var_1
	)
happyReduction_152 _  = notHappyAtAll 

happyReduce_153 = happySpecReduce_3  65 happyReduction_153
happyReduction_153 _
	(HappyAbsSyn6  happy_var_2)
	_
	 =  HappyAbsSyn50
		 (AbsVarg.EChar happy_var_2
	)
happyReduction_153 _ _ _  = notHappyAtAll 

happyReduce_154 = happySpecReduce_3  65 happyReduction_154
happyReduction_154 _
	(HappyAbsSyn7  happy_var_2)
	_
	 =  HappyAbsSyn50
		 (AbsVarg.EString happy_var_2
	)
happyReduction_154 _ _ _  = notHappyAtAll 

happyReduce_155 = happySpecReduce_1  65 happyReduction_155
happyReduction_155 _
	 =  HappyAbsSyn50
		 (AbsVarg.EWild
	)

happyReduce_156 = happySpecReduce_3  65 happyReduction_156
happyReduction_156 _
	(HappyAbsSyn50  happy_var_2)
	_
	 =  HappyAbsSyn50
		 (happy_var_2
	)
happyReduction_156 _ _ _  = notHappyAtAll 

happyReduce_157 = happySpecReduce_1  66 happyReduction_157
happyReduction_157 _
	 =  HappyAbsSyn66
		 (AbsVarg.ETrue
	)

happyReduce_158 = happySpecReduce_1  66 happyReduction_158
happyReduction_158 _
	 =  HappyAbsSyn66
		 (AbsVarg.EFalse
	)

happyNewToken action sts stk [] =
	action 132 132 notHappyAtAll (HappyState action) sts stk []

happyNewToken action sts stk (tk:tks) =
	let cont i = action i i tk (HappyState action) sts stk tks in
	case tk of {
	PT _ (TS _ 1) -> cont 67;
	PT _ (TS _ 2) -> cont 68;
	PT _ (TS _ 3) -> cont 69;
	PT _ (TS _ 4) -> cont 70;
	PT _ (TS _ 5) -> cont 71;
	PT _ (TS _ 6) -> cont 72;
	PT _ (TS _ 7) -> cont 73;
	PT _ (TS _ 8) -> cont 74;
	PT _ (TS _ 9) -> cont 75;
	PT _ (TS _ 10) -> cont 76;
	PT _ (TS _ 11) -> cont 77;
	PT _ (TS _ 12) -> cont 78;
	PT _ (TS _ 13) -> cont 79;
	PT _ (TS _ 14) -> cont 80;
	PT _ (TS _ 15) -> cont 81;
	PT _ (TS _ 16) -> cont 82;
	PT _ (TS _ 17) -> cont 83;
	PT _ (TS _ 18) -> cont 84;
	PT _ (TS _ 19) -> cont 85;
	PT _ (TS _ 20) -> cont 86;
	PT _ (TS _ 21) -> cont 87;
	PT _ (TS _ 22) -> cont 88;
	PT _ (TS _ 23) -> cont 89;
	PT _ (TS _ 24) -> cont 90;
	PT _ (TS _ 25) -> cont 91;
	PT _ (TS _ 26) -> cont 92;
	PT _ (TS _ 27) -> cont 93;
	PT _ (TS _ 28) -> cont 94;
	PT _ (TS _ 29) -> cont 95;
	PT _ (TS _ 30) -> cont 96;
	PT _ (TS _ 31) -> cont 97;
	PT _ (TS _ 32) -> cont 98;
	PT _ (TS _ 33) -> cont 99;
	PT _ (TS _ 34) -> cont 100;
	PT _ (TS _ 35) -> cont 101;
	PT _ (TS _ 36) -> cont 102;
	PT _ (TS _ 37) -> cont 103;
	PT _ (TS _ 38) -> cont 104;
	PT _ (TS _ 39) -> cont 105;
	PT _ (TS _ 40) -> cont 106;
	PT _ (TS _ 41) -> cont 107;
	PT _ (TS _ 42) -> cont 108;
	PT _ (TS _ 43) -> cont 109;
	PT _ (TS _ 44) -> cont 110;
	PT _ (TS _ 45) -> cont 111;
	PT _ (TS _ 46) -> cont 112;
	PT _ (TS _ 47) -> cont 113;
	PT _ (TS _ 48) -> cont 114;
	PT _ (TS _ 49) -> cont 115;
	PT _ (TS _ 50) -> cont 116;
	PT _ (TS _ 51) -> cont 117;
	PT _ (TS _ 52) -> cont 118;
	PT _ (TS _ 53) -> cont 119;
	PT _ (TS _ 54) -> cont 120;
	PT _ (TS _ 55) -> cont 121;
	PT _ (TS _ 56) -> cont 122;
	PT _ (TS _ 57) -> cont 123;
	PT _ (TS _ 58) -> cont 124;
	PT _ (TI happy_dollar_dollar) -> cont 125;
	PT _ (TD happy_dollar_dollar) -> cont 126;
	PT _ (TC happy_dollar_dollar) -> cont 127;
	PT _ (TL happy_dollar_dollar) -> cont 128;
	PT _ (T_UIdent happy_dollar_dollar) -> cont 129;
	PT _ (T_LIdent happy_dollar_dollar) -> cont 130;
	PT _ (T_MFun happy_dollar_dollar) -> cont 131;
	_ -> happyError' ((tk:tks), [])
	}

happyError_ explist 132 tk tks = happyError' (tks, explist)
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
 happySomeParser = happyThen (happyParse action_0 tks) (\x -> case x of {HappyAbsSyn11 z -> happyReturn z; _other -> notHappyAtAll })

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
