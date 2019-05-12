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
 action_274,
 action_275,
 action_276,
 action_277,
 action_278,
 action_279,
 action_280,
 action_281 :: () => Int -> ({-HappyReduction (Err) = -}
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
 happyReduce_158,
 happyReduce_159,
 happyReduce_160,
 happyReduce_161,
 happyReduce_162 :: () => ({-HappyReduction (Err) = -}
	   Int 
	-> (Token)
	-> HappyState (Token) (HappyStk HappyAbsSyn -> [(Token)] -> (Err) HappyAbsSyn)
	-> [HappyState (Token) (HappyStk HappyAbsSyn -> [(Token)] -> (Err) HappyAbsSyn)] 
	-> HappyStk HappyAbsSyn 
	-> [(Token)] -> (Err) HappyAbsSyn)

happyExpList :: Happy_Data_Array.Array Int Int
happyExpList = Happy_Data_Array.listArray (0,1123) ([0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,256,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,512,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,4096,0,0,0,0,16384,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,64,21896,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,4096,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,16,0,0,0,0,0,0,0,4096,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,2048,0,0,0,0,0,0,256,0,0,0,0,0,0,0,0,256,0,0,0,0,0,8192,0,0,0,12288,0,0,0,0,0,0,0,8192,0,0,0,0,0,49152,256,0,12288,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,16384,0,0,8192,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,16,8196,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,8192,0,0,0,12288,0,0,0,0,0,0,0,2048,0,0,0,0,8192,0,0,0,12288,0,0,0,0,512,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,8192,0,0,0,0,16384,0,0,0,0,0,0,0,0,32,0,0,0,48,0,0,0,8192,0,0,0,12288,0,0,0,0,8192,0,0,0,0,0,0,0,0,64,0,0,0,0,0,0,0,0,0,0,32768,0,0,0,0,0,0,0,0,8192,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,32,0,0,0,0,0,0,256,8192,0,0,0,0,0,0,0,0,2048,0,0,0,0,0,0,0,0,32,0,0,0,0,32,0,0,0,48,0,0,0,8192,0,0,0,12288,0,0,0,0,32,0,0,0,48,0,0,0,8192,0,0,0,12288,0,0,0,0,8192,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,4096,1024,32,0,0,0,8192,0,0,0,12288,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,8192,0,0,0,12288,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,4096,0,0,0,0,32,0,0,0,48,0,0,0,0,0,0,0,0,0,0,0,0,0,0,32,0,0,0,0,0,0,0,0,0,128,0,0,0,0,16384,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,64,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,8192,0,0,0,12288,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,512,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,512,0,0,0,0,0,0,8192,0,0,0,12288,0,0,0,0,0,512,0,0,0,0,0,0,0,0,2,0,0,0,0,0,0,0,512,0,0,0,0,0,0,0,0,0,0,4096,0,0,0,0,0,0,0,32768,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,64,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,32,0,0,0,48,0,0,0,0,49152,0,0,12288,0,0,0,0,0,192,0,0,48,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,64,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,38912,2320,4,0,0,0,0,0,0,0,0,16,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,8192,0,0,0,0,0,0,0,16,8196,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,8192,0,0,0,8192,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,128,0,0,0,0,0,0,0,38272,1077,0,0,0,0,0,0,0,0,0,0,128,0,0,0,0,0,0,0,0,0,0,0,0,16384,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,49152,0,0,12288,0,0,0,0,0,0,0,0,0,0,0,0,0,2,0,0,0,0,0,0,0,0,16,0,0,0,0,0,0,8192,32,0,0,8192,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,512,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,8192,0,0,0,0,32,4096,0,0,48,0,0,0,0,0,0,0,0,0,0,0,0,0,192,0,0,48,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,8192,0,0,0,12288,0,0,0,0,8192,0,0,0,0,0,0,0,13312,32768,17544,8736,29443,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,4,0,0,0,0,0,0,0,4,0,0,0,0,0,0,2048,12677,0,64,64,0,0,0,0,4224,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,8,0,0,0,0,0,0,0,1024,0,0,0,0,38324,36277,8260,802,115,0,0,0,13312,32768,17544,8736,29443,0,0,0,0,0,0,0,0,0,0,0,0,13312,32768,17544,8736,29475,0,0,0,0,0,0,0,0,0,0,0,0,13312,32768,17544,8736,29443,0,0,0,0,52,34944,8260,802,115,0,0,0,13312,0,1032,8192,29443,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,8192,0,0,0,12288,0,0,0,0,0,0,0,0,0,0,0,0,16384,0,0,0,0,0,0,0,0,1280,0,0,0,0,0,0,0,46080,46485,17548,8736,29443,0,0,0,0,0,0,0,4096,0,0,0,0,0,0,0,32768,0,0,0,0,0,0,8192,0,0,0,0,0,0,0,0,0,4,0,0,0,0,0,52,34944,8260,802,115,0,0,0,0,0,0,0,0,0,0,0,0,512,0,0,0,0,0,0,0,0,0,2,0,0,0,0,0,0,64,0,0,0,0,0,0,0,16384,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,16,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,4,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,52,2048,4,800,115,0,0,0,13312,0,1032,8192,29443,0,0,0,0,52,2048,4,800,115,0,0,0,13312,0,1032,8192,29443,0,0,0,0,52,2048,4,800,115,0,0,0,13312,0,1032,8192,29443,0,0,0,0,52,2048,4,800,115,0,0,0,13312,0,1032,8192,29443,0,0,0,0,52,2048,4,800,115,0,0,0,13312,0,1032,8192,29443,0,0,0,0,52,2048,4,800,115,0,0,0,13312,0,1032,8192,29443,0,0,0,0,52,2048,4,800,115,0,0,0,13312,0,1032,8192,29443,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1280,0,0,0,0,0,0,0,0,5,0,0,0,0,0,0,0,1280,0,0,0,0,0,0,0,0,5,0,0,0,0,0,0,0,1280,0,0,0,0,0,0,0,0,5,0,0,0,0,0,0,0,1280,0,0,0,0,0,0,0,32768,16,0,0,0,0,0,0,0,4224,0,0,0,0,0,0,0,0,5,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,8224,0,0,0,32,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,13312,32768,17544,8736,29443,0,0,0,0,0,0,0,32768,0,0,0,0,0,64,0,0,0,0,0,0,0,52,34944,8260,802,115,0,0,0,0,0,0,0,8192,0,0,0,0,52,34944,8260,802,115,0,0,0,0,0,0,0,32,0,0,0,0,0,0,0,0,0,0,0,0,13312,32768,17544,8736,29443,0,0,0,0,0,0,2,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,13312,32768,17544,8736,29443,0,0,0,0,0,0,1024,0,0,0,0,0,0,0,0,0,0,0,0,0,0,32,0,0,0,48,0,0,0,0,2048,0,0,0,0,0,0,0,52,34944,8260,802,115,0,0,0,0,0,0,0,0,0,0,0,0,52,34944,8260,802,115,0,0,0,0,8,0,0,0,0,0,0,0,0,0,0,32768,0,0,0,0,0,64,0,0,0,0,0,0,0,52,34944,8260,802,115,0,0,0,0,0,0,0,0,0,0,0,0,52,34944,8260,802,115,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,13312,32768,17544,8736,29443,0,0,0,0,64,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	])

{-# NOINLINE happyExpListPerState #-}
happyExpListPerState st =
    token_strs_expected
  where token_strs = ["error","%dummy","%start_pProgramDef","Integer","Double","Char","String","UIdent","LIdent","MFun","ProgramDef","ListClassDef","ImportDef","ListImportDef","ListConstrTypeParam","ConstrTypeParam","TypeDef","TypeDef1","ListTypeDef","PrimFreeType","FreeTypeDef","FreeTypeDef1","ListPrimFreeType","ListArgDef","ArgDef","SuperclassType","ListSuperclassType","ClassDef","IsImplementing","IsDeriving","ListClassModifier","ClassModifier","ClassContents","MemberDef","ListMemberDef","FunDef","RetType","FunctionName","Operator","AbsRetType","FunTemplateParams","TemplateParam","ListTemplateParam","ListFunDef","ListFunctionModifier","FunctionModifier","ClassField","ListClassField","FieldModifier","Expr","ListAsDef","AsDef","ListMatchClause","MatchClause","Functorial","Arg","ListArg","Expr5","ListElem","ListListElem","Expr1","Expr2","Expr3","Expr4","Expr6","Boolean","'\\\"'","'&&'","'\\''","'('","')'","'*'","'+'","','","'-'","'->'","'/'","':'","';'","'<'","'<='","'='","'=='","'=>'","'>'","'>='","'?'","'['","'\\\\'","']'","'^'","'_'","'abstract'","'as'","'class'","'define'","'deriving'","'else'","'false'","'final'","'function'","'has'","'if'","'implement'","'implementing'","'import'","'in'","'interface'","'internal'","'match'","'mod'","'module'","'native'","'not'","'sealed'","'static'","'struct'","'super'","'template'","'then'","'this'","'true'","'unique'","'where'","'with'","'{'","'||'","'}'","L_integ","L_doubl","L_charac","L_quoted","L_UIdent","L_LIdent","L_MFun","%eof"]
        bit_start = st * 136
        bit_end = (st + 1) * 136
        read_bit = readArrayBit happyExpList
        bits = map read_bit [bit_start..bit_end - 1]
        bits_indexed = zip bits [0..135]
        token_strs_expected = concatMap f bits_indexed
        f (False, _) = []
        f (True, nr) = [token_strs !! nr]

action_0 (11) = happyGoto action_3
action_0 (14) = happyGoto action_4
action_0 _ = happyReduce_12

action_1 (129) = happyShift action_2
action_1 _ = happyFail (happyExpListPerState 1)

action_2 _ = happyReduce_1

action_3 (136) = happyAccept
action_3 _ = happyFail (happyExpListPerState 3)

action_4 (106) = happyShift action_7
action_4 (12) = happyGoto action_5
action_4 (13) = happyGoto action_6
action_4 _ = happyReduce_9

action_5 (136) = happyReduce_8
action_5 (28) = happyGoto action_10
action_5 (31) = happyGoto action_11
action_5 _ = happyReduce_52

action_6 _ = happyReduce_13

action_7 (133) = happyShift action_9
action_7 (8) = happyGoto action_8
action_7 _ = happyFail (happyExpListPerState 7)

action_8 (79) = happyShift action_20
action_8 _ = happyFail (happyExpListPerState 8)

action_9 _ = happyReduce_5

action_10 _ = happyReduce_10

action_11 (95) = happyShift action_13
action_11 (108) = happyShift action_14
action_11 (112) = happyShift action_15
action_11 (113) = happyShift action_16
action_11 (115) = happyShift action_17
action_11 (117) = happyShift action_18
action_11 (119) = happyShift action_19
action_11 (32) = happyGoto action_12
action_11 _ = happyFail (happyExpListPerState 11)

action_12 _ = happyReduce_53

action_13 (133) = happyShift action_9
action_13 (8) = happyGoto action_23
action_13 _ = happyFail (happyExpListPerState 13)

action_14 _ = happyReduce_55

action_15 _ = happyReduce_54

action_16 _ = happyReduce_57

action_17 _ = happyReduce_56

action_18 (133) = happyShift action_9
action_18 (8) = happyGoto action_22
action_18 _ = happyFail (happyExpListPerState 18)

action_19 (133) = happyShift action_9
action_19 (8) = happyGoto action_21
action_19 _ = happyFail (happyExpListPerState 19)

action_20 _ = happyReduce_11

action_21 (15) = happyGoto action_27
action_21 _ = happyReduce_14

action_22 (124) = happyShift action_26
action_22 _ = happyFail (happyExpListPerState 22)

action_23 (97) = happyShift action_25
action_23 (30) = happyGoto action_24
action_23 _ = happyReduce_51

action_24 (105) = happyShift action_43
action_24 (29) = happyGoto action_42
action_24 _ = happyReduce_49

action_25 (70) = happyShift action_41
action_25 (133) = happyShift action_9
action_25 (134) = happyShift action_34
action_25 (8) = happyGoto action_36
action_25 (9) = happyGoto action_37
action_25 (21) = happyGoto action_38
action_25 (22) = happyGoto action_39
action_25 (26) = happyGoto action_40
action_25 _ = happyFail (happyExpListPerState 25)

action_26 (126) = happyShift action_35
action_26 _ = happyFail (happyExpListPerState 26)

action_27 (87) = happyShift action_32
action_27 (88) = happyShift action_33
action_27 (97) = happyShift action_25
action_27 (133) = happyShift action_9
action_27 (134) = happyShift action_34
action_27 (8) = happyGoto action_28
action_27 (9) = happyGoto action_29
action_27 (16) = happyGoto action_30
action_27 (30) = happyGoto action_31
action_27 _ = happyReduce_51

action_28 _ = happyReduce_17

action_29 _ = happyReduce_16

action_30 _ = happyReduce_15

action_31 (105) = happyShift action_43
action_31 (29) = happyGoto action_58
action_31 _ = happyReduce_49

action_32 _ = happyReduce_18

action_33 (87) = happyShift action_57
action_33 (134) = happyShift action_34
action_33 (9) = happyGoto action_56
action_33 _ = happyFail (happyExpListPerState 33)

action_34 _ = happyReduce_6

action_35 (109) = happyShift action_54
action_35 (123) = happyShift action_55
action_35 (134) = happyShift action_34
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

action_41 (70) = happyShift action_41
action_41 (133) = happyShift action_9
action_41 (134) = happyShift action_34
action_41 (8) = happyGoto action_36
action_41 (9) = happyGoto action_37
action_41 (21) = happyGoto action_47
action_41 (22) = happyGoto action_39
action_41 _ = happyFail (happyExpListPerState 41)

action_42 (124) = happyShift action_46
action_42 _ = happyFail (happyExpListPerState 42)

action_43 (70) = happyShift action_41
action_43 (133) = happyShift action_9
action_43 (134) = happyShift action_34
action_43 (8) = happyGoto action_36
action_43 (9) = happyGoto action_37
action_43 (21) = happyGoto action_38
action_43 (22) = happyGoto action_39
action_43 (26) = happyGoto action_44
action_43 (27) = happyGoto action_45
action_43 _ = happyFail (happyExpListPerState 43)

action_44 (74) = happyShift action_74
action_44 _ = happyReduce_43

action_45 _ = happyReduce_48

action_46 (126) = happyShift action_73
action_46 _ = happyFail (happyExpListPerState 46)

action_47 (71) = happyShift action_72
action_47 _ = happyFail (happyExpListPerState 47)

action_48 (70) = happyShift action_71
action_48 (133) = happyShift action_9
action_48 (134) = happyShift action_34
action_48 (8) = happyGoto action_68
action_48 (9) = happyGoto action_69
action_48 (20) = happyGoto action_70
action_48 _ = happyReduce_33

action_49 (70) = happyShift action_71
action_49 (133) = happyShift action_9
action_49 (134) = happyShift action_34
action_49 (8) = happyGoto action_68
action_49 (9) = happyGoto action_69
action_49 (20) = happyGoto action_70
action_49 _ = happyReduce_32

action_50 (78) = happyShift action_67
action_50 _ = happyFail (happyExpListPerState 50)

action_51 (79) = happyShift action_66
action_51 _ = happyReduce_101

action_52 (128) = happyShift action_65
action_52 _ = happyFail (happyExpListPerState 52)

action_53 (134) = happyShift action_34
action_53 (9) = happyGoto action_64
action_53 _ = happyFail (happyExpListPerState 53)

action_54 _ = happyReduce_103

action_55 _ = happyReduce_104

action_56 (97) = happyShift action_62
action_56 (118) = happyShift action_63
action_56 _ = happyFail (happyExpListPerState 56)

action_57 (97) = happyShift action_60
action_57 (118) = happyShift action_61
action_57 _ = happyFail (happyExpListPerState 57)

action_58 (124) = happyShift action_59
action_58 _ = happyFail (happyExpListPerState 58)

action_59 (126) = happyShift action_93
action_59 _ = happyFail (happyExpListPerState 59)

action_60 (70) = happyShift action_89
action_60 (133) = happyShift action_9
action_60 (134) = happyShift action_34
action_60 (8) = happyGoto action_84
action_60 (9) = happyGoto action_85
action_60 (17) = happyGoto action_86
action_60 (18) = happyGoto action_87
action_60 (19) = happyGoto action_92
action_60 _ = happyFail (happyExpListPerState 60)

action_61 (70) = happyShift action_89
action_61 (133) = happyShift action_9
action_61 (134) = happyShift action_34
action_61 (8) = happyGoto action_84
action_61 (9) = happyGoto action_85
action_61 (17) = happyGoto action_86
action_61 (18) = happyGoto action_87
action_61 (19) = happyGoto action_91
action_61 _ = happyFail (happyExpListPerState 61)

action_62 (70) = happyShift action_89
action_62 (133) = happyShift action_9
action_62 (134) = happyShift action_34
action_62 (8) = happyGoto action_84
action_62 (9) = happyGoto action_85
action_62 (17) = happyGoto action_86
action_62 (18) = happyGoto action_87
action_62 (19) = happyGoto action_90
action_62 _ = happyFail (happyExpListPerState 62)

action_63 (70) = happyShift action_89
action_63 (133) = happyShift action_9
action_63 (134) = happyShift action_34
action_63 (8) = happyGoto action_84
action_63 (9) = happyGoto action_85
action_63 (17) = happyGoto action_86
action_63 (18) = happyGoto action_87
action_63 (19) = happyGoto action_88
action_63 _ = happyFail (happyExpListPerState 63)

action_64 (78) = happyShift action_83
action_64 _ = happyFail (happyExpListPerState 64)

action_65 _ = happyReduce_45

action_66 (109) = happyShift action_54
action_66 (123) = happyShift action_55
action_66 (134) = happyShift action_34
action_66 (9) = happyGoto action_50
action_66 (47) = happyGoto action_51
action_66 (48) = happyGoto action_82
action_66 (49) = happyGoto action_53
action_66 _ = happyReduce_100

action_67 (70) = happyShift action_41
action_67 (133) = happyShift action_9
action_67 (134) = happyShift action_34
action_67 (8) = happyGoto action_36
action_67 (9) = happyGoto action_37
action_67 (21) = happyGoto action_81
action_67 (22) = happyGoto action_39
action_67 _ = happyFail (happyExpListPerState 67)

action_68 _ = happyReduce_31

action_69 _ = happyReduce_30

action_70 _ = happyReduce_37

action_71 (70) = happyShift action_41
action_71 (133) = happyShift action_9
action_71 (134) = happyShift action_34
action_71 (8) = happyGoto action_36
action_71 (9) = happyGoto action_37
action_71 (21) = happyGoto action_80
action_71 (22) = happyGoto action_39
action_71 _ = happyFail (happyExpListPerState 71)

action_72 _ = happyReduce_35

action_73 (133) = happyShift action_9
action_73 (8) = happyGoto action_76
action_73 (33) = happyGoto action_77
action_73 (34) = happyGoto action_78
action_73 (35) = happyGoto action_79
action_73 _ = happyReduce_61

action_74 (70) = happyShift action_41
action_74 (133) = happyShift action_9
action_74 (134) = happyShift action_34
action_74 (8) = happyGoto action_36
action_74 (9) = happyGoto action_37
action_74 (21) = happyGoto action_38
action_74 (22) = happyGoto action_39
action_74 (26) = happyGoto action_44
action_74 (27) = happyGoto action_75
action_74 _ = happyFail (happyExpListPerState 74)

action_75 _ = happyReduce_44

action_76 (102) = happyShift action_110
action_76 _ = happyReduce_59

action_77 (128) = happyShift action_109
action_77 _ = happyFail (happyExpListPerState 77)

action_78 (79) = happyShift action_108
action_78 _ = happyReduce_62

action_79 (128) = happyReduce_87
action_79 (36) = happyGoto action_105
action_79 (44) = happyGoto action_106
action_79 (45) = happyGoto action_107
action_79 _ = happyReduce_90

action_80 (71) = happyShift action_104
action_80 _ = happyFail (happyExpListPerState 80)

action_81 _ = happyReduce_99

action_82 _ = happyReduce_102

action_83 (70) = happyShift action_41
action_83 (133) = happyShift action_9
action_83 (134) = happyShift action_34
action_83 (8) = happyGoto action_36
action_83 (9) = happyGoto action_37
action_83 (21) = happyGoto action_103
action_83 (22) = happyGoto action_39
action_83 _ = happyFail (happyExpListPerState 83)

action_84 (15) = happyGoto action_102
action_84 _ = happyReduce_14

action_85 (15) = happyGoto action_101
action_85 _ = happyReduce_14

action_86 (74) = happyShift action_100
action_86 _ = happyReduce_27

action_87 _ = happyReduce_25

action_88 (90) = happyShift action_99
action_88 _ = happyFail (happyExpListPerState 88)

action_89 (70) = happyShift action_89
action_89 (133) = happyShift action_9
action_89 (134) = happyShift action_34
action_89 (8) = happyGoto action_84
action_89 (9) = happyGoto action_85
action_89 (17) = happyGoto action_98
action_89 (18) = happyGoto action_87
action_89 _ = happyFail (happyExpListPerState 89)

action_90 (90) = happyShift action_97
action_90 _ = happyFail (happyExpListPerState 90)

action_91 (90) = happyShift action_96
action_91 _ = happyFail (happyExpListPerState 91)

action_92 (90) = happyShift action_95
action_92 _ = happyFail (happyExpListPerState 92)

action_93 (133) = happyShift action_9
action_93 (8) = happyGoto action_76
action_93 (33) = happyGoto action_94
action_93 (34) = happyGoto action_78
action_93 (35) = happyGoto action_79
action_93 _ = happyReduce_61

action_94 (128) = happyShift action_124
action_94 _ = happyFail (happyExpListPerState 94)

action_95 _ = happyReduce_22

action_96 _ = happyReduce_20

action_97 _ = happyReduce_21

action_98 (71) = happyShift action_123
action_98 _ = happyFail (happyExpListPerState 98)

action_99 _ = happyReduce_19

action_100 (70) = happyShift action_89
action_100 (133) = happyShift action_9
action_100 (134) = happyShift action_34
action_100 (8) = happyGoto action_84
action_100 (9) = happyGoto action_85
action_100 (17) = happyGoto action_86
action_100 (18) = happyGoto action_87
action_100 (19) = happyGoto action_122
action_100 _ = happyFail (happyExpListPerState 100)

action_101 (87) = happyShift action_32
action_101 (88) = happyShift action_33
action_101 (133) = happyShift action_9
action_101 (134) = happyShift action_34
action_101 (8) = happyGoto action_28
action_101 (9) = happyGoto action_29
action_101 (16) = happyGoto action_30
action_101 _ = happyReduce_24

action_102 (87) = happyShift action_32
action_102 (88) = happyShift action_33
action_102 (133) = happyShift action_9
action_102 (134) = happyShift action_34
action_102 (8) = happyGoto action_28
action_102 (9) = happyGoto action_29
action_102 (16) = happyGoto action_30
action_102 _ = happyReduce_23

action_103 _ = happyReduce_98

action_104 _ = happyReduce_29

action_105 (79) = happyShift action_121
action_105 _ = happyReduce_88

action_106 _ = happyReduce_58

action_107 (100) = happyShift action_114
action_107 (101) = happyShift action_115
action_107 (104) = happyShift action_116
action_107 (109) = happyShift action_117
action_107 (113) = happyShift action_118
action_107 (116) = happyShift action_119
action_107 (123) = happyShift action_120
action_107 (46) = happyGoto action_113
action_107 _ = happyFail (happyExpListPerState 107)

action_108 (133) = happyShift action_9
action_108 (8) = happyGoto action_76
action_108 (34) = happyGoto action_78
action_108 (35) = happyGoto action_112
action_108 _ = happyReduce_61

action_109 _ = happyReduce_46

action_110 (126) = happyShift action_111
action_110 _ = happyFail (happyExpListPerState 110)

action_111 (109) = happyShift action_54
action_111 (123) = happyShift action_55
action_111 (134) = happyShift action_34
action_111 (9) = happyGoto action_50
action_111 (47) = happyGoto action_51
action_111 (48) = happyGoto action_129
action_111 (49) = happyGoto action_53
action_111 _ = happyReduce_100

action_112 _ = happyReduce_63

action_113 _ = happyReduce_91

action_114 _ = happyReduce_95

action_115 (70) = happyShift action_128
action_115 (134) = happyShift action_34
action_115 (9) = happyGoto action_126
action_115 (38) = happyGoto action_127
action_115 _ = happyFail (happyExpListPerState 115)

action_116 _ = happyReduce_94

action_117 _ = happyReduce_93

action_118 _ = happyReduce_97

action_119 _ = happyReduce_92

action_120 _ = happyReduce_96

action_121 (128) = happyReduce_87
action_121 (36) = happyGoto action_105
action_121 (44) = happyGoto action_125
action_121 (45) = happyGoto action_107
action_121 _ = happyReduce_90

action_122 _ = happyReduce_28

action_123 _ = happyReduce_26

action_124 _ = happyReduce_47

action_125 _ = happyReduce_89

action_126 _ = happyReduce_68

action_127 (80) = happyShift action_143
action_127 (41) = happyGoto action_142
action_127 _ = happyReduce_82

action_128 (72) = happyShift action_132
action_128 (73) = happyShift action_133
action_128 (75) = happyShift action_134
action_128 (77) = happyShift action_135
action_128 (80) = happyShift action_136
action_128 (81) = happyShift action_137
action_128 (83) = happyShift action_138
action_128 (85) = happyShift action_139
action_128 (86) = happyShift action_140
action_128 (91) = happyShift action_141
action_128 (39) = happyGoto action_131
action_128 _ = happyFail (happyExpListPerState 128)

action_129 (128) = happyShift action_130
action_129 _ = happyFail (happyExpListPerState 129)

action_130 _ = happyReduce_60

action_131 (71) = happyShift action_148
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

action_142 (24) = happyGoto action_147
action_142 _ = happyReduce_38

action_143 (87) = happyShift action_32
action_143 (88) = happyShift action_33
action_143 (133) = happyShift action_9
action_143 (134) = happyShift action_34
action_143 (8) = happyGoto action_28
action_143 (9) = happyGoto action_29
action_143 (16) = happyGoto action_144
action_143 (42) = happyGoto action_145
action_143 (43) = happyGoto action_146
action_143 _ = happyFail (happyExpListPerState 143)

action_144 _ = happyReduce_84

action_145 (74) = happyShift action_156
action_145 _ = happyReduce_85

action_146 (85) = happyShift action_155
action_146 _ = happyFail (happyExpListPerState 146)

action_147 (70) = happyShift action_153
action_147 (78) = happyShift action_154
action_147 (82) = happyReduce_67
action_147 (134) = happyShift action_34
action_147 (9) = happyGoto action_149
action_147 (25) = happyGoto action_150
action_147 (37) = happyGoto action_151
action_147 (40) = happyGoto action_152
action_147 _ = happyReduce_81

action_148 _ = happyReduce_69

action_149 _ = happyReduce_41

action_150 _ = happyReduce_39

action_151 (82) = happyShift action_161
action_151 _ = happyFail (happyExpListPerState 151)

action_152 _ = happyReduce_65

action_153 (134) = happyShift action_34
action_153 (9) = happyGoto action_160
action_153 _ = happyFail (happyExpListPerState 153)

action_154 (70) = happyShift action_41
action_154 (93) = happyShift action_159
action_154 (133) = happyShift action_9
action_154 (134) = happyShift action_34
action_154 (8) = happyGoto action_36
action_154 (9) = happyGoto action_37
action_154 (21) = happyGoto action_158
action_154 (22) = happyGoto action_39
action_154 _ = happyFail (happyExpListPerState 154)

action_155 _ = happyReduce_83

action_156 (87) = happyShift action_32
action_156 (88) = happyShift action_33
action_156 (133) = happyShift action_9
action_156 (134) = happyShift action_34
action_156 (8) = happyGoto action_28
action_156 (9) = happyGoto action_29
action_156 (16) = happyGoto action_144
action_156 (42) = happyGoto action_145
action_156 (43) = happyGoto action_157
action_156 _ = happyFail (happyExpListPerState 156)

action_157 _ = happyReduce_86

action_158 _ = happyReduce_66

action_159 (70) = happyShift action_41
action_159 (133) = happyShift action_9
action_159 (134) = happyShift action_34
action_159 (8) = happyGoto action_36
action_159 (9) = happyGoto action_37
action_159 (21) = happyGoto action_192
action_159 (22) = happyGoto action_39
action_159 _ = happyFail (happyExpListPerState 159)

action_160 (78) = happyShift action_191
action_160 _ = happyFail (happyExpListPerState 160)

action_161 (67) = happyShift action_176
action_161 (69) = happyShift action_177
action_161 (70) = happyShift action_178
action_161 (88) = happyShift action_179
action_161 (92) = happyShift action_180
action_161 (96) = happyShift action_181
action_161 (99) = happyShift action_182
action_161 (103) = happyShift action_183
action_161 (110) = happyShift action_184
action_161 (114) = happyShift action_185
action_161 (118) = happyShift action_186
action_161 (121) = happyShift action_187
action_161 (122) = happyShift action_188
action_161 (129) = happyShift action_2
action_161 (130) = happyShift action_189
action_161 (133) = happyShift action_9
action_161 (134) = happyShift action_34
action_161 (135) = happyShift action_190
action_161 (4) = happyGoto action_162
action_161 (5) = happyGoto action_163
action_161 (8) = happyGoto action_164
action_161 (9) = happyGoto action_165
action_161 (10) = happyGoto action_166
action_161 (50) = happyGoto action_167
action_161 (55) = happyGoto action_168
action_161 (58) = happyGoto action_169
action_161 (61) = happyGoto action_170
action_161 (62) = happyGoto action_171
action_161 (63) = happyGoto action_172
action_161 (64) = happyGoto action_173
action_161 (65) = happyGoto action_174
action_161 (66) = happyGoto action_175
action_161 _ = happyFail (happyExpListPerState 161)

action_162 _ = happyReduce_155

action_163 _ = happyReduce_156

action_164 _ = happyReduce_121

action_165 _ = happyReduce_122

action_166 _ = happyReduce_123

action_167 _ = happyReduce_64

action_168 (57) = happyGoto action_225
action_168 _ = happyReduce_128

action_169 (91) = happyShift action_224
action_169 _ = happyReduce_153

action_170 (83) = happyShift action_223
action_170 _ = happyReduce_111

action_171 (68) = happyShift action_214
action_171 (73) = happyShift action_215
action_171 (75) = happyShift action_216
action_171 (80) = happyShift action_217
action_171 (81) = happyShift action_218
action_171 (85) = happyShift action_219
action_171 (86) = happyShift action_220
action_171 (111) = happyShift action_221
action_171 (127) = happyShift action_222
action_171 _ = happyReduce_145

action_172 (72) = happyShift action_212
action_172 (77) = happyShift action_213
action_172 _ = happyReduce_148

action_173 _ = happyReduce_151

action_174 _ = happyReduce_131

action_175 _ = happyReduce_154

action_176 (132) = happyShift action_211
action_176 (7) = happyGoto action_210
action_176 _ = happyFail (happyExpListPerState 176)

action_177 (131) = happyShift action_209
action_177 (6) = happyGoto action_208
action_177 _ = happyFail (happyExpListPerState 177)

action_178 (67) = happyShift action_176
action_178 (69) = happyShift action_177
action_178 (70) = happyShift action_178
action_178 (72) = happyShift action_132
action_178 (73) = happyShift action_133
action_178 (75) = happyShift action_134
action_178 (77) = happyShift action_135
action_178 (80) = happyShift action_136
action_178 (81) = happyShift action_137
action_178 (83) = happyShift action_138
action_178 (85) = happyShift action_139
action_178 (86) = happyShift action_140
action_178 (88) = happyShift action_179
action_178 (89) = happyShift action_207
action_178 (91) = happyShift action_141
action_178 (92) = happyShift action_180
action_178 (96) = happyShift action_181
action_178 (99) = happyShift action_182
action_178 (103) = happyShift action_183
action_178 (110) = happyShift action_184
action_178 (114) = happyShift action_185
action_178 (118) = happyShift action_186
action_178 (121) = happyShift action_187
action_178 (122) = happyShift action_188
action_178 (129) = happyShift action_2
action_178 (130) = happyShift action_189
action_178 (133) = happyShift action_9
action_178 (134) = happyShift action_34
action_178 (135) = happyShift action_190
action_178 (4) = happyGoto action_162
action_178 (5) = happyGoto action_163
action_178 (8) = happyGoto action_164
action_178 (9) = happyGoto action_165
action_178 (10) = happyGoto action_166
action_178 (39) = happyGoto action_204
action_178 (50) = happyGoto action_205
action_178 (55) = happyGoto action_168
action_178 (58) = happyGoto action_169
action_178 (61) = happyGoto action_170
action_178 (62) = happyGoto action_171
action_178 (63) = happyGoto action_172
action_178 (64) = happyGoto action_173
action_178 (65) = happyGoto action_206
action_178 (66) = happyGoto action_175
action_178 _ = happyFail (happyExpListPerState 178)

action_179 (67) = happyShift action_176
action_179 (69) = happyShift action_177
action_179 (70) = happyShift action_178
action_179 (88) = happyShift action_179
action_179 (92) = happyShift action_180
action_179 (96) = happyShift action_181
action_179 (99) = happyShift action_182
action_179 (103) = happyShift action_183
action_179 (110) = happyShift action_184
action_179 (114) = happyShift action_185
action_179 (118) = happyShift action_186
action_179 (121) = happyShift action_187
action_179 (122) = happyShift action_188
action_179 (129) = happyShift action_2
action_179 (130) = happyShift action_189
action_179 (133) = happyShift action_9
action_179 (134) = happyShift action_34
action_179 (135) = happyShift action_190
action_179 (4) = happyGoto action_162
action_179 (5) = happyGoto action_163
action_179 (8) = happyGoto action_164
action_179 (9) = happyGoto action_165
action_179 (10) = happyGoto action_166
action_179 (50) = happyGoto action_201
action_179 (55) = happyGoto action_168
action_179 (58) = happyGoto action_169
action_179 (59) = happyGoto action_202
action_179 (60) = happyGoto action_203
action_179 (61) = happyGoto action_170
action_179 (62) = happyGoto action_171
action_179 (63) = happyGoto action_172
action_179 (64) = happyGoto action_173
action_179 (65) = happyGoto action_174
action_179 (66) = happyGoto action_175
action_179 _ = happyReduce_133

action_180 _ = happyReduce_159

action_181 (67) = happyShift action_176
action_181 (69) = happyShift action_177
action_181 (70) = happyShift action_178
action_181 (88) = happyShift action_179
action_181 (92) = happyShift action_180
action_181 (96) = happyShift action_181
action_181 (99) = happyShift action_182
action_181 (103) = happyShift action_183
action_181 (110) = happyShift action_184
action_181 (114) = happyShift action_185
action_181 (118) = happyShift action_186
action_181 (121) = happyShift action_187
action_181 (122) = happyShift action_188
action_181 (126) = happyShift action_200
action_181 (129) = happyShift action_2
action_181 (130) = happyShift action_189
action_181 (133) = happyShift action_9
action_181 (134) = happyShift action_34
action_181 (135) = happyShift action_190
action_181 (4) = happyGoto action_162
action_181 (5) = happyGoto action_163
action_181 (8) = happyGoto action_164
action_181 (9) = happyGoto action_165
action_181 (10) = happyGoto action_166
action_181 (50) = happyGoto action_198
action_181 (52) = happyGoto action_199
action_181 (55) = happyGoto action_168
action_181 (58) = happyGoto action_169
action_181 (61) = happyGoto action_170
action_181 (62) = happyGoto action_171
action_181 (63) = happyGoto action_172
action_181 (64) = happyGoto action_173
action_181 (65) = happyGoto action_174
action_181 (66) = happyGoto action_175
action_181 _ = happyFail (happyExpListPerState 181)

action_182 _ = happyReduce_162

action_183 (67) = happyShift action_176
action_183 (69) = happyShift action_177
action_183 (70) = happyShift action_178
action_183 (88) = happyShift action_179
action_183 (92) = happyShift action_180
action_183 (96) = happyShift action_181
action_183 (99) = happyShift action_182
action_183 (103) = happyShift action_183
action_183 (110) = happyShift action_184
action_183 (114) = happyShift action_185
action_183 (118) = happyShift action_186
action_183 (121) = happyShift action_187
action_183 (122) = happyShift action_188
action_183 (129) = happyShift action_2
action_183 (130) = happyShift action_189
action_183 (133) = happyShift action_9
action_183 (134) = happyShift action_34
action_183 (135) = happyShift action_190
action_183 (4) = happyGoto action_162
action_183 (5) = happyGoto action_163
action_183 (8) = happyGoto action_164
action_183 (9) = happyGoto action_165
action_183 (10) = happyGoto action_166
action_183 (50) = happyGoto action_197
action_183 (55) = happyGoto action_168
action_183 (58) = happyGoto action_169
action_183 (61) = happyGoto action_170
action_183 (62) = happyGoto action_171
action_183 (63) = happyGoto action_172
action_183 (64) = happyGoto action_173
action_183 (65) = happyGoto action_174
action_183 (66) = happyGoto action_175
action_183 _ = happyFail (happyExpListPerState 183)

action_184 (67) = happyShift action_176
action_184 (69) = happyShift action_177
action_184 (70) = happyShift action_178
action_184 (88) = happyShift action_179
action_184 (92) = happyShift action_180
action_184 (96) = happyShift action_181
action_184 (99) = happyShift action_182
action_184 (103) = happyShift action_183
action_184 (110) = happyShift action_184
action_184 (114) = happyShift action_185
action_184 (118) = happyShift action_186
action_184 (121) = happyShift action_187
action_184 (122) = happyShift action_188
action_184 (129) = happyShift action_2
action_184 (130) = happyShift action_189
action_184 (133) = happyShift action_9
action_184 (134) = happyShift action_34
action_184 (135) = happyShift action_190
action_184 (4) = happyGoto action_162
action_184 (5) = happyGoto action_163
action_184 (8) = happyGoto action_164
action_184 (9) = happyGoto action_165
action_184 (10) = happyGoto action_166
action_184 (50) = happyGoto action_196
action_184 (55) = happyGoto action_168
action_184 (58) = happyGoto action_169
action_184 (61) = happyGoto action_170
action_184 (62) = happyGoto action_171
action_184 (63) = happyGoto action_172
action_184 (64) = happyGoto action_173
action_184 (65) = happyGoto action_174
action_184 (66) = happyGoto action_175
action_184 _ = happyFail (happyExpListPerState 184)

action_185 (67) = happyShift action_176
action_185 (69) = happyShift action_177
action_185 (70) = happyShift action_195
action_185 (92) = happyShift action_180
action_185 (99) = happyShift action_182
action_185 (118) = happyShift action_186
action_185 (121) = happyShift action_187
action_185 (122) = happyShift action_188
action_185 (129) = happyShift action_2
action_185 (130) = happyShift action_189
action_185 (133) = happyShift action_9
action_185 (134) = happyShift action_34
action_185 (135) = happyShift action_190
action_185 (4) = happyGoto action_162
action_185 (5) = happyGoto action_163
action_185 (8) = happyGoto action_164
action_185 (9) = happyGoto action_165
action_185 (10) = happyGoto action_166
action_185 (55) = happyGoto action_168
action_185 (58) = happyGoto action_169
action_185 (62) = happyGoto action_194
action_185 (63) = happyGoto action_172
action_185 (64) = happyGoto action_173
action_185 (65) = happyGoto action_174
action_185 (66) = happyGoto action_175
action_185 _ = happyFail (happyExpListPerState 185)

action_186 _ = happyReduce_120

action_187 _ = happyReduce_119

action_188 _ = happyReduce_161

action_189 _ = happyReduce_2

action_190 _ = happyReduce_7

action_191 (70) = happyShift action_41
action_191 (133) = happyShift action_9
action_191 (134) = happyShift action_34
action_191 (8) = happyGoto action_36
action_191 (9) = happyGoto action_37
action_191 (21) = happyGoto action_193
action_191 (22) = happyGoto action_39
action_191 _ = happyFail (happyExpListPerState 191)

action_192 _ = happyReduce_80

action_193 (71) = happyShift action_256
action_193 _ = happyFail (happyExpListPerState 193)

action_194 (73) = happyShift action_215
action_194 (75) = happyShift action_216
action_194 _ = happyReduce_138

action_195 (67) = happyShift action_176
action_195 (69) = happyShift action_177
action_195 (70) = happyShift action_178
action_195 (72) = happyShift action_132
action_195 (73) = happyShift action_133
action_195 (75) = happyShift action_134
action_195 (77) = happyShift action_135
action_195 (80) = happyShift action_136
action_195 (81) = happyShift action_137
action_195 (83) = happyShift action_138
action_195 (85) = happyShift action_139
action_195 (86) = happyShift action_140
action_195 (88) = happyShift action_179
action_195 (91) = happyShift action_141
action_195 (92) = happyShift action_180
action_195 (96) = happyShift action_181
action_195 (99) = happyShift action_182
action_195 (103) = happyShift action_183
action_195 (110) = happyShift action_184
action_195 (114) = happyShift action_185
action_195 (118) = happyShift action_186
action_195 (121) = happyShift action_187
action_195 (122) = happyShift action_188
action_195 (129) = happyShift action_2
action_195 (130) = happyShift action_189
action_195 (133) = happyShift action_9
action_195 (134) = happyShift action_34
action_195 (135) = happyShift action_190
action_195 (4) = happyGoto action_162
action_195 (5) = happyGoto action_163
action_195 (8) = happyGoto action_164
action_195 (9) = happyGoto action_165
action_195 (10) = happyGoto action_166
action_195 (39) = happyGoto action_204
action_195 (50) = happyGoto action_205
action_195 (55) = happyGoto action_168
action_195 (58) = happyGoto action_169
action_195 (61) = happyGoto action_170
action_195 (62) = happyGoto action_171
action_195 (63) = happyGoto action_172
action_195 (64) = happyGoto action_173
action_195 (65) = happyGoto action_206
action_195 (66) = happyGoto action_175
action_195 _ = happyFail (happyExpListPerState 195)

action_196 (125) = happyShift action_255
action_196 _ = happyFail (happyExpListPerState 196)

action_197 (120) = happyShift action_254
action_197 _ = happyFail (happyExpListPerState 197)

action_198 (94) = happyShift action_253
action_198 _ = happyFail (happyExpListPerState 198)

action_199 (107) = happyShift action_252
action_199 _ = happyFail (happyExpListPerState 199)

action_200 (67) = happyShift action_176
action_200 (69) = happyShift action_177
action_200 (70) = happyShift action_178
action_200 (88) = happyShift action_179
action_200 (92) = happyShift action_180
action_200 (96) = happyShift action_181
action_200 (99) = happyShift action_182
action_200 (103) = happyShift action_183
action_200 (110) = happyShift action_184
action_200 (114) = happyShift action_185
action_200 (118) = happyShift action_186
action_200 (121) = happyShift action_187
action_200 (122) = happyShift action_188
action_200 (129) = happyShift action_2
action_200 (130) = happyShift action_189
action_200 (133) = happyShift action_9
action_200 (134) = happyShift action_34
action_200 (135) = happyShift action_190
action_200 (4) = happyGoto action_162
action_200 (5) = happyGoto action_163
action_200 (8) = happyGoto action_164
action_200 (9) = happyGoto action_165
action_200 (10) = happyGoto action_166
action_200 (50) = happyGoto action_198
action_200 (51) = happyGoto action_250
action_200 (52) = happyGoto action_251
action_200 (55) = happyGoto action_168
action_200 (58) = happyGoto action_169
action_200 (61) = happyGoto action_170
action_200 (62) = happyGoto action_171
action_200 (63) = happyGoto action_172
action_200 (64) = happyGoto action_173
action_200 (65) = happyGoto action_174
action_200 (66) = happyGoto action_175
action_200 _ = happyReduce_112

action_201 _ = happyReduce_132

action_202 (74) = happyShift action_249
action_202 _ = happyReduce_134

action_203 (90) = happyShift action_248
action_203 _ = happyFail (happyExpListPerState 203)

action_204 (71) = happyShift action_247
action_204 _ = happyFail (happyExpListPerState 204)

action_205 (71) = happyShift action_246
action_205 _ = happyFail (happyExpListPerState 205)

action_206 (71) = happyShift action_245
action_206 _ = happyReduce_131

action_207 (24) = happyGoto action_244
action_207 _ = happyReduce_38

action_208 (69) = happyShift action_243
action_208 _ = happyFail (happyExpListPerState 208)

action_209 _ = happyReduce_3

action_210 (67) = happyShift action_242
action_210 _ = happyFail (happyExpListPerState 210)

action_211 _ = happyReduce_4

action_212 (67) = happyShift action_176
action_212 (69) = happyShift action_177
action_212 (70) = happyShift action_195
action_212 (92) = happyShift action_180
action_212 (99) = happyShift action_182
action_212 (118) = happyShift action_186
action_212 (121) = happyShift action_187
action_212 (122) = happyShift action_188
action_212 (129) = happyShift action_2
action_212 (130) = happyShift action_189
action_212 (133) = happyShift action_9
action_212 (134) = happyShift action_34
action_212 (135) = happyShift action_190
action_212 (4) = happyGoto action_162
action_212 (5) = happyGoto action_163
action_212 (8) = happyGoto action_164
action_212 (9) = happyGoto action_165
action_212 (10) = happyGoto action_166
action_212 (55) = happyGoto action_168
action_212 (58) = happyGoto action_169
action_212 (64) = happyGoto action_241
action_212 (65) = happyGoto action_174
action_212 (66) = happyGoto action_175
action_212 _ = happyFail (happyExpListPerState 212)

action_213 (67) = happyShift action_176
action_213 (69) = happyShift action_177
action_213 (70) = happyShift action_195
action_213 (92) = happyShift action_180
action_213 (99) = happyShift action_182
action_213 (118) = happyShift action_186
action_213 (121) = happyShift action_187
action_213 (122) = happyShift action_188
action_213 (129) = happyShift action_2
action_213 (130) = happyShift action_189
action_213 (133) = happyShift action_9
action_213 (134) = happyShift action_34
action_213 (135) = happyShift action_190
action_213 (4) = happyGoto action_162
action_213 (5) = happyGoto action_163
action_213 (8) = happyGoto action_164
action_213 (9) = happyGoto action_165
action_213 (10) = happyGoto action_166
action_213 (55) = happyGoto action_168
action_213 (58) = happyGoto action_169
action_213 (64) = happyGoto action_240
action_213 (65) = happyGoto action_174
action_213 (66) = happyGoto action_175
action_213 _ = happyFail (happyExpListPerState 213)

action_214 (67) = happyShift action_176
action_214 (69) = happyShift action_177
action_214 (70) = happyShift action_195
action_214 (92) = happyShift action_180
action_214 (99) = happyShift action_182
action_214 (118) = happyShift action_186
action_214 (121) = happyShift action_187
action_214 (122) = happyShift action_188
action_214 (129) = happyShift action_2
action_214 (130) = happyShift action_189
action_214 (133) = happyShift action_9
action_214 (134) = happyShift action_34
action_214 (135) = happyShift action_190
action_214 (4) = happyGoto action_162
action_214 (5) = happyGoto action_163
action_214 (8) = happyGoto action_164
action_214 (9) = happyGoto action_165
action_214 (10) = happyGoto action_166
action_214 (55) = happyGoto action_168
action_214 (58) = happyGoto action_169
action_214 (62) = happyGoto action_239
action_214 (63) = happyGoto action_172
action_214 (64) = happyGoto action_173
action_214 (65) = happyGoto action_174
action_214 (66) = happyGoto action_175
action_214 _ = happyFail (happyExpListPerState 214)

action_215 (67) = happyShift action_176
action_215 (69) = happyShift action_177
action_215 (70) = happyShift action_195
action_215 (92) = happyShift action_180
action_215 (99) = happyShift action_182
action_215 (118) = happyShift action_186
action_215 (121) = happyShift action_187
action_215 (122) = happyShift action_188
action_215 (129) = happyShift action_2
action_215 (130) = happyShift action_189
action_215 (133) = happyShift action_9
action_215 (134) = happyShift action_34
action_215 (135) = happyShift action_190
action_215 (4) = happyGoto action_162
action_215 (5) = happyGoto action_163
action_215 (8) = happyGoto action_164
action_215 (9) = happyGoto action_165
action_215 (10) = happyGoto action_166
action_215 (55) = happyGoto action_168
action_215 (58) = happyGoto action_169
action_215 (63) = happyGoto action_238
action_215 (64) = happyGoto action_173
action_215 (65) = happyGoto action_174
action_215 (66) = happyGoto action_175
action_215 _ = happyFail (happyExpListPerState 215)

action_216 (67) = happyShift action_176
action_216 (69) = happyShift action_177
action_216 (70) = happyShift action_195
action_216 (92) = happyShift action_180
action_216 (99) = happyShift action_182
action_216 (118) = happyShift action_186
action_216 (121) = happyShift action_187
action_216 (122) = happyShift action_188
action_216 (129) = happyShift action_2
action_216 (130) = happyShift action_189
action_216 (133) = happyShift action_9
action_216 (134) = happyShift action_34
action_216 (135) = happyShift action_190
action_216 (4) = happyGoto action_162
action_216 (5) = happyGoto action_163
action_216 (8) = happyGoto action_164
action_216 (9) = happyGoto action_165
action_216 (10) = happyGoto action_166
action_216 (55) = happyGoto action_168
action_216 (58) = happyGoto action_169
action_216 (63) = happyGoto action_237
action_216 (64) = happyGoto action_173
action_216 (65) = happyGoto action_174
action_216 (66) = happyGoto action_175
action_216 _ = happyFail (happyExpListPerState 216)

action_217 (67) = happyShift action_176
action_217 (69) = happyShift action_177
action_217 (70) = happyShift action_195
action_217 (92) = happyShift action_180
action_217 (99) = happyShift action_182
action_217 (118) = happyShift action_186
action_217 (121) = happyShift action_187
action_217 (122) = happyShift action_188
action_217 (129) = happyShift action_2
action_217 (130) = happyShift action_189
action_217 (133) = happyShift action_9
action_217 (134) = happyShift action_34
action_217 (135) = happyShift action_190
action_217 (4) = happyGoto action_162
action_217 (5) = happyGoto action_163
action_217 (8) = happyGoto action_164
action_217 (9) = happyGoto action_165
action_217 (10) = happyGoto action_166
action_217 (55) = happyGoto action_168
action_217 (58) = happyGoto action_169
action_217 (62) = happyGoto action_236
action_217 (63) = happyGoto action_172
action_217 (64) = happyGoto action_173
action_217 (65) = happyGoto action_174
action_217 (66) = happyGoto action_175
action_217 _ = happyFail (happyExpListPerState 217)

action_218 (67) = happyShift action_176
action_218 (69) = happyShift action_177
action_218 (70) = happyShift action_195
action_218 (92) = happyShift action_180
action_218 (99) = happyShift action_182
action_218 (118) = happyShift action_186
action_218 (121) = happyShift action_187
action_218 (122) = happyShift action_188
action_218 (129) = happyShift action_2
action_218 (130) = happyShift action_189
action_218 (133) = happyShift action_9
action_218 (134) = happyShift action_34
action_218 (135) = happyShift action_190
action_218 (4) = happyGoto action_162
action_218 (5) = happyGoto action_163
action_218 (8) = happyGoto action_164
action_218 (9) = happyGoto action_165
action_218 (10) = happyGoto action_166
action_218 (55) = happyGoto action_168
action_218 (58) = happyGoto action_169
action_218 (62) = happyGoto action_235
action_218 (63) = happyGoto action_172
action_218 (64) = happyGoto action_173
action_218 (65) = happyGoto action_174
action_218 (66) = happyGoto action_175
action_218 _ = happyFail (happyExpListPerState 218)

action_219 (67) = happyShift action_176
action_219 (69) = happyShift action_177
action_219 (70) = happyShift action_195
action_219 (92) = happyShift action_180
action_219 (99) = happyShift action_182
action_219 (118) = happyShift action_186
action_219 (121) = happyShift action_187
action_219 (122) = happyShift action_188
action_219 (129) = happyShift action_2
action_219 (130) = happyShift action_189
action_219 (133) = happyShift action_9
action_219 (134) = happyShift action_34
action_219 (135) = happyShift action_190
action_219 (4) = happyGoto action_162
action_219 (5) = happyGoto action_163
action_219 (8) = happyGoto action_164
action_219 (9) = happyGoto action_165
action_219 (10) = happyGoto action_166
action_219 (55) = happyGoto action_168
action_219 (58) = happyGoto action_169
action_219 (62) = happyGoto action_234
action_219 (63) = happyGoto action_172
action_219 (64) = happyGoto action_173
action_219 (65) = happyGoto action_174
action_219 (66) = happyGoto action_175
action_219 _ = happyFail (happyExpListPerState 219)

action_220 (67) = happyShift action_176
action_220 (69) = happyShift action_177
action_220 (70) = happyShift action_195
action_220 (92) = happyShift action_180
action_220 (99) = happyShift action_182
action_220 (118) = happyShift action_186
action_220 (121) = happyShift action_187
action_220 (122) = happyShift action_188
action_220 (129) = happyShift action_2
action_220 (130) = happyShift action_189
action_220 (133) = happyShift action_9
action_220 (134) = happyShift action_34
action_220 (135) = happyShift action_190
action_220 (4) = happyGoto action_162
action_220 (5) = happyGoto action_163
action_220 (8) = happyGoto action_164
action_220 (9) = happyGoto action_165
action_220 (10) = happyGoto action_166
action_220 (55) = happyGoto action_168
action_220 (58) = happyGoto action_169
action_220 (62) = happyGoto action_233
action_220 (63) = happyGoto action_172
action_220 (64) = happyGoto action_173
action_220 (65) = happyGoto action_174
action_220 (66) = happyGoto action_175
action_220 _ = happyFail (happyExpListPerState 220)

action_221 (67) = happyShift action_176
action_221 (69) = happyShift action_177
action_221 (70) = happyShift action_195
action_221 (92) = happyShift action_180
action_221 (99) = happyShift action_182
action_221 (118) = happyShift action_186
action_221 (121) = happyShift action_187
action_221 (122) = happyShift action_188
action_221 (129) = happyShift action_2
action_221 (130) = happyShift action_189
action_221 (133) = happyShift action_9
action_221 (134) = happyShift action_34
action_221 (135) = happyShift action_190
action_221 (4) = happyGoto action_162
action_221 (5) = happyGoto action_163
action_221 (8) = happyGoto action_164
action_221 (9) = happyGoto action_165
action_221 (10) = happyGoto action_166
action_221 (55) = happyGoto action_168
action_221 (58) = happyGoto action_169
action_221 (62) = happyGoto action_232
action_221 (63) = happyGoto action_172
action_221 (64) = happyGoto action_173
action_221 (65) = happyGoto action_174
action_221 (66) = happyGoto action_175
action_221 _ = happyFail (happyExpListPerState 221)

action_222 (67) = happyShift action_176
action_222 (69) = happyShift action_177
action_222 (70) = happyShift action_195
action_222 (92) = happyShift action_180
action_222 (99) = happyShift action_182
action_222 (118) = happyShift action_186
action_222 (121) = happyShift action_187
action_222 (122) = happyShift action_188
action_222 (129) = happyShift action_2
action_222 (130) = happyShift action_189
action_222 (133) = happyShift action_9
action_222 (134) = happyShift action_34
action_222 (135) = happyShift action_190
action_222 (4) = happyGoto action_162
action_222 (5) = happyGoto action_163
action_222 (8) = happyGoto action_164
action_222 (9) = happyGoto action_165
action_222 (10) = happyGoto action_166
action_222 (55) = happyGoto action_168
action_222 (58) = happyGoto action_169
action_222 (62) = happyGoto action_231
action_222 (63) = happyGoto action_172
action_222 (64) = happyGoto action_173
action_222 (65) = happyGoto action_174
action_222 (66) = happyGoto action_175
action_222 _ = happyFail (happyExpListPerState 222)

action_223 (67) = happyShift action_176
action_223 (69) = happyShift action_177
action_223 (70) = happyShift action_195
action_223 (92) = happyShift action_180
action_223 (99) = happyShift action_182
action_223 (118) = happyShift action_186
action_223 (121) = happyShift action_187
action_223 (122) = happyShift action_188
action_223 (129) = happyShift action_2
action_223 (130) = happyShift action_189
action_223 (133) = happyShift action_9
action_223 (134) = happyShift action_34
action_223 (135) = happyShift action_190
action_223 (4) = happyGoto action_162
action_223 (5) = happyGoto action_163
action_223 (8) = happyGoto action_164
action_223 (9) = happyGoto action_165
action_223 (10) = happyGoto action_166
action_223 (55) = happyGoto action_168
action_223 (58) = happyGoto action_169
action_223 (62) = happyGoto action_230
action_223 (63) = happyGoto action_172
action_223 (64) = happyGoto action_173
action_223 (65) = happyGoto action_174
action_223 (66) = happyGoto action_175
action_223 _ = happyFail (happyExpListPerState 223)

action_224 (67) = happyShift action_176
action_224 (69) = happyShift action_177
action_224 (70) = happyShift action_195
action_224 (92) = happyShift action_180
action_224 (99) = happyShift action_182
action_224 (118) = happyShift action_186
action_224 (121) = happyShift action_187
action_224 (122) = happyShift action_188
action_224 (129) = happyShift action_2
action_224 (130) = happyShift action_189
action_224 (133) = happyShift action_9
action_224 (134) = happyShift action_34
action_224 (135) = happyShift action_190
action_224 (4) = happyGoto action_162
action_224 (5) = happyGoto action_163
action_224 (8) = happyGoto action_164
action_224 (9) = happyGoto action_165
action_224 (10) = happyGoto action_166
action_224 (55) = happyGoto action_168
action_224 (58) = happyGoto action_169
action_224 (64) = happyGoto action_229
action_224 (65) = happyGoto action_174
action_224 (66) = happyGoto action_175
action_224 _ = happyFail (happyExpListPerState 224)

action_225 (67) = happyShift action_176
action_225 (69) = happyShift action_177
action_225 (70) = happyShift action_195
action_225 (92) = happyShift action_180
action_225 (99) = happyShift action_182
action_225 (118) = happyShift action_186
action_225 (121) = happyShift action_187
action_225 (122) = happyShift action_188
action_225 (129) = happyShift action_2
action_225 (130) = happyShift action_189
action_225 (133) = happyShift action_9
action_225 (134) = happyShift action_34
action_225 (135) = happyShift action_190
action_225 (4) = happyGoto action_162
action_225 (5) = happyGoto action_163
action_225 (8) = happyGoto action_164
action_225 (9) = happyGoto action_165
action_225 (10) = happyGoto action_166
action_225 (55) = happyGoto action_226
action_225 (56) = happyGoto action_227
action_225 (65) = happyGoto action_228
action_225 (66) = happyGoto action_175
action_225 _ = happyReduce_130

action_226 _ = happyReduce_127

action_227 _ = happyReduce_129

action_228 _ = happyReduce_126

action_229 _ = happyReduce_152

action_230 (73) = happyShift action_215
action_230 (75) = happyShift action_216
action_230 _ = happyReduce_136

action_231 (73) = happyShift action_215
action_231 (75) = happyShift action_216
action_231 _ = happyReduce_139

action_232 (73) = happyShift action_215
action_232 (75) = happyShift action_216
action_232 _ = happyReduce_137

action_233 (73) = happyShift action_215
action_233 (75) = happyShift action_216
action_233 _ = happyReduce_144

action_234 (73) = happyShift action_215
action_234 (75) = happyShift action_216
action_234 _ = happyReduce_142

action_235 (73) = happyShift action_215
action_235 (75) = happyShift action_216
action_235 _ = happyReduce_143

action_236 (73) = happyShift action_215
action_236 (75) = happyShift action_216
action_236 _ = happyReduce_141

action_237 (72) = happyShift action_212
action_237 (77) = happyShift action_213
action_237 _ = happyReduce_147

action_238 (72) = happyShift action_212
action_238 (77) = happyShift action_213
action_238 _ = happyReduce_146

action_239 (73) = happyShift action_215
action_239 (75) = happyShift action_216
action_239 _ = happyReduce_140

action_240 _ = happyReduce_150

action_241 _ = happyReduce_149

action_242 _ = happyReduce_158

action_243 _ = happyReduce_157

action_244 (70) = happyShift action_153
action_244 (78) = happyShift action_264
action_244 (134) = happyShift action_34
action_244 (9) = happyGoto action_149
action_244 (25) = happyGoto action_150
action_244 _ = happyFail (happyExpListPerState 244)

action_245 _ = happyReduce_125

action_246 _ = happyReduce_160

action_247 _ = happyReduce_124

action_248 _ = happyReduce_110

action_249 (67) = happyShift action_176
action_249 (69) = happyShift action_177
action_249 (70) = happyShift action_178
action_249 (88) = happyShift action_179
action_249 (92) = happyShift action_180
action_249 (96) = happyShift action_181
action_249 (99) = happyShift action_182
action_249 (103) = happyShift action_183
action_249 (110) = happyShift action_184
action_249 (114) = happyShift action_185
action_249 (118) = happyShift action_186
action_249 (121) = happyShift action_187
action_249 (122) = happyShift action_188
action_249 (129) = happyShift action_2
action_249 (130) = happyShift action_189
action_249 (133) = happyShift action_9
action_249 (134) = happyShift action_34
action_249 (135) = happyShift action_190
action_249 (4) = happyGoto action_162
action_249 (5) = happyGoto action_163
action_249 (8) = happyGoto action_164
action_249 (9) = happyGoto action_165
action_249 (10) = happyGoto action_166
action_249 (50) = happyGoto action_201
action_249 (55) = happyGoto action_168
action_249 (58) = happyGoto action_169
action_249 (59) = happyGoto action_202
action_249 (60) = happyGoto action_263
action_249 (61) = happyGoto action_170
action_249 (62) = happyGoto action_171
action_249 (63) = happyGoto action_172
action_249 (64) = happyGoto action_173
action_249 (65) = happyGoto action_174
action_249 (66) = happyGoto action_175
action_249 _ = happyReduce_133

action_250 (128) = happyShift action_262
action_250 _ = happyFail (happyExpListPerState 250)

action_251 (79) = happyShift action_261
action_251 _ = happyReduce_113

action_252 (67) = happyShift action_176
action_252 (69) = happyShift action_177
action_252 (70) = happyShift action_178
action_252 (88) = happyShift action_179
action_252 (92) = happyShift action_180
action_252 (96) = happyShift action_181
action_252 (99) = happyShift action_182
action_252 (103) = happyShift action_183
action_252 (110) = happyShift action_184
action_252 (114) = happyShift action_185
action_252 (118) = happyShift action_186
action_252 (121) = happyShift action_187
action_252 (122) = happyShift action_188
action_252 (129) = happyShift action_2
action_252 (130) = happyShift action_189
action_252 (133) = happyShift action_9
action_252 (134) = happyShift action_34
action_252 (135) = happyShift action_190
action_252 (4) = happyGoto action_162
action_252 (5) = happyGoto action_163
action_252 (8) = happyGoto action_164
action_252 (9) = happyGoto action_165
action_252 (10) = happyGoto action_166
action_252 (50) = happyGoto action_260
action_252 (55) = happyGoto action_168
action_252 (58) = happyGoto action_169
action_252 (61) = happyGoto action_170
action_252 (62) = happyGoto action_171
action_252 (63) = happyGoto action_172
action_252 (64) = happyGoto action_173
action_252 (65) = happyGoto action_174
action_252 (66) = happyGoto action_175
action_252 _ = happyFail (happyExpListPerState 252)

action_253 (134) = happyShift action_34
action_253 (9) = happyGoto action_259
action_253 _ = happyFail (happyExpListPerState 253)

action_254 (67) = happyShift action_176
action_254 (69) = happyShift action_177
action_254 (70) = happyShift action_178
action_254 (88) = happyShift action_179
action_254 (92) = happyShift action_180
action_254 (96) = happyShift action_181
action_254 (99) = happyShift action_182
action_254 (103) = happyShift action_183
action_254 (110) = happyShift action_184
action_254 (114) = happyShift action_185
action_254 (118) = happyShift action_186
action_254 (121) = happyShift action_187
action_254 (122) = happyShift action_188
action_254 (129) = happyShift action_2
action_254 (130) = happyShift action_189
action_254 (133) = happyShift action_9
action_254 (134) = happyShift action_34
action_254 (135) = happyShift action_190
action_254 (4) = happyGoto action_162
action_254 (5) = happyGoto action_163
action_254 (8) = happyGoto action_164
action_254 (9) = happyGoto action_165
action_254 (10) = happyGoto action_166
action_254 (50) = happyGoto action_258
action_254 (55) = happyGoto action_168
action_254 (58) = happyGoto action_169
action_254 (61) = happyGoto action_170
action_254 (62) = happyGoto action_171
action_254 (63) = happyGoto action_172
action_254 (64) = happyGoto action_173
action_254 (65) = happyGoto action_174
action_254 (66) = happyGoto action_175
action_254 _ = happyFail (happyExpListPerState 254)

action_255 (126) = happyShift action_257
action_255 _ = happyFail (happyExpListPerState 255)

action_256 _ = happyReduce_40

action_257 (67) = happyShift action_176
action_257 (69) = happyShift action_177
action_257 (70) = happyShift action_178
action_257 (88) = happyShift action_179
action_257 (92) = happyShift action_180
action_257 (96) = happyShift action_181
action_257 (99) = happyShift action_182
action_257 (103) = happyShift action_183
action_257 (110) = happyShift action_184
action_257 (114) = happyShift action_185
action_257 (118) = happyShift action_186
action_257 (121) = happyShift action_187
action_257 (122) = happyShift action_188
action_257 (129) = happyShift action_2
action_257 (130) = happyShift action_189
action_257 (133) = happyShift action_9
action_257 (134) = happyShift action_34
action_257 (135) = happyShift action_190
action_257 (4) = happyGoto action_162
action_257 (5) = happyGoto action_163
action_257 (8) = happyGoto action_164
action_257 (9) = happyGoto action_165
action_257 (10) = happyGoto action_166
action_257 (50) = happyGoto action_269
action_257 (53) = happyGoto action_270
action_257 (54) = happyGoto action_271
action_257 (55) = happyGoto action_168
action_257 (58) = happyGoto action_169
action_257 (61) = happyGoto action_170
action_257 (62) = happyGoto action_171
action_257 (63) = happyGoto action_172
action_257 (64) = happyGoto action_173
action_257 (65) = happyGoto action_174
action_257 (66) = happyGoto action_175
action_257 _ = happyFail (happyExpListPerState 257)

action_258 (98) = happyShift action_268
action_258 _ = happyFail (happyExpListPerState 258)

action_259 _ = happyReduce_115

action_260 _ = happyReduce_106

action_261 (67) = happyShift action_176
action_261 (69) = happyShift action_177
action_261 (70) = happyShift action_178
action_261 (88) = happyShift action_179
action_261 (92) = happyShift action_180
action_261 (96) = happyShift action_181
action_261 (99) = happyShift action_182
action_261 (103) = happyShift action_183
action_261 (110) = happyShift action_184
action_261 (114) = happyShift action_185
action_261 (118) = happyShift action_186
action_261 (121) = happyShift action_187
action_261 (122) = happyShift action_188
action_261 (129) = happyShift action_2
action_261 (130) = happyShift action_189
action_261 (133) = happyShift action_9
action_261 (134) = happyShift action_34
action_261 (135) = happyShift action_190
action_261 (4) = happyGoto action_162
action_261 (5) = happyGoto action_163
action_261 (8) = happyGoto action_164
action_261 (9) = happyGoto action_165
action_261 (10) = happyGoto action_166
action_261 (50) = happyGoto action_198
action_261 (51) = happyGoto action_267
action_261 (52) = happyGoto action_251
action_261 (55) = happyGoto action_168
action_261 (58) = happyGoto action_169
action_261 (61) = happyGoto action_170
action_261 (62) = happyGoto action_171
action_261 (63) = happyGoto action_172
action_261 (64) = happyGoto action_173
action_261 (65) = happyGoto action_174
action_261 (66) = happyGoto action_175
action_261 _ = happyReduce_112

action_262 (107) = happyShift action_266
action_262 _ = happyFail (happyExpListPerState 262)

action_263 _ = happyReduce_135

action_264 (70) = happyShift action_89
action_264 (133) = happyShift action_9
action_264 (134) = happyShift action_34
action_264 (8) = happyGoto action_84
action_264 (9) = happyGoto action_85
action_264 (17) = happyGoto action_265
action_264 (18) = happyGoto action_87
action_264 _ = happyFail (happyExpListPerState 264)

action_265 (84) = happyShift action_277
action_265 _ = happyFail (happyExpListPerState 265)

action_266 (67) = happyShift action_176
action_266 (69) = happyShift action_177
action_266 (70) = happyShift action_178
action_266 (88) = happyShift action_179
action_266 (92) = happyShift action_180
action_266 (96) = happyShift action_181
action_266 (99) = happyShift action_182
action_266 (103) = happyShift action_183
action_266 (110) = happyShift action_184
action_266 (114) = happyShift action_185
action_266 (118) = happyShift action_186
action_266 (121) = happyShift action_187
action_266 (122) = happyShift action_188
action_266 (129) = happyShift action_2
action_266 (130) = happyShift action_189
action_266 (133) = happyShift action_9
action_266 (134) = happyShift action_34
action_266 (135) = happyShift action_190
action_266 (4) = happyGoto action_162
action_266 (5) = happyGoto action_163
action_266 (8) = happyGoto action_164
action_266 (9) = happyGoto action_165
action_266 (10) = happyGoto action_166
action_266 (50) = happyGoto action_276
action_266 (55) = happyGoto action_168
action_266 (58) = happyGoto action_169
action_266 (61) = happyGoto action_170
action_266 (62) = happyGoto action_171
action_266 (63) = happyGoto action_172
action_266 (64) = happyGoto action_173
action_266 (65) = happyGoto action_174
action_266 (66) = happyGoto action_175
action_266 _ = happyFail (happyExpListPerState 266)

action_267 _ = happyReduce_114

action_268 (67) = happyShift action_176
action_268 (69) = happyShift action_177
action_268 (70) = happyShift action_178
action_268 (88) = happyShift action_179
action_268 (92) = happyShift action_180
action_268 (96) = happyShift action_181
action_268 (99) = happyShift action_182
action_268 (103) = happyShift action_183
action_268 (110) = happyShift action_184
action_268 (114) = happyShift action_185
action_268 (118) = happyShift action_186
action_268 (121) = happyShift action_187
action_268 (122) = happyShift action_188
action_268 (129) = happyShift action_2
action_268 (130) = happyShift action_189
action_268 (133) = happyShift action_9
action_268 (134) = happyShift action_34
action_268 (135) = happyShift action_190
action_268 (4) = happyGoto action_162
action_268 (5) = happyGoto action_163
action_268 (8) = happyGoto action_164
action_268 (9) = happyGoto action_165
action_268 (10) = happyGoto action_166
action_268 (50) = happyGoto action_275
action_268 (55) = happyGoto action_168
action_268 (58) = happyGoto action_169
action_268 (61) = happyGoto action_170
action_268 (62) = happyGoto action_171
action_268 (63) = happyGoto action_172
action_268 (64) = happyGoto action_173
action_268 (65) = happyGoto action_174
action_268 (66) = happyGoto action_175
action_268 _ = happyFail (happyExpListPerState 268)

action_269 (76) = happyShift action_274
action_269 _ = happyFail (happyExpListPerState 269)

action_270 (128) = happyShift action_273
action_270 _ = happyFail (happyExpListPerState 270)

action_271 (79) = happyShift action_272
action_271 _ = happyReduce_116

action_272 (67) = happyShift action_176
action_272 (69) = happyShift action_177
action_272 (70) = happyShift action_178
action_272 (88) = happyShift action_179
action_272 (92) = happyShift action_180
action_272 (96) = happyShift action_181
action_272 (99) = happyShift action_182
action_272 (103) = happyShift action_183
action_272 (110) = happyShift action_184
action_272 (114) = happyShift action_185
action_272 (118) = happyShift action_186
action_272 (121) = happyShift action_187
action_272 (122) = happyShift action_188
action_272 (129) = happyShift action_2
action_272 (130) = happyShift action_189
action_272 (133) = happyShift action_9
action_272 (134) = happyShift action_34
action_272 (135) = happyShift action_190
action_272 (4) = happyGoto action_162
action_272 (5) = happyGoto action_163
action_272 (8) = happyGoto action_164
action_272 (9) = happyGoto action_165
action_272 (10) = happyGoto action_166
action_272 (50) = happyGoto action_269
action_272 (53) = happyGoto action_280
action_272 (54) = happyGoto action_271
action_272 (55) = happyGoto action_168
action_272 (58) = happyGoto action_169
action_272 (61) = happyGoto action_170
action_272 (62) = happyGoto action_171
action_272 (63) = happyGoto action_172
action_272 (64) = happyGoto action_173
action_272 (65) = happyGoto action_174
action_272 (66) = happyGoto action_175
action_272 _ = happyFail (happyExpListPerState 272)

action_273 _ = happyReduce_107

action_274 (67) = happyShift action_176
action_274 (69) = happyShift action_177
action_274 (70) = happyShift action_178
action_274 (88) = happyShift action_179
action_274 (92) = happyShift action_180
action_274 (96) = happyShift action_181
action_274 (99) = happyShift action_182
action_274 (103) = happyShift action_183
action_274 (110) = happyShift action_184
action_274 (114) = happyShift action_185
action_274 (118) = happyShift action_186
action_274 (121) = happyShift action_187
action_274 (122) = happyShift action_188
action_274 (129) = happyShift action_2
action_274 (130) = happyShift action_189
action_274 (133) = happyShift action_9
action_274 (134) = happyShift action_34
action_274 (135) = happyShift action_190
action_274 (4) = happyGoto action_162
action_274 (5) = happyGoto action_163
action_274 (8) = happyGoto action_164
action_274 (9) = happyGoto action_165
action_274 (10) = happyGoto action_166
action_274 (50) = happyGoto action_279
action_274 (55) = happyGoto action_168
action_274 (58) = happyGoto action_169
action_274 (61) = happyGoto action_170
action_274 (62) = happyGoto action_171
action_274 (63) = happyGoto action_172
action_274 (64) = happyGoto action_173
action_274 (65) = happyGoto action_174
action_274 (66) = happyGoto action_175
action_274 _ = happyFail (happyExpListPerState 274)

action_275 _ = happyReduce_108

action_276 _ = happyReduce_105

action_277 (67) = happyShift action_176
action_277 (69) = happyShift action_177
action_277 (70) = happyShift action_178
action_277 (88) = happyShift action_179
action_277 (92) = happyShift action_180
action_277 (96) = happyShift action_181
action_277 (99) = happyShift action_182
action_277 (103) = happyShift action_183
action_277 (110) = happyShift action_184
action_277 (114) = happyShift action_185
action_277 (118) = happyShift action_186
action_277 (121) = happyShift action_187
action_277 (122) = happyShift action_188
action_277 (129) = happyShift action_2
action_277 (130) = happyShift action_189
action_277 (133) = happyShift action_9
action_277 (134) = happyShift action_34
action_277 (135) = happyShift action_190
action_277 (4) = happyGoto action_162
action_277 (5) = happyGoto action_163
action_277 (8) = happyGoto action_164
action_277 (9) = happyGoto action_165
action_277 (10) = happyGoto action_166
action_277 (50) = happyGoto action_278
action_277 (55) = happyGoto action_168
action_277 (58) = happyGoto action_169
action_277 (61) = happyGoto action_170
action_277 (62) = happyGoto action_171
action_277 (63) = happyGoto action_172
action_277 (64) = happyGoto action_173
action_277 (65) = happyGoto action_174
action_277 (66) = happyGoto action_175
action_277 _ = happyFail (happyExpListPerState 277)

action_278 (71) = happyShift action_281
action_278 _ = happyFail (happyExpListPerState 278)

action_279 _ = happyReduce_118

action_280 _ = happyReduce_117

action_281 _ = happyReduce_109

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

happyReduce_38 = happySpecReduce_0  24 happyReduction_38
happyReduction_38  =  HappyAbsSyn24
		 ([]
	)

happyReduce_39 = happySpecReduce_2  24 happyReduction_39
happyReduction_39 (HappyAbsSyn25  happy_var_2)
	(HappyAbsSyn24  happy_var_1)
	 =  HappyAbsSyn24
		 (flip (:) happy_var_1 happy_var_2
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
		 (AbsVarg.MemberFunctionDefinition (reverse happy_var_1) happy_var_3 happy_var_4 (reverse happy_var_5) happy_var_6 happy_var_8
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
		 (AbsVarg.AbstractFunctionDefinition (reverse happy_var_1) happy_var_3 happy_var_4 (reverse happy_var_5) happy_var_6
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
		 (AbsVarg.ELambda (reverse happy_var_3) happy_var_5 happy_var_7
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
		 (AbsVarg.EMod happy_var_1 happy_var_3
	)
happyReduction_137 _ _ _  = notHappyAtAll 

happyReduce_138 = happySpecReduce_2  61 happyReduction_138
happyReduction_138 (HappyAbsSyn50  happy_var_2)
	_
	 =  HappyAbsSyn50
		 (AbsVarg.ENot happy_var_2
	)
happyReduction_138 _ _  = notHappyAtAll 

happyReduce_139 = happySpecReduce_3  61 happyReduction_139
happyReduction_139 (HappyAbsSyn50  happy_var_3)
	_
	(HappyAbsSyn50  happy_var_1)
	 =  HappyAbsSyn50
		 (AbsVarg.EOr happy_var_1 happy_var_3
	)
happyReduction_139 _ _ _  = notHappyAtAll 

happyReduce_140 = happySpecReduce_3  61 happyReduction_140
happyReduction_140 (HappyAbsSyn50  happy_var_3)
	_
	(HappyAbsSyn50  happy_var_1)
	 =  HappyAbsSyn50
		 (AbsVarg.EAnd happy_var_1 happy_var_3
	)
happyReduction_140 _ _ _  = notHappyAtAll 

happyReduce_141 = happySpecReduce_3  61 happyReduction_141
happyReduction_141 (HappyAbsSyn50  happy_var_3)
	_
	(HappyAbsSyn50  happy_var_1)
	 =  HappyAbsSyn50
		 (AbsVarg.ELt happy_var_1 happy_var_3
	)
happyReduction_141 _ _ _  = notHappyAtAll 

happyReduce_142 = happySpecReduce_3  61 happyReduction_142
happyReduction_142 (HappyAbsSyn50  happy_var_3)
	_
	(HappyAbsSyn50  happy_var_1)
	 =  HappyAbsSyn50
		 (AbsVarg.EGt happy_var_1 happy_var_3
	)
happyReduction_142 _ _ _  = notHappyAtAll 

happyReduce_143 = happySpecReduce_3  61 happyReduction_143
happyReduction_143 (HappyAbsSyn50  happy_var_3)
	_
	(HappyAbsSyn50  happy_var_1)
	 =  HappyAbsSyn50
		 (AbsVarg.ELeq happy_var_1 happy_var_3
	)
happyReduction_143 _ _ _  = notHappyAtAll 

happyReduce_144 = happySpecReduce_3  61 happyReduction_144
happyReduction_144 (HappyAbsSyn50  happy_var_3)
	_
	(HappyAbsSyn50  happy_var_1)
	 =  HappyAbsSyn50
		 (AbsVarg.EGeq happy_var_1 happy_var_3
	)
happyReduction_144 _ _ _  = notHappyAtAll 

happyReduce_145 = happySpecReduce_1  61 happyReduction_145
happyReduction_145 (HappyAbsSyn50  happy_var_1)
	 =  HappyAbsSyn50
		 (happy_var_1
	)
happyReduction_145 _  = notHappyAtAll 

happyReduce_146 = happySpecReduce_3  62 happyReduction_146
happyReduction_146 (HappyAbsSyn50  happy_var_3)
	_
	(HappyAbsSyn50  happy_var_1)
	 =  HappyAbsSyn50
		 (AbsVarg.EAdd happy_var_1 happy_var_3
	)
happyReduction_146 _ _ _  = notHappyAtAll 

happyReduce_147 = happySpecReduce_3  62 happyReduction_147
happyReduction_147 (HappyAbsSyn50  happy_var_3)
	_
	(HappyAbsSyn50  happy_var_1)
	 =  HappyAbsSyn50
		 (AbsVarg.ESub happy_var_1 happy_var_3
	)
happyReduction_147 _ _ _  = notHappyAtAll 

happyReduce_148 = happySpecReduce_1  62 happyReduction_148
happyReduction_148 (HappyAbsSyn50  happy_var_1)
	 =  HappyAbsSyn50
		 (happy_var_1
	)
happyReduction_148 _  = notHappyAtAll 

happyReduce_149 = happySpecReduce_3  63 happyReduction_149
happyReduction_149 (HappyAbsSyn50  happy_var_3)
	_
	(HappyAbsSyn50  happy_var_1)
	 =  HappyAbsSyn50
		 (AbsVarg.EMul happy_var_1 happy_var_3
	)
happyReduction_149 _ _ _  = notHappyAtAll 

happyReduce_150 = happySpecReduce_3  63 happyReduction_150
happyReduction_150 (HappyAbsSyn50  happy_var_3)
	_
	(HappyAbsSyn50  happy_var_1)
	 =  HappyAbsSyn50
		 (AbsVarg.EDiv happy_var_1 happy_var_3
	)
happyReduction_150 _ _ _  = notHappyAtAll 

happyReduce_151 = happySpecReduce_1  63 happyReduction_151
happyReduction_151 (HappyAbsSyn50  happy_var_1)
	 =  HappyAbsSyn50
		 (happy_var_1
	)
happyReduction_151 _  = notHappyAtAll 

happyReduce_152 = happySpecReduce_3  64 happyReduction_152
happyReduction_152 (HappyAbsSyn50  happy_var_3)
	_
	(HappyAbsSyn50  happy_var_1)
	 =  HappyAbsSyn50
		 (AbsVarg.EPow happy_var_1 happy_var_3
	)
happyReduction_152 _ _ _  = notHappyAtAll 

happyReduce_153 = happySpecReduce_1  64 happyReduction_153
happyReduction_153 (HappyAbsSyn50  happy_var_1)
	 =  HappyAbsSyn50
		 (happy_var_1
	)
happyReduction_153 _  = notHappyAtAll 

happyReduce_154 = happySpecReduce_1  65 happyReduction_154
happyReduction_154 (HappyAbsSyn66  happy_var_1)
	 =  HappyAbsSyn50
		 (AbsVarg.EBoolean happy_var_1
	)
happyReduction_154 _  = notHappyAtAll 

happyReduce_155 = happySpecReduce_1  65 happyReduction_155
happyReduction_155 (HappyAbsSyn4  happy_var_1)
	 =  HappyAbsSyn50
		 (AbsVarg.EInt happy_var_1
	)
happyReduction_155 _  = notHappyAtAll 

happyReduce_156 = happySpecReduce_1  65 happyReduction_156
happyReduction_156 (HappyAbsSyn5  happy_var_1)
	 =  HappyAbsSyn50
		 (AbsVarg.EReal happy_var_1
	)
happyReduction_156 _  = notHappyAtAll 

happyReduce_157 = happySpecReduce_3  65 happyReduction_157
happyReduction_157 _
	(HappyAbsSyn6  happy_var_2)
	_
	 =  HappyAbsSyn50
		 (AbsVarg.EChar happy_var_2
	)
happyReduction_157 _ _ _  = notHappyAtAll 

happyReduce_158 = happySpecReduce_3  65 happyReduction_158
happyReduction_158 _
	(HappyAbsSyn7  happy_var_2)
	_
	 =  HappyAbsSyn50
		 (AbsVarg.EString happy_var_2
	)
happyReduction_158 _ _ _  = notHappyAtAll 

happyReduce_159 = happySpecReduce_1  65 happyReduction_159
happyReduction_159 _
	 =  HappyAbsSyn50
		 (AbsVarg.EWild
	)

happyReduce_160 = happySpecReduce_3  65 happyReduction_160
happyReduction_160 _
	(HappyAbsSyn50  happy_var_2)
	_
	 =  HappyAbsSyn50
		 (happy_var_2
	)
happyReduction_160 _ _ _  = notHappyAtAll 

happyReduce_161 = happySpecReduce_1  66 happyReduction_161
happyReduction_161 _
	 =  HappyAbsSyn66
		 (AbsVarg.ETrue
	)

happyReduce_162 = happySpecReduce_1  66 happyReduction_162
happyReduction_162 _
	 =  HappyAbsSyn66
		 (AbsVarg.EFalse
	)

happyNewToken action sts stk [] =
	action 136 136 notHappyAtAll (HappyState action) sts stk []

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
	PT _ (TS _ 59) -> cont 125;
	PT _ (TS _ 60) -> cont 126;
	PT _ (TS _ 61) -> cont 127;
	PT _ (TS _ 62) -> cont 128;
	PT _ (TI happy_dollar_dollar) -> cont 129;
	PT _ (TD happy_dollar_dollar) -> cont 130;
	PT _ (TC happy_dollar_dollar) -> cont 131;
	PT _ (TL happy_dollar_dollar) -> cont 132;
	PT _ (T_UIdent happy_dollar_dollar) -> cont 133;
	PT _ (T_LIdent happy_dollar_dollar) -> cont 134;
	PT _ (T_MFun happy_dollar_dollar) -> cont 135;
	_ -> happyError' ((tk:tks), [])
	}

happyError_ explist 136 tk tks = happyError' (tks, explist)
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
