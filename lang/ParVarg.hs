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
	| HappyAbsSyn4 (String)
	| HappyAbsSyn5 (Integer)
	| HappyAbsSyn6 (Double)
	| HappyAbsSyn7 (Char)
	| HappyAbsSyn8 (UIdent)
	| HappyAbsSyn9 (LIdent)
	| HappyAbsSyn10 (MFun)
	| HappyAbsSyn11 (Op)
	| HappyAbsSyn12 (ProgramDef)
	| HappyAbsSyn13 ([ClassDef])
	| HappyAbsSyn14 (ImportDef)
	| HappyAbsSyn15 ([ImportDef])
	| HappyAbsSyn16 ([ConstrTypeParam])
	| HappyAbsSyn17 (ConstrTypeParam)
	| HappyAbsSyn18 (TypeDef)
	| HappyAbsSyn20 ([TypeDef])
	| HappyAbsSyn21 (PrimFreeType)
	| HappyAbsSyn22 (FreeTypeDef)
	| HappyAbsSyn24 ([PrimFreeType])
	| HappyAbsSyn25 ([ArgDef])
	| HappyAbsSyn26 (ArgDef)
	| HappyAbsSyn27 (SuperclassType)
	| HappyAbsSyn28 ([SuperclassType])
	| HappyAbsSyn29 (ClassDef)
	| HappyAbsSyn30 (IsImplementing)
	| HappyAbsSyn31 (IsDeriving)
	| HappyAbsSyn32 ([ClassModifier])
	| HappyAbsSyn33 (ClassModifier)
	| HappyAbsSyn34 (ClassContents)
	| HappyAbsSyn35 (MemberDef)
	| HappyAbsSyn36 ([MemberDef])
	| HappyAbsSyn37 (FunDef)
	| HappyAbsSyn38 (RetType)
	| HappyAbsSyn39 (FunctionName)
	| HappyAbsSyn40 (Operator)
	| HappyAbsSyn41 (AbsRetType)
	| HappyAbsSyn42 (FunTemplateParams)
	| HappyAbsSyn43 (TemplateParam)
	| HappyAbsSyn44 ([TemplateParam])
	| HappyAbsSyn45 ([FunDef])
	| HappyAbsSyn46 ([FunctionModifier])
	| HappyAbsSyn47 (FunctionModifier)
	| HappyAbsSyn48 (ClassField)
	| HappyAbsSyn49 ([ClassField])
	| HappyAbsSyn50 (FieldModifier)
	| HappyAbsSyn51 (Expr)
	| HappyAbsSyn52 ([LetDef])
	| HappyAbsSyn53 (LetDef)
	| HappyAbsSyn54 ([MatchClause])
	| HappyAbsSyn55 (MatchClause)
	| HappyAbsSyn57 (ListElem)
	| HappyAbsSyn58 ([ListElem])
	| HappyAbsSyn64 (Boolean)

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
 action_281,
 action_282,
 action_283,
 action_284,
 action_285,
 action_286,
 action_287,
 action_288,
 action_289,
 action_290,
 action_291,
 action_292,
 action_293,
 action_294,
 action_295,
 action_296,
 action_297,
 action_298,
 action_299,
 action_300,
 action_301,
 action_302,
 action_303 :: () => Int -> ({-HappyReduction (Err) = -}
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
 happyReduce_162,
 happyReduce_163,
 happyReduce_164,
 happyReduce_165,
 happyReduce_166,
 happyReduce_167,
 happyReduce_168 :: () => ({-HappyReduction (Err) = -}
	   Int 
	-> (Token)
	-> HappyState (Token) (HappyStk HappyAbsSyn -> [(Token)] -> (Err) HappyAbsSyn)
	-> [HappyState (Token) (HappyStk HappyAbsSyn -> [(Token)] -> (Err) HappyAbsSyn)] 
	-> HappyStk HappyAbsSyn 
	-> [(Token)] -> (Err) HappyAbsSyn)

happyExpList :: Happy_Data_Array.Array Int Int
happyExpList = Happy_Data_Array.listArray (0,1181) ([0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,128,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,32,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,128,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,2048,45184,10,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,8,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,2048,0,0,0,0,0,0,0,0,8,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,2,0,0,0,0,0,4096,0,0,0,0,0,0,0,0,4096,0,0,0,0,0,0,2,0,0,0,24,0,0,0,0,0,0,0,8,0,0,0,0,0,4120,0,0,24,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,16,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,8,0,0,16,0,0,0,0,0,0,0,0,0,0,0,0,0,0,256,256,16,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,2,0,0,0,24,0,0,0,0,0,0,0,2,0,0,0,0,2,0,0,0,24,0,0,0,8192,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,8,0,0,0,0,4,0,0,0,0,0,0,0,512,0,0,0,6144,0,0,0,0,2,0,0,0,24,0,0,0,0,8,0,0,0,0,0,0,0,4096,0,0,0,0,0,0,0,0,0,0,0,32,0,0,0,0,0,0,0,0,16,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,16,1024,0,0,0,0,0,0,4096,0,4,0,0,0,0,0,0,0,0,2,0,0,0,0,0,0,0,2048,0,0,0,0,512,0,0,0,6144,0,0,0,0,2,0,0,0,24,0,0,0,512,0,0,0,6144,0,0,0,0,2,0,0,0,24,0,0,0,0,8,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,4097,0,0,0,0,2,0,0,0,24,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,2,0,0,0,24,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,8,0,0,0,512,0,0,0,6144,0,0,0,0,0,0,0,0,0,0,0,0,0,0,512,0,0,0,0,0,0,0,0,0,8192,0,0,0,0,0,16,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1024,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,2,0,0,0,24,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,8192,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,32768,0,0,0,0,0,0,0,2,0,0,0,24,0,0,0,0,32768,0,0,0,0,0,0,0,0,128,0,0,0,0,0,0,0,32768,0,0,0,0,0,0,0,0,0,0,0,8,0,0,0,0,0,0,0,32,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1024,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,512,0,0,0,6144,0,0,0,0,0,24,0,0,24,0,0,0,0,6144,0,0,6144,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,4096,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,32768,8457,257,0,0,0,0,0,0,0,0,2048,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,8,0,0,0,0,0,0,256,256,16,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,2,0,0,0,16,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,8192,0,0,0,0,0,0,0,22528,1898,1,0,16384,0,0,0,0,0,0,0,8192,0,0,0,0,0,0,0,0,0,0,0,0,0,4,0,0,0,0,0,0,0,1024,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,6144,0,0,6144,0,0,0,0,0,0,0,0,0,0,0,0,8192,0,0,0,0,0,0,0,0,0,2,0,0,0,0,0,0,512,8,0,0,4096,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,32768,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,16,0,0,0,512,0,4,0,6144,0,0,0,0,0,0,0,0,0,0,0,0,0,6144,0,0,6144,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,2,0,0,0,24,0,0,0,0,8,0,0,0,0,0,0,0,66,16944,17924,32996,63,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,2,17200,0,49252,63,0,0,0,0,268,0,0,16384,0,0,0,0,24657,6,2048,4096,0,0,0,0,2048,2,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,27226,17271,17924,32996,63,0,0,0,512,12288,66,25600,16256,0,0,0,0,66,16944,17924,32996,63,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,66,16944,17924,32996,63,0,0,0,0,0,0,0,4104,0,0,0,0,66,16944,17924,32996,63,0,0,0,16896,12288,66,25600,16256,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,16896,12288,1090,58438,16256,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,2,0,0,0,24,0,0,0,0,0,0,0,0,0,0,0,0,4,0,0,0,0,0,0,0,0,0,0,0,4,0,0,0,0,80,0,0,0,0,0,0,0,0,0,0,0,4,0,0,0,0,0,0,0,0,0,0,0,0,0,0,16384,0,0,0,0,0,0,0,0,0,0,16,0,0,0,0,0,0,4096,0,0,0,0,0,256,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,32,0,0,0,0,0,0,0,0,32768,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1024,0,0,0,0,0,0,0,0,4,0,0,0,0,0,0,0,512,12288,66,25600,16256,0,0,0,0,0,0,0,0,0,0,0,0,16896,12288,66,25600,16256,0,0,0,0,66,16944,0,32868,63,0,0,0,16896,12288,66,25600,16256,0,0,0,0,66,16944,0,32868,63,0,0,0,16896,12288,66,25600,16256,0,0,0,0,66,16944,0,32868,63,0,0,0,16896,12288,66,25600,16256,0,0,0,0,66,16944,0,32868,63,0,0,0,16896,12288,66,25600,16256,0,0,0,0,66,16944,0,32868,63,0,0,0,16896,12288,66,25600,16256,0,0,0,0,66,16944,0,32868,63,0,0,0,16896,12288,66,25600,16256,0,0,0,0,66,16944,17924,32996,63,0,0,0,16896,12288,66,25600,16256,0,0,0,0,0,0,0,0,0,0,0,0,16896,12288,66,25600,16256,0,0,0,0,66,16944,0,32868,63,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,20480,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,20480,0,0,0,0,0,0,0,0,80,0,0,0,0,0,0,0,20480,0,0,0,0,0,0,0,0,80,0,0,0,0,0,0,0,20480,0,0,0,0,0,0,0,0,80,0,0,0,0,0,0,0,20480,0,0,0,0,0,0,0,0,80,0,0,0,0,0,0,0,2048,2,0,0,0,0,0,0,0,520,0,0,0,0,0,0,0,20480,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,2178,0,0,0,16,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,66,16944,17924,32996,63,0,0,0,0,0,0,0,256,0,0,0,0,66,16944,17924,32996,63,0,0,0,0,0,0,0,32,0,0,0,0,4096,0,0,0,0,0,0,0,16896,12288,1090,58438,16256,0,0,0,0,34818,0,0,0,16,0,0,0,0,0,0,0,8,0,0,0,0,66,16944,17924,32996,63,0,0,0,0,0,0,0,0,0,0,0,0,0,0,64,0,0,0,0,0,16896,12288,1090,58438,16256,0,0,0,0,2,0,0,0,24,0,0,0,16896,12288,1090,58438,16256,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,4096,0,0,0,0,0,0,64,0,0,0,0,0,0,0,32,0,0,0,0,0,0,0,128,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,66,16944,17924,32996,63,0,0,0,512,0,0,0,6144,0,0,0,0,128,0,0,0,0,0,0,0,1024,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,16896,12288,1090,58438,16256,0,0,0,0,66,16944,17924,32996,63,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,128,0,0,0,0,0,0,0,128,0,0,0,0,0,0,0,0,0,0,0,32,0,0,0,0,4096,0,0,0,0,0,0,0,16896,12288,1090,58438,16256,0,0,0,0,0,0,0,0,0,0,0,0,16896,12288,1090,58438,16256,0,0,0,0,0,0,0,0,0,0,0,0,16896,12288,1090,58438,16256,0,0,0,0,66,16944,17924,32996,63,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,66,16944,17924,32996,63,0,0,0,1024,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	])

{-# NOINLINE happyExpListPerState #-}
happyExpListPerState st =
    token_strs_expected
  where token_strs = ["error","%dummy","%start_pProgramDef","String","Integer","Double","Char","UIdent","LIdent","MFun","Op","ProgramDef","ListClassDef","ImportDef","ListImportDef","ListConstrTypeParam","ConstrTypeParam","TypeDef","TypeDef1","ListTypeDef","PrimFreeType","FreeTypeDef","FreeTypeDef1","ListPrimFreeType","ListArgDef","ArgDef","SuperclassType","ListSuperclassType","ClassDef","IsImplementing","IsDeriving","ListClassModifier","ClassModifier","ClassContents","MemberDef","ListMemberDef","FunDef","RetType","FunctionName","Operator","AbsRetType","FunTemplateParams","TemplateParam","ListTemplateParam","ListFunDef","ListFunctionModifier","FunctionModifier","ClassField","ListClassField","FieldModifier","Expr","ListLetDef","LetDef","ListMatchClause","MatchClause","Expr6","ListElem","ListListElem","Expr5","Expr1","Expr2","Expr3","Expr4","Boolean","'&&'","'('","')'","'*'","'+'","','","'-'","'->'","'..'","'/'","'/='","':'","';'","'<'","'<='","'='","'=='","'>'","'>='","'?'","'['","'[]'","'\\\\'","']'","'^'","'_'","'abstract'","'class'","'deriving'","'else'","'false'","'final'","'function'","'has'","'if'","'implement'","'implementing'","'import'","'in'","'interface'","'internal'","'let'","'match'","'mod'","'module'","'native'","'not'","'sealed'","'static'","'struct'","'super'","'template'","'then'","'this'","'true'","'unify'","'unique'","'where'","'with'","'{'","'||'","'}'","'~'","L_quoted","L_integ","L_doubl","L_charac","L_UIdent","L_LIdent","L_MFun","L_Op","%eof"]
        bit_start = st * 136
        bit_end = (st + 1) * 136
        read_bit = readArrayBit happyExpList
        bits = map read_bit [bit_start..bit_end - 1]
        bits_indexed = zip bits [0..135]
        token_strs_expected = concatMap f bits_indexed
        f (False, _) = []
        f (True, nr) = [token_strs !! nr]

action_0 (12) = happyGoto action_3
action_0 (15) = happyGoto action_4
action_0 _ = happyReduce_13

action_1 (128) = happyShift action_2
action_1 _ = happyFail (happyExpListPerState 1)

action_2 _ = happyReduce_1

action_3 (136) = happyAccept
action_3 _ = happyFail (happyExpListPerState 3)

action_4 (102) = happyShift action_7
action_4 (13) = happyGoto action_5
action_4 (14) = happyGoto action_6
action_4 _ = happyReduce_10

action_5 (136) = happyReduce_9
action_5 (29) = happyGoto action_9
action_5 (32) = happyGoto action_10
action_5 _ = happyReduce_53

action_6 _ = happyReduce_14

action_7 (128) = happyShift action_2
action_7 (4) = happyGoto action_8
action_7 _ = happyFail (happyExpListPerState 7)

action_8 _ = happyReduce_12

action_9 _ = happyReduce_11

action_10 (92) = happyShift action_12
action_10 (104) = happyShift action_13
action_10 (109) = happyShift action_14
action_10 (110) = happyShift action_15
action_10 (112) = happyShift action_16
action_10 (114) = happyShift action_17
action_10 (116) = happyShift action_18
action_10 (33) = happyGoto action_11
action_10 _ = happyFail (happyExpListPerState 10)

action_11 _ = happyReduce_54

action_12 (132) = happyShift action_20
action_12 (8) = happyGoto action_22
action_12 _ = happyFail (happyExpListPerState 12)

action_13 _ = happyReduce_56

action_14 _ = happyReduce_55

action_15 _ = happyReduce_58

action_16 _ = happyReduce_57

action_17 (132) = happyShift action_20
action_17 (8) = happyGoto action_21
action_17 _ = happyFail (happyExpListPerState 17)

action_18 (132) = happyShift action_20
action_18 (8) = happyGoto action_19
action_18 _ = happyFail (happyExpListPerState 18)

action_19 (16) = happyGoto action_26
action_19 _ = happyReduce_15

action_20 _ = happyReduce_5

action_21 (122) = happyShift action_25
action_21 _ = happyFail (happyExpListPerState 21)

action_22 (93) = happyShift action_24
action_22 (31) = happyGoto action_23
action_22 _ = happyReduce_52

action_23 (101) = happyShift action_42
action_23 (30) = happyGoto action_41
action_23 _ = happyReduce_50

action_24 (66) = happyShift action_40
action_24 (132) = happyShift action_20
action_24 (133) = happyShift action_33
action_24 (8) = happyGoto action_35
action_24 (9) = happyGoto action_36
action_24 (22) = happyGoto action_37
action_24 (23) = happyGoto action_38
action_24 (27) = happyGoto action_39
action_24 _ = happyFail (happyExpListPerState 24)

action_25 (124) = happyShift action_34
action_25 _ = happyFail (happyExpListPerState 25)

action_26 (84) = happyShift action_31
action_26 (85) = happyShift action_32
action_26 (93) = happyShift action_24
action_26 (132) = happyShift action_20
action_26 (133) = happyShift action_33
action_26 (8) = happyGoto action_27
action_26 (9) = happyGoto action_28
action_26 (17) = happyGoto action_29
action_26 (31) = happyGoto action_30
action_26 _ = happyReduce_52

action_27 _ = happyReduce_18

action_28 _ = happyReduce_17

action_29 _ = happyReduce_16

action_30 (101) = happyShift action_42
action_30 (30) = happyGoto action_57
action_30 _ = happyReduce_50

action_31 _ = happyReduce_19

action_32 (84) = happyShift action_56
action_32 (133) = happyShift action_33
action_32 (9) = happyGoto action_55
action_32 _ = happyFail (happyExpListPerState 32)

action_33 _ = happyReduce_6

action_34 (105) = happyShift action_53
action_34 (121) = happyShift action_54
action_34 (133) = happyShift action_33
action_34 (9) = happyGoto action_49
action_34 (48) = happyGoto action_50
action_34 (49) = happyGoto action_51
action_34 (50) = happyGoto action_52
action_34 _ = happyReduce_103

action_35 (24) = happyGoto action_48
action_35 _ = happyReduce_37

action_36 (24) = happyGoto action_47
action_36 _ = happyReduce_37

action_37 _ = happyReduce_43

action_38 _ = happyReduce_35

action_39 _ = happyReduce_51

action_40 (66) = happyShift action_40
action_40 (132) = happyShift action_20
action_40 (133) = happyShift action_33
action_40 (8) = happyGoto action_35
action_40 (9) = happyGoto action_36
action_40 (22) = happyGoto action_46
action_40 (23) = happyGoto action_38
action_40 _ = happyFail (happyExpListPerState 40)

action_41 (122) = happyShift action_45
action_41 _ = happyFail (happyExpListPerState 41)

action_42 (66) = happyShift action_40
action_42 (132) = happyShift action_20
action_42 (133) = happyShift action_33
action_42 (8) = happyGoto action_35
action_42 (9) = happyGoto action_36
action_42 (22) = happyGoto action_37
action_42 (23) = happyGoto action_38
action_42 (27) = happyGoto action_43
action_42 (28) = happyGoto action_44
action_42 _ = happyFail (happyExpListPerState 42)

action_43 (70) = happyShift action_73
action_43 _ = happyReduce_44

action_44 _ = happyReduce_49

action_45 (124) = happyShift action_72
action_45 _ = happyFail (happyExpListPerState 45)

action_46 (67) = happyShift action_71
action_46 _ = happyFail (happyExpListPerState 46)

action_47 (66) = happyShift action_70
action_47 (132) = happyShift action_20
action_47 (133) = happyShift action_33
action_47 (8) = happyGoto action_67
action_47 (9) = happyGoto action_68
action_47 (21) = happyGoto action_69
action_47 _ = happyReduce_34

action_48 (66) = happyShift action_70
action_48 (132) = happyShift action_20
action_48 (133) = happyShift action_33
action_48 (8) = happyGoto action_67
action_48 (9) = happyGoto action_68
action_48 (21) = happyGoto action_69
action_48 _ = happyReduce_33

action_49 (76) = happyShift action_66
action_49 _ = happyFail (happyExpListPerState 49)

action_50 (77) = happyShift action_65
action_50 _ = happyReduce_104

action_51 (126) = happyShift action_64
action_51 _ = happyFail (happyExpListPerState 51)

action_52 (133) = happyShift action_33
action_52 (9) = happyGoto action_63
action_52 _ = happyFail (happyExpListPerState 52)

action_53 _ = happyReduce_106

action_54 _ = happyReduce_107

action_55 (93) = happyShift action_61
action_55 (115) = happyShift action_62
action_55 _ = happyFail (happyExpListPerState 55)

action_56 (93) = happyShift action_59
action_56 (115) = happyShift action_60
action_56 _ = happyFail (happyExpListPerState 56)

action_57 (122) = happyShift action_58
action_57 _ = happyFail (happyExpListPerState 57)

action_58 (124) = happyShift action_92
action_58 _ = happyFail (happyExpListPerState 58)

action_59 (66) = happyShift action_88
action_59 (132) = happyShift action_20
action_59 (133) = happyShift action_33
action_59 (8) = happyGoto action_83
action_59 (9) = happyGoto action_84
action_59 (18) = happyGoto action_85
action_59 (19) = happyGoto action_86
action_59 (20) = happyGoto action_91
action_59 _ = happyFail (happyExpListPerState 59)

action_60 (66) = happyShift action_88
action_60 (132) = happyShift action_20
action_60 (133) = happyShift action_33
action_60 (8) = happyGoto action_83
action_60 (9) = happyGoto action_84
action_60 (18) = happyGoto action_85
action_60 (19) = happyGoto action_86
action_60 (20) = happyGoto action_90
action_60 _ = happyFail (happyExpListPerState 60)

action_61 (66) = happyShift action_88
action_61 (132) = happyShift action_20
action_61 (133) = happyShift action_33
action_61 (8) = happyGoto action_83
action_61 (9) = happyGoto action_84
action_61 (18) = happyGoto action_85
action_61 (19) = happyGoto action_86
action_61 (20) = happyGoto action_89
action_61 _ = happyFail (happyExpListPerState 61)

action_62 (66) = happyShift action_88
action_62 (132) = happyShift action_20
action_62 (133) = happyShift action_33
action_62 (8) = happyGoto action_83
action_62 (9) = happyGoto action_84
action_62 (18) = happyGoto action_85
action_62 (19) = happyGoto action_86
action_62 (20) = happyGoto action_87
action_62 _ = happyFail (happyExpListPerState 62)

action_63 (76) = happyShift action_82
action_63 _ = happyFail (happyExpListPerState 63)

action_64 _ = happyReduce_46

action_65 (105) = happyShift action_53
action_65 (121) = happyShift action_54
action_65 (133) = happyShift action_33
action_65 (9) = happyGoto action_49
action_65 (48) = happyGoto action_50
action_65 (49) = happyGoto action_81
action_65 (50) = happyGoto action_52
action_65 _ = happyReduce_103

action_66 (66) = happyShift action_40
action_66 (132) = happyShift action_20
action_66 (133) = happyShift action_33
action_66 (8) = happyGoto action_35
action_66 (9) = happyGoto action_36
action_66 (22) = happyGoto action_80
action_66 (23) = happyGoto action_38
action_66 _ = happyFail (happyExpListPerState 66)

action_67 _ = happyReduce_32

action_68 _ = happyReduce_31

action_69 _ = happyReduce_38

action_70 (66) = happyShift action_40
action_70 (132) = happyShift action_20
action_70 (133) = happyShift action_33
action_70 (8) = happyGoto action_35
action_70 (9) = happyGoto action_36
action_70 (22) = happyGoto action_79
action_70 (23) = happyGoto action_38
action_70 _ = happyFail (happyExpListPerState 70)

action_71 _ = happyReduce_36

action_72 (132) = happyShift action_20
action_72 (8) = happyGoto action_75
action_72 (34) = happyGoto action_76
action_72 (35) = happyGoto action_77
action_72 (36) = happyGoto action_78
action_72 _ = happyReduce_62

action_73 (66) = happyShift action_40
action_73 (132) = happyShift action_20
action_73 (133) = happyShift action_33
action_73 (8) = happyGoto action_35
action_73 (9) = happyGoto action_36
action_73 (22) = happyGoto action_37
action_73 (23) = happyGoto action_38
action_73 (27) = happyGoto action_43
action_73 (28) = happyGoto action_74
action_73 _ = happyFail (happyExpListPerState 73)

action_74 _ = happyReduce_45

action_75 (98) = happyShift action_109
action_75 _ = happyReduce_60

action_76 (126) = happyShift action_108
action_76 _ = happyFail (happyExpListPerState 76)

action_77 (77) = happyShift action_107
action_77 _ = happyReduce_63

action_78 (126) = happyReduce_90
action_78 (37) = happyGoto action_104
action_78 (45) = happyGoto action_105
action_78 (46) = happyGoto action_106
action_78 _ = happyReduce_93

action_79 (67) = happyShift action_103
action_79 _ = happyFail (happyExpListPerState 79)

action_80 _ = happyReduce_102

action_81 _ = happyReduce_105

action_82 (66) = happyShift action_40
action_82 (132) = happyShift action_20
action_82 (133) = happyShift action_33
action_82 (8) = happyGoto action_35
action_82 (9) = happyGoto action_36
action_82 (22) = happyGoto action_102
action_82 (23) = happyGoto action_38
action_82 _ = happyFail (happyExpListPerState 82)

action_83 (16) = happyGoto action_101
action_83 _ = happyReduce_15

action_84 (16) = happyGoto action_100
action_84 _ = happyReduce_15

action_85 (70) = happyShift action_99
action_85 _ = happyReduce_28

action_86 _ = happyReduce_26

action_87 (88) = happyShift action_98
action_87 _ = happyFail (happyExpListPerState 87)

action_88 (66) = happyShift action_88
action_88 (132) = happyShift action_20
action_88 (133) = happyShift action_33
action_88 (8) = happyGoto action_83
action_88 (9) = happyGoto action_84
action_88 (18) = happyGoto action_97
action_88 (19) = happyGoto action_86
action_88 _ = happyFail (happyExpListPerState 88)

action_89 (88) = happyShift action_96
action_89 _ = happyFail (happyExpListPerState 89)

action_90 (88) = happyShift action_95
action_90 _ = happyFail (happyExpListPerState 90)

action_91 (88) = happyShift action_94
action_91 _ = happyFail (happyExpListPerState 91)

action_92 (132) = happyShift action_20
action_92 (8) = happyGoto action_75
action_92 (34) = happyGoto action_93
action_92 (35) = happyGoto action_77
action_92 (36) = happyGoto action_78
action_92 _ = happyReduce_62

action_93 (126) = happyShift action_123
action_93 _ = happyFail (happyExpListPerState 93)

action_94 _ = happyReduce_23

action_95 _ = happyReduce_21

action_96 _ = happyReduce_22

action_97 (67) = happyShift action_122
action_97 _ = happyFail (happyExpListPerState 97)

action_98 _ = happyReduce_20

action_99 (66) = happyShift action_88
action_99 (132) = happyShift action_20
action_99 (133) = happyShift action_33
action_99 (8) = happyGoto action_83
action_99 (9) = happyGoto action_84
action_99 (18) = happyGoto action_85
action_99 (19) = happyGoto action_86
action_99 (20) = happyGoto action_121
action_99 _ = happyFail (happyExpListPerState 99)

action_100 (84) = happyShift action_31
action_100 (85) = happyShift action_32
action_100 (132) = happyShift action_20
action_100 (133) = happyShift action_33
action_100 (8) = happyGoto action_27
action_100 (9) = happyGoto action_28
action_100 (17) = happyGoto action_29
action_100 _ = happyReduce_25

action_101 (84) = happyShift action_31
action_101 (85) = happyShift action_32
action_101 (132) = happyShift action_20
action_101 (133) = happyShift action_33
action_101 (8) = happyGoto action_27
action_101 (9) = happyGoto action_28
action_101 (17) = happyGoto action_29
action_101 _ = happyReduce_24

action_102 _ = happyReduce_101

action_103 _ = happyReduce_30

action_104 (77) = happyShift action_120
action_104 _ = happyReduce_91

action_105 _ = happyReduce_59

action_106 (96) = happyShift action_113
action_106 (97) = happyShift action_114
action_106 (100) = happyShift action_115
action_106 (105) = happyShift action_116
action_106 (110) = happyShift action_117
action_106 (113) = happyShift action_118
action_106 (121) = happyShift action_119
action_106 (47) = happyGoto action_112
action_106 _ = happyFail (happyExpListPerState 106)

action_107 (132) = happyShift action_20
action_107 (8) = happyGoto action_75
action_107 (35) = happyGoto action_77
action_107 (36) = happyGoto action_111
action_107 _ = happyReduce_62

action_108 _ = happyReduce_47

action_109 (124) = happyShift action_110
action_109 _ = happyFail (happyExpListPerState 109)

action_110 (105) = happyShift action_53
action_110 (121) = happyShift action_54
action_110 (133) = happyShift action_33
action_110 (9) = happyGoto action_49
action_110 (48) = happyGoto action_50
action_110 (49) = happyGoto action_128
action_110 (50) = happyGoto action_52
action_110 _ = happyReduce_103

action_111 _ = happyReduce_64

action_112 _ = happyReduce_94

action_113 _ = happyReduce_98

action_114 (66) = happyShift action_127
action_114 (133) = happyShift action_33
action_114 (9) = happyGoto action_125
action_114 (39) = happyGoto action_126
action_114 _ = happyFail (happyExpListPerState 114)

action_115 _ = happyReduce_97

action_116 _ = happyReduce_96

action_117 _ = happyReduce_100

action_118 _ = happyReduce_95

action_119 _ = happyReduce_99

action_120 (126) = happyReduce_90
action_120 (37) = happyGoto action_104
action_120 (45) = happyGoto action_124
action_120 (46) = happyGoto action_106
action_120 _ = happyReduce_93

action_121 _ = happyReduce_29

action_122 _ = happyReduce_27

action_123 _ = happyReduce_48

action_124 _ = happyReduce_92

action_125 _ = happyReduce_69

action_126 (78) = happyShift action_145
action_126 (42) = happyGoto action_144
action_126 _ = happyReduce_85

action_127 (68) = happyShift action_132
action_127 (69) = happyShift action_133
action_127 (71) = happyShift action_134
action_127 (74) = happyShift action_135
action_127 (76) = happyShift action_136
action_127 (78) = happyShift action_137
action_127 (79) = happyShift action_138
action_127 (81) = happyShift action_139
action_127 (82) = happyShift action_140
action_127 (83) = happyShift action_141
action_127 (89) = happyShift action_142
action_127 (135) = happyShift action_143
action_127 (11) = happyGoto action_130
action_127 (40) = happyGoto action_131
action_127 _ = happyFail (happyExpListPerState 127)

action_128 (126) = happyShift action_129
action_128 _ = happyFail (happyExpListPerState 128)

action_129 _ = happyReduce_61

action_130 (67) = happyShift action_151
action_130 _ = happyFail (happyExpListPerState 130)

action_131 (67) = happyShift action_150
action_131 _ = happyFail (happyExpListPerState 131)

action_132 _ = happyReduce_74

action_133 _ = happyReduce_72

action_134 _ = happyReduce_73

action_135 _ = happyReduce_75

action_136 _ = happyReduce_82

action_137 _ = happyReduce_77

action_138 _ = happyReduce_79

action_139 _ = happyReduce_81

action_140 _ = happyReduce_78

action_141 _ = happyReduce_80

action_142 _ = happyReduce_76

action_143 _ = happyReduce_8

action_144 (25) = happyGoto action_149
action_144 _ = happyReduce_39

action_145 (84) = happyShift action_31
action_145 (85) = happyShift action_32
action_145 (132) = happyShift action_20
action_145 (133) = happyShift action_33
action_145 (8) = happyGoto action_27
action_145 (9) = happyGoto action_28
action_145 (17) = happyGoto action_146
action_145 (43) = happyGoto action_147
action_145 (44) = happyGoto action_148
action_145 _ = happyFail (happyExpListPerState 145)

action_146 _ = happyReduce_87

action_147 (70) = happyShift action_159
action_147 _ = happyReduce_88

action_148 (82) = happyShift action_158
action_148 _ = happyFail (happyExpListPerState 148)

action_149 (66) = happyShift action_156
action_149 (76) = happyShift action_157
action_149 (80) = happyReduce_68
action_149 (133) = happyShift action_33
action_149 (9) = happyGoto action_152
action_149 (26) = happyGoto action_153
action_149 (38) = happyGoto action_154
action_149 (41) = happyGoto action_155
action_149 _ = happyReduce_84

action_150 _ = happyReduce_70

action_151 _ = happyReduce_71

action_152 _ = happyReduce_42

action_153 _ = happyReduce_40

action_154 (80) = happyShift action_164
action_154 _ = happyFail (happyExpListPerState 154)

action_155 _ = happyReduce_66

action_156 (133) = happyShift action_33
action_156 (9) = happyGoto action_163
action_156 _ = happyFail (happyExpListPerState 156)

action_157 (66) = happyShift action_40
action_157 (91) = happyShift action_162
action_157 (132) = happyShift action_20
action_157 (133) = happyShift action_33
action_157 (8) = happyGoto action_35
action_157 (9) = happyGoto action_36
action_157 (22) = happyGoto action_161
action_157 (23) = happyGoto action_38
action_157 _ = happyFail (happyExpListPerState 157)

action_158 _ = happyReduce_86

action_159 (84) = happyShift action_31
action_159 (85) = happyShift action_32
action_159 (132) = happyShift action_20
action_159 (133) = happyShift action_33
action_159 (8) = happyGoto action_27
action_159 (9) = happyGoto action_28
action_159 (17) = happyGoto action_146
action_159 (43) = happyGoto action_147
action_159 (44) = happyGoto action_160
action_159 _ = happyFail (happyExpListPerState 159)

action_160 _ = happyReduce_89

action_161 _ = happyReduce_67

action_162 (66) = happyShift action_40
action_162 (132) = happyShift action_20
action_162 (133) = happyShift action_33
action_162 (8) = happyGoto action_35
action_162 (9) = happyGoto action_36
action_162 (22) = happyGoto action_199
action_162 (23) = happyGoto action_38
action_162 _ = happyFail (happyExpListPerState 162)

action_163 (76) = happyShift action_198
action_163 _ = happyFail (happyExpListPerState 163)

action_164 (66) = happyShift action_180
action_164 (71) = happyShift action_181
action_164 (85) = happyShift action_182
action_164 (86) = happyShift action_183
action_164 (90) = happyShift action_184
action_164 (95) = happyShift action_185
action_164 (99) = happyShift action_186
action_164 (106) = happyShift action_187
action_164 (107) = happyShift action_188
action_164 (111) = happyShift action_189
action_164 (115) = happyShift action_190
action_164 (118) = happyShift action_191
action_164 (119) = happyShift action_192
action_164 (120) = happyShift action_193
action_164 (128) = happyShift action_2
action_164 (129) = happyShift action_194
action_164 (130) = happyShift action_195
action_164 (131) = happyShift action_196
action_164 (132) = happyShift action_20
action_164 (133) = happyShift action_33
action_164 (134) = happyShift action_197
action_164 (4) = happyGoto action_165
action_164 (5) = happyGoto action_166
action_164 (6) = happyGoto action_167
action_164 (7) = happyGoto action_168
action_164 (8) = happyGoto action_169
action_164 (9) = happyGoto action_170
action_164 (10) = happyGoto action_171
action_164 (51) = happyGoto action_172
action_164 (56) = happyGoto action_173
action_164 (59) = happyGoto action_174
action_164 (60) = happyGoto action_175
action_164 (61) = happyGoto action_176
action_164 (62) = happyGoto action_177
action_164 (63) = happyGoto action_178
action_164 (64) = happyGoto action_179
action_164 _ = happyFail (happyExpListPerState 164)

action_165 _ = happyReduce_137

action_166 _ = happyReduce_134

action_167 _ = happyReduce_135

action_168 _ = happyReduce_136

action_169 _ = happyReduce_131

action_170 _ = happyReduce_130

action_171 _ = happyReduce_132

action_172 _ = happyReduce_65

action_173 _ = happyReduce_145

action_174 (66) = happyShift action_180
action_174 (85) = happyShift action_182
action_174 (86) = happyShift action_183
action_174 (89) = happyShift action_233
action_174 (90) = happyShift action_184
action_174 (95) = happyShift action_185
action_174 (115) = happyShift action_190
action_174 (118) = happyShift action_191
action_174 (119) = happyShift action_192
action_174 (127) = happyShift action_234
action_174 (128) = happyShift action_2
action_174 (129) = happyShift action_194
action_174 (130) = happyShift action_195
action_174 (131) = happyShift action_196
action_174 (132) = happyShift action_20
action_174 (133) = happyShift action_33
action_174 (134) = happyShift action_197
action_174 (4) = happyGoto action_165
action_174 (5) = happyGoto action_166
action_174 (6) = happyGoto action_167
action_174 (7) = happyGoto action_168
action_174 (8) = happyGoto action_169
action_174 (9) = happyGoto action_170
action_174 (10) = happyGoto action_171
action_174 (56) = happyGoto action_232
action_174 (64) = happyGoto action_179
action_174 _ = happyReduce_166

action_175 (75) = happyShift action_229
action_175 (76) = happyShift action_230
action_175 (81) = happyShift action_231
action_175 (135) = happyShift action_143
action_175 (11) = happyGoto action_228
action_175 _ = happyReduce_114

action_176 (65) = happyShift action_219
action_176 (69) = happyShift action_220
action_176 (71) = happyShift action_221
action_176 (78) = happyShift action_222
action_176 (79) = happyShift action_223
action_176 (82) = happyShift action_224
action_176 (83) = happyShift action_225
action_176 (108) = happyShift action_226
action_176 (125) = happyShift action_227
action_176 _ = happyReduce_157

action_177 (68) = happyShift action_217
action_177 (74) = happyShift action_218
action_177 _ = happyReduce_160

action_178 _ = happyReduce_163

action_179 _ = happyReduce_127

action_180 (66) = happyShift action_180
action_180 (68) = happyShift action_132
action_180 (69) = happyShift action_133
action_180 (71) = happyShift action_215
action_180 (74) = happyShift action_135
action_180 (76) = happyShift action_136
action_180 (78) = happyShift action_137
action_180 (79) = happyShift action_138
action_180 (81) = happyShift action_139
action_180 (82) = happyShift action_140
action_180 (83) = happyShift action_141
action_180 (85) = happyShift action_182
action_180 (86) = happyShift action_183
action_180 (87) = happyShift action_216
action_180 (89) = happyShift action_142
action_180 (90) = happyShift action_184
action_180 (95) = happyShift action_185
action_180 (99) = happyShift action_186
action_180 (106) = happyShift action_187
action_180 (107) = happyShift action_188
action_180 (111) = happyShift action_189
action_180 (115) = happyShift action_190
action_180 (118) = happyShift action_191
action_180 (119) = happyShift action_192
action_180 (120) = happyShift action_193
action_180 (128) = happyShift action_2
action_180 (129) = happyShift action_194
action_180 (130) = happyShift action_195
action_180 (131) = happyShift action_196
action_180 (132) = happyShift action_20
action_180 (133) = happyShift action_33
action_180 (134) = happyShift action_197
action_180 (4) = happyGoto action_165
action_180 (5) = happyGoto action_166
action_180 (6) = happyGoto action_167
action_180 (7) = happyGoto action_168
action_180 (8) = happyGoto action_169
action_180 (9) = happyGoto action_170
action_180 (10) = happyGoto action_171
action_180 (40) = happyGoto action_213
action_180 (51) = happyGoto action_214
action_180 (56) = happyGoto action_173
action_180 (59) = happyGoto action_174
action_180 (60) = happyGoto action_175
action_180 (61) = happyGoto action_176
action_180 (62) = happyGoto action_177
action_180 (63) = happyGoto action_178
action_180 (64) = happyGoto action_179
action_180 _ = happyFail (happyExpListPerState 180)

action_181 (66) = happyShift action_180
action_181 (85) = happyShift action_182
action_181 (86) = happyShift action_183
action_181 (90) = happyShift action_184
action_181 (95) = happyShift action_185
action_181 (115) = happyShift action_190
action_181 (118) = happyShift action_191
action_181 (119) = happyShift action_192
action_181 (128) = happyShift action_2
action_181 (129) = happyShift action_194
action_181 (130) = happyShift action_195
action_181 (131) = happyShift action_196
action_181 (132) = happyShift action_20
action_181 (133) = happyShift action_33
action_181 (134) = happyShift action_197
action_181 (4) = happyGoto action_165
action_181 (5) = happyGoto action_166
action_181 (6) = happyGoto action_167
action_181 (7) = happyGoto action_168
action_181 (8) = happyGoto action_169
action_181 (9) = happyGoto action_170
action_181 (10) = happyGoto action_171
action_181 (56) = happyGoto action_212
action_181 (64) = happyGoto action_179
action_181 _ = happyFail (happyExpListPerState 181)

action_182 (66) = happyShift action_180
action_182 (71) = happyShift action_181
action_182 (85) = happyShift action_182
action_182 (86) = happyShift action_183
action_182 (90) = happyShift action_184
action_182 (95) = happyShift action_185
action_182 (99) = happyShift action_186
action_182 (106) = happyShift action_187
action_182 (107) = happyShift action_188
action_182 (111) = happyShift action_189
action_182 (115) = happyShift action_190
action_182 (118) = happyShift action_191
action_182 (119) = happyShift action_192
action_182 (120) = happyShift action_193
action_182 (128) = happyShift action_2
action_182 (129) = happyShift action_194
action_182 (130) = happyShift action_195
action_182 (131) = happyShift action_196
action_182 (132) = happyShift action_20
action_182 (133) = happyShift action_33
action_182 (134) = happyShift action_197
action_182 (4) = happyGoto action_165
action_182 (5) = happyGoto action_208
action_182 (6) = happyGoto action_167
action_182 (7) = happyGoto action_168
action_182 (8) = happyGoto action_169
action_182 (9) = happyGoto action_170
action_182 (10) = happyGoto action_171
action_182 (51) = happyGoto action_209
action_182 (56) = happyGoto action_173
action_182 (57) = happyGoto action_210
action_182 (58) = happyGoto action_211
action_182 (59) = happyGoto action_174
action_182 (60) = happyGoto action_175
action_182 (61) = happyGoto action_176
action_182 (62) = happyGoto action_177
action_182 (63) = happyGoto action_178
action_182 (64) = happyGoto action_179
action_182 _ = happyFail (happyExpListPerState 182)

action_183 _ = happyReduce_125

action_184 _ = happyReduce_138

action_185 _ = happyReduce_168

action_186 (66) = happyShift action_180
action_186 (71) = happyShift action_181
action_186 (85) = happyShift action_182
action_186 (86) = happyShift action_183
action_186 (90) = happyShift action_184
action_186 (95) = happyShift action_185
action_186 (99) = happyShift action_186
action_186 (106) = happyShift action_187
action_186 (107) = happyShift action_188
action_186 (111) = happyShift action_189
action_186 (115) = happyShift action_190
action_186 (118) = happyShift action_191
action_186 (119) = happyShift action_192
action_186 (120) = happyShift action_193
action_186 (128) = happyShift action_2
action_186 (129) = happyShift action_194
action_186 (130) = happyShift action_195
action_186 (131) = happyShift action_196
action_186 (132) = happyShift action_20
action_186 (133) = happyShift action_33
action_186 (134) = happyShift action_197
action_186 (4) = happyGoto action_165
action_186 (5) = happyGoto action_166
action_186 (6) = happyGoto action_167
action_186 (7) = happyGoto action_168
action_186 (8) = happyGoto action_169
action_186 (9) = happyGoto action_170
action_186 (10) = happyGoto action_171
action_186 (51) = happyGoto action_207
action_186 (56) = happyGoto action_173
action_186 (59) = happyGoto action_174
action_186 (60) = happyGoto action_175
action_186 (61) = happyGoto action_176
action_186 (62) = happyGoto action_177
action_186 (63) = happyGoto action_178
action_186 (64) = happyGoto action_179
action_186 _ = happyFail (happyExpListPerState 186)

action_187 (124) = happyShift action_206
action_187 (133) = happyShift action_33
action_187 (9) = happyGoto action_204
action_187 (53) = happyGoto action_205
action_187 _ = happyFail (happyExpListPerState 187)

action_188 (66) = happyShift action_180
action_188 (71) = happyShift action_181
action_188 (85) = happyShift action_182
action_188 (86) = happyShift action_183
action_188 (90) = happyShift action_184
action_188 (95) = happyShift action_185
action_188 (99) = happyShift action_186
action_188 (106) = happyShift action_187
action_188 (107) = happyShift action_188
action_188 (111) = happyShift action_189
action_188 (115) = happyShift action_190
action_188 (118) = happyShift action_191
action_188 (119) = happyShift action_192
action_188 (120) = happyShift action_193
action_188 (128) = happyShift action_2
action_188 (129) = happyShift action_194
action_188 (130) = happyShift action_195
action_188 (131) = happyShift action_196
action_188 (132) = happyShift action_20
action_188 (133) = happyShift action_33
action_188 (134) = happyShift action_197
action_188 (4) = happyGoto action_165
action_188 (5) = happyGoto action_166
action_188 (6) = happyGoto action_167
action_188 (7) = happyGoto action_168
action_188 (8) = happyGoto action_169
action_188 (9) = happyGoto action_170
action_188 (10) = happyGoto action_171
action_188 (51) = happyGoto action_203
action_188 (56) = happyGoto action_173
action_188 (59) = happyGoto action_174
action_188 (60) = happyGoto action_175
action_188 (61) = happyGoto action_176
action_188 (62) = happyGoto action_177
action_188 (63) = happyGoto action_178
action_188 (64) = happyGoto action_179
action_188 _ = happyFail (happyExpListPerState 188)

action_189 (66) = happyShift action_180
action_189 (71) = happyShift action_181
action_189 (85) = happyShift action_182
action_189 (86) = happyShift action_183
action_189 (90) = happyShift action_184
action_189 (95) = happyShift action_185
action_189 (115) = happyShift action_190
action_189 (118) = happyShift action_191
action_189 (119) = happyShift action_192
action_189 (128) = happyShift action_2
action_189 (129) = happyShift action_194
action_189 (130) = happyShift action_195
action_189 (131) = happyShift action_196
action_189 (132) = happyShift action_20
action_189 (133) = happyShift action_33
action_189 (134) = happyShift action_197
action_189 (4) = happyGoto action_165
action_189 (5) = happyGoto action_166
action_189 (6) = happyGoto action_167
action_189 (7) = happyGoto action_168
action_189 (8) = happyGoto action_169
action_189 (9) = happyGoto action_170
action_189 (10) = happyGoto action_171
action_189 (56) = happyGoto action_173
action_189 (59) = happyGoto action_174
action_189 (61) = happyGoto action_202
action_189 (62) = happyGoto action_177
action_189 (63) = happyGoto action_178
action_189 (64) = happyGoto action_179
action_189 _ = happyFail (happyExpListPerState 189)

action_190 _ = happyReduce_129

action_191 _ = happyReduce_128

action_192 _ = happyReduce_167

action_193 (66) = happyShift action_180
action_193 (71) = happyShift action_181
action_193 (85) = happyShift action_182
action_193 (86) = happyShift action_183
action_193 (90) = happyShift action_184
action_193 (95) = happyShift action_185
action_193 (99) = happyShift action_186
action_193 (106) = happyShift action_187
action_193 (107) = happyShift action_188
action_193 (111) = happyShift action_189
action_193 (115) = happyShift action_190
action_193 (118) = happyShift action_191
action_193 (119) = happyShift action_192
action_193 (120) = happyShift action_193
action_193 (128) = happyShift action_2
action_193 (129) = happyShift action_194
action_193 (130) = happyShift action_195
action_193 (131) = happyShift action_196
action_193 (132) = happyShift action_20
action_193 (133) = happyShift action_33
action_193 (134) = happyShift action_197
action_193 (4) = happyGoto action_165
action_193 (5) = happyGoto action_166
action_193 (6) = happyGoto action_167
action_193 (7) = happyGoto action_168
action_193 (8) = happyGoto action_169
action_193 (9) = happyGoto action_170
action_193 (10) = happyGoto action_171
action_193 (51) = happyGoto action_201
action_193 (56) = happyGoto action_173
action_193 (59) = happyGoto action_174
action_193 (60) = happyGoto action_175
action_193 (61) = happyGoto action_176
action_193 (62) = happyGoto action_177
action_193 (63) = happyGoto action_178
action_193 (64) = happyGoto action_179
action_193 _ = happyFail (happyExpListPerState 193)

action_194 _ = happyReduce_2

action_195 _ = happyReduce_3

action_196 _ = happyReduce_4

action_197 _ = happyReduce_7

action_198 (66) = happyShift action_40
action_198 (132) = happyShift action_20
action_198 (133) = happyShift action_33
action_198 (8) = happyGoto action_35
action_198 (9) = happyGoto action_36
action_198 (22) = happyGoto action_200
action_198 (23) = happyGoto action_38
action_198 _ = happyFail (happyExpListPerState 198)

action_199 _ = happyReduce_83

action_200 (67) = happyShift action_265
action_200 _ = happyFail (happyExpListPerState 200)

action_201 (123) = happyShift action_264
action_201 _ = happyFail (happyExpListPerState 201)

action_202 (69) = happyShift action_220
action_202 (71) = happyShift action_221
action_202 _ = happyReduce_150

action_203 (123) = happyShift action_263
action_203 _ = happyFail (happyExpListPerState 203)

action_204 (25) = happyGoto action_262
action_204 _ = happyReduce_39

action_205 (103) = happyShift action_261
action_205 _ = happyFail (happyExpListPerState 205)

action_206 (133) = happyShift action_33
action_206 (9) = happyGoto action_204
action_206 (52) = happyGoto action_259
action_206 (53) = happyGoto action_260
action_206 _ = happyFail (happyExpListPerState 206)

action_207 (117) = happyShift action_258
action_207 _ = happyFail (happyExpListPerState 207)

action_208 (73) = happyShift action_257
action_208 _ = happyReduce_134

action_209 _ = happyReduce_140

action_210 (70) = happyShift action_256
action_210 _ = happyReduce_141

action_211 (88) = happyShift action_255
action_211 _ = happyFail (happyExpListPerState 211)

action_212 _ = happyReduce_143

action_213 (67) = happyShift action_254
action_213 _ = happyFail (happyExpListPerState 213)

action_214 (67) = happyShift action_253
action_214 _ = happyFail (happyExpListPerState 214)

action_215 (66) = happyShift action_180
action_215 (85) = happyShift action_182
action_215 (86) = happyShift action_183
action_215 (90) = happyShift action_184
action_215 (95) = happyShift action_185
action_215 (115) = happyShift action_190
action_215 (118) = happyShift action_191
action_215 (119) = happyShift action_192
action_215 (128) = happyShift action_2
action_215 (129) = happyShift action_194
action_215 (130) = happyShift action_195
action_215 (131) = happyShift action_196
action_215 (132) = happyShift action_20
action_215 (133) = happyShift action_33
action_215 (134) = happyShift action_197
action_215 (4) = happyGoto action_165
action_215 (5) = happyGoto action_166
action_215 (6) = happyGoto action_167
action_215 (7) = happyGoto action_168
action_215 (8) = happyGoto action_169
action_215 (9) = happyGoto action_170
action_215 (10) = happyGoto action_171
action_215 (56) = happyGoto action_212
action_215 (64) = happyGoto action_179
action_215 _ = happyReduce_73

action_216 (25) = happyGoto action_252
action_216 _ = happyReduce_39

action_217 (66) = happyShift action_180
action_217 (71) = happyShift action_181
action_217 (85) = happyShift action_182
action_217 (86) = happyShift action_183
action_217 (90) = happyShift action_184
action_217 (95) = happyShift action_185
action_217 (115) = happyShift action_190
action_217 (118) = happyShift action_191
action_217 (119) = happyShift action_192
action_217 (128) = happyShift action_2
action_217 (129) = happyShift action_194
action_217 (130) = happyShift action_195
action_217 (131) = happyShift action_196
action_217 (132) = happyShift action_20
action_217 (133) = happyShift action_33
action_217 (134) = happyShift action_197
action_217 (4) = happyGoto action_165
action_217 (5) = happyGoto action_166
action_217 (6) = happyGoto action_167
action_217 (7) = happyGoto action_168
action_217 (8) = happyGoto action_169
action_217 (9) = happyGoto action_170
action_217 (10) = happyGoto action_171
action_217 (56) = happyGoto action_173
action_217 (59) = happyGoto action_174
action_217 (63) = happyGoto action_251
action_217 (64) = happyGoto action_179
action_217 _ = happyFail (happyExpListPerState 217)

action_218 (66) = happyShift action_180
action_218 (71) = happyShift action_181
action_218 (85) = happyShift action_182
action_218 (86) = happyShift action_183
action_218 (90) = happyShift action_184
action_218 (95) = happyShift action_185
action_218 (115) = happyShift action_190
action_218 (118) = happyShift action_191
action_218 (119) = happyShift action_192
action_218 (128) = happyShift action_2
action_218 (129) = happyShift action_194
action_218 (130) = happyShift action_195
action_218 (131) = happyShift action_196
action_218 (132) = happyShift action_20
action_218 (133) = happyShift action_33
action_218 (134) = happyShift action_197
action_218 (4) = happyGoto action_165
action_218 (5) = happyGoto action_166
action_218 (6) = happyGoto action_167
action_218 (7) = happyGoto action_168
action_218 (8) = happyGoto action_169
action_218 (9) = happyGoto action_170
action_218 (10) = happyGoto action_171
action_218 (56) = happyGoto action_173
action_218 (59) = happyGoto action_174
action_218 (63) = happyGoto action_250
action_218 (64) = happyGoto action_179
action_218 _ = happyFail (happyExpListPerState 218)

action_219 (66) = happyShift action_180
action_219 (71) = happyShift action_181
action_219 (85) = happyShift action_182
action_219 (86) = happyShift action_183
action_219 (90) = happyShift action_184
action_219 (95) = happyShift action_185
action_219 (115) = happyShift action_190
action_219 (118) = happyShift action_191
action_219 (119) = happyShift action_192
action_219 (128) = happyShift action_2
action_219 (129) = happyShift action_194
action_219 (130) = happyShift action_195
action_219 (131) = happyShift action_196
action_219 (132) = happyShift action_20
action_219 (133) = happyShift action_33
action_219 (134) = happyShift action_197
action_219 (4) = happyGoto action_165
action_219 (5) = happyGoto action_166
action_219 (6) = happyGoto action_167
action_219 (7) = happyGoto action_168
action_219 (8) = happyGoto action_169
action_219 (9) = happyGoto action_170
action_219 (10) = happyGoto action_171
action_219 (56) = happyGoto action_173
action_219 (59) = happyGoto action_174
action_219 (61) = happyGoto action_249
action_219 (62) = happyGoto action_177
action_219 (63) = happyGoto action_178
action_219 (64) = happyGoto action_179
action_219 _ = happyFail (happyExpListPerState 219)

action_220 (66) = happyShift action_180
action_220 (71) = happyShift action_181
action_220 (85) = happyShift action_182
action_220 (86) = happyShift action_183
action_220 (90) = happyShift action_184
action_220 (95) = happyShift action_185
action_220 (115) = happyShift action_190
action_220 (118) = happyShift action_191
action_220 (119) = happyShift action_192
action_220 (128) = happyShift action_2
action_220 (129) = happyShift action_194
action_220 (130) = happyShift action_195
action_220 (131) = happyShift action_196
action_220 (132) = happyShift action_20
action_220 (133) = happyShift action_33
action_220 (134) = happyShift action_197
action_220 (4) = happyGoto action_165
action_220 (5) = happyGoto action_166
action_220 (6) = happyGoto action_167
action_220 (7) = happyGoto action_168
action_220 (8) = happyGoto action_169
action_220 (9) = happyGoto action_170
action_220 (10) = happyGoto action_171
action_220 (56) = happyGoto action_173
action_220 (59) = happyGoto action_174
action_220 (62) = happyGoto action_248
action_220 (63) = happyGoto action_178
action_220 (64) = happyGoto action_179
action_220 _ = happyFail (happyExpListPerState 220)

action_221 (66) = happyShift action_180
action_221 (71) = happyShift action_181
action_221 (85) = happyShift action_182
action_221 (86) = happyShift action_183
action_221 (90) = happyShift action_184
action_221 (95) = happyShift action_185
action_221 (115) = happyShift action_190
action_221 (118) = happyShift action_191
action_221 (119) = happyShift action_192
action_221 (128) = happyShift action_2
action_221 (129) = happyShift action_194
action_221 (130) = happyShift action_195
action_221 (131) = happyShift action_196
action_221 (132) = happyShift action_20
action_221 (133) = happyShift action_33
action_221 (134) = happyShift action_197
action_221 (4) = happyGoto action_165
action_221 (5) = happyGoto action_166
action_221 (6) = happyGoto action_167
action_221 (7) = happyGoto action_168
action_221 (8) = happyGoto action_169
action_221 (9) = happyGoto action_170
action_221 (10) = happyGoto action_171
action_221 (56) = happyGoto action_173
action_221 (59) = happyGoto action_174
action_221 (62) = happyGoto action_247
action_221 (63) = happyGoto action_178
action_221 (64) = happyGoto action_179
action_221 _ = happyFail (happyExpListPerState 221)

action_222 (66) = happyShift action_180
action_222 (71) = happyShift action_181
action_222 (85) = happyShift action_182
action_222 (86) = happyShift action_183
action_222 (90) = happyShift action_184
action_222 (95) = happyShift action_185
action_222 (115) = happyShift action_190
action_222 (118) = happyShift action_191
action_222 (119) = happyShift action_192
action_222 (128) = happyShift action_2
action_222 (129) = happyShift action_194
action_222 (130) = happyShift action_195
action_222 (131) = happyShift action_196
action_222 (132) = happyShift action_20
action_222 (133) = happyShift action_33
action_222 (134) = happyShift action_197
action_222 (4) = happyGoto action_165
action_222 (5) = happyGoto action_166
action_222 (6) = happyGoto action_167
action_222 (7) = happyGoto action_168
action_222 (8) = happyGoto action_169
action_222 (9) = happyGoto action_170
action_222 (10) = happyGoto action_171
action_222 (56) = happyGoto action_173
action_222 (59) = happyGoto action_174
action_222 (61) = happyGoto action_246
action_222 (62) = happyGoto action_177
action_222 (63) = happyGoto action_178
action_222 (64) = happyGoto action_179
action_222 _ = happyFail (happyExpListPerState 222)

action_223 (66) = happyShift action_180
action_223 (71) = happyShift action_181
action_223 (85) = happyShift action_182
action_223 (86) = happyShift action_183
action_223 (90) = happyShift action_184
action_223 (95) = happyShift action_185
action_223 (115) = happyShift action_190
action_223 (118) = happyShift action_191
action_223 (119) = happyShift action_192
action_223 (128) = happyShift action_2
action_223 (129) = happyShift action_194
action_223 (130) = happyShift action_195
action_223 (131) = happyShift action_196
action_223 (132) = happyShift action_20
action_223 (133) = happyShift action_33
action_223 (134) = happyShift action_197
action_223 (4) = happyGoto action_165
action_223 (5) = happyGoto action_166
action_223 (6) = happyGoto action_167
action_223 (7) = happyGoto action_168
action_223 (8) = happyGoto action_169
action_223 (9) = happyGoto action_170
action_223 (10) = happyGoto action_171
action_223 (56) = happyGoto action_173
action_223 (59) = happyGoto action_174
action_223 (61) = happyGoto action_245
action_223 (62) = happyGoto action_177
action_223 (63) = happyGoto action_178
action_223 (64) = happyGoto action_179
action_223 _ = happyFail (happyExpListPerState 223)

action_224 (66) = happyShift action_180
action_224 (71) = happyShift action_181
action_224 (85) = happyShift action_182
action_224 (86) = happyShift action_183
action_224 (90) = happyShift action_184
action_224 (95) = happyShift action_185
action_224 (115) = happyShift action_190
action_224 (118) = happyShift action_191
action_224 (119) = happyShift action_192
action_224 (128) = happyShift action_2
action_224 (129) = happyShift action_194
action_224 (130) = happyShift action_195
action_224 (131) = happyShift action_196
action_224 (132) = happyShift action_20
action_224 (133) = happyShift action_33
action_224 (134) = happyShift action_197
action_224 (4) = happyGoto action_165
action_224 (5) = happyGoto action_166
action_224 (6) = happyGoto action_167
action_224 (7) = happyGoto action_168
action_224 (8) = happyGoto action_169
action_224 (9) = happyGoto action_170
action_224 (10) = happyGoto action_171
action_224 (56) = happyGoto action_173
action_224 (59) = happyGoto action_174
action_224 (61) = happyGoto action_244
action_224 (62) = happyGoto action_177
action_224 (63) = happyGoto action_178
action_224 (64) = happyGoto action_179
action_224 _ = happyFail (happyExpListPerState 224)

action_225 (66) = happyShift action_180
action_225 (71) = happyShift action_181
action_225 (85) = happyShift action_182
action_225 (86) = happyShift action_183
action_225 (90) = happyShift action_184
action_225 (95) = happyShift action_185
action_225 (115) = happyShift action_190
action_225 (118) = happyShift action_191
action_225 (119) = happyShift action_192
action_225 (128) = happyShift action_2
action_225 (129) = happyShift action_194
action_225 (130) = happyShift action_195
action_225 (131) = happyShift action_196
action_225 (132) = happyShift action_20
action_225 (133) = happyShift action_33
action_225 (134) = happyShift action_197
action_225 (4) = happyGoto action_165
action_225 (5) = happyGoto action_166
action_225 (6) = happyGoto action_167
action_225 (7) = happyGoto action_168
action_225 (8) = happyGoto action_169
action_225 (9) = happyGoto action_170
action_225 (10) = happyGoto action_171
action_225 (56) = happyGoto action_173
action_225 (59) = happyGoto action_174
action_225 (61) = happyGoto action_243
action_225 (62) = happyGoto action_177
action_225 (63) = happyGoto action_178
action_225 (64) = happyGoto action_179
action_225 _ = happyFail (happyExpListPerState 225)

action_226 (66) = happyShift action_180
action_226 (71) = happyShift action_181
action_226 (85) = happyShift action_182
action_226 (86) = happyShift action_183
action_226 (90) = happyShift action_184
action_226 (95) = happyShift action_185
action_226 (115) = happyShift action_190
action_226 (118) = happyShift action_191
action_226 (119) = happyShift action_192
action_226 (128) = happyShift action_2
action_226 (129) = happyShift action_194
action_226 (130) = happyShift action_195
action_226 (131) = happyShift action_196
action_226 (132) = happyShift action_20
action_226 (133) = happyShift action_33
action_226 (134) = happyShift action_197
action_226 (4) = happyGoto action_165
action_226 (5) = happyGoto action_166
action_226 (6) = happyGoto action_167
action_226 (7) = happyGoto action_168
action_226 (8) = happyGoto action_169
action_226 (9) = happyGoto action_170
action_226 (10) = happyGoto action_171
action_226 (56) = happyGoto action_173
action_226 (59) = happyGoto action_174
action_226 (61) = happyGoto action_242
action_226 (62) = happyGoto action_177
action_226 (63) = happyGoto action_178
action_226 (64) = happyGoto action_179
action_226 _ = happyFail (happyExpListPerState 226)

action_227 (66) = happyShift action_180
action_227 (71) = happyShift action_181
action_227 (85) = happyShift action_182
action_227 (86) = happyShift action_183
action_227 (90) = happyShift action_184
action_227 (95) = happyShift action_185
action_227 (115) = happyShift action_190
action_227 (118) = happyShift action_191
action_227 (119) = happyShift action_192
action_227 (128) = happyShift action_2
action_227 (129) = happyShift action_194
action_227 (130) = happyShift action_195
action_227 (131) = happyShift action_196
action_227 (132) = happyShift action_20
action_227 (133) = happyShift action_33
action_227 (134) = happyShift action_197
action_227 (4) = happyGoto action_165
action_227 (5) = happyGoto action_166
action_227 (6) = happyGoto action_167
action_227 (7) = happyGoto action_168
action_227 (8) = happyGoto action_169
action_227 (9) = happyGoto action_170
action_227 (10) = happyGoto action_171
action_227 (56) = happyGoto action_173
action_227 (59) = happyGoto action_174
action_227 (61) = happyGoto action_241
action_227 (62) = happyGoto action_177
action_227 (63) = happyGoto action_178
action_227 (64) = happyGoto action_179
action_227 _ = happyFail (happyExpListPerState 227)

action_228 (66) = happyShift action_180
action_228 (71) = happyShift action_181
action_228 (85) = happyShift action_182
action_228 (86) = happyShift action_183
action_228 (90) = happyShift action_184
action_228 (95) = happyShift action_185
action_228 (115) = happyShift action_190
action_228 (118) = happyShift action_191
action_228 (119) = happyShift action_192
action_228 (128) = happyShift action_2
action_228 (129) = happyShift action_194
action_228 (130) = happyShift action_195
action_228 (131) = happyShift action_196
action_228 (132) = happyShift action_20
action_228 (133) = happyShift action_33
action_228 (134) = happyShift action_197
action_228 (4) = happyGoto action_165
action_228 (5) = happyGoto action_166
action_228 (6) = happyGoto action_167
action_228 (7) = happyGoto action_168
action_228 (8) = happyGoto action_169
action_228 (9) = happyGoto action_170
action_228 (10) = happyGoto action_171
action_228 (56) = happyGoto action_173
action_228 (59) = happyGoto action_174
action_228 (61) = happyGoto action_240
action_228 (62) = happyGoto action_177
action_228 (63) = happyGoto action_178
action_228 (64) = happyGoto action_179
action_228 _ = happyFail (happyExpListPerState 228)

action_229 (66) = happyShift action_180
action_229 (71) = happyShift action_181
action_229 (85) = happyShift action_182
action_229 (86) = happyShift action_183
action_229 (90) = happyShift action_184
action_229 (95) = happyShift action_185
action_229 (115) = happyShift action_190
action_229 (118) = happyShift action_191
action_229 (119) = happyShift action_192
action_229 (128) = happyShift action_2
action_229 (129) = happyShift action_194
action_229 (130) = happyShift action_195
action_229 (131) = happyShift action_196
action_229 (132) = happyShift action_20
action_229 (133) = happyShift action_33
action_229 (134) = happyShift action_197
action_229 (4) = happyGoto action_165
action_229 (5) = happyGoto action_166
action_229 (6) = happyGoto action_167
action_229 (7) = happyGoto action_168
action_229 (8) = happyGoto action_169
action_229 (9) = happyGoto action_170
action_229 (10) = happyGoto action_171
action_229 (56) = happyGoto action_173
action_229 (59) = happyGoto action_174
action_229 (61) = happyGoto action_239
action_229 (62) = happyGoto action_177
action_229 (63) = happyGoto action_178
action_229 (64) = happyGoto action_179
action_229 _ = happyFail (happyExpListPerState 229)

action_230 (66) = happyShift action_180
action_230 (71) = happyShift action_181
action_230 (85) = happyShift action_182
action_230 (86) = happyShift action_183
action_230 (90) = happyShift action_184
action_230 (95) = happyShift action_185
action_230 (99) = happyShift action_186
action_230 (106) = happyShift action_187
action_230 (107) = happyShift action_188
action_230 (111) = happyShift action_189
action_230 (115) = happyShift action_190
action_230 (118) = happyShift action_191
action_230 (119) = happyShift action_192
action_230 (120) = happyShift action_193
action_230 (128) = happyShift action_2
action_230 (129) = happyShift action_194
action_230 (130) = happyShift action_195
action_230 (131) = happyShift action_196
action_230 (132) = happyShift action_20
action_230 (133) = happyShift action_33
action_230 (134) = happyShift action_197
action_230 (4) = happyGoto action_165
action_230 (5) = happyGoto action_166
action_230 (6) = happyGoto action_167
action_230 (7) = happyGoto action_168
action_230 (8) = happyGoto action_169
action_230 (9) = happyGoto action_170
action_230 (10) = happyGoto action_171
action_230 (51) = happyGoto action_238
action_230 (56) = happyGoto action_173
action_230 (59) = happyGoto action_174
action_230 (60) = happyGoto action_175
action_230 (61) = happyGoto action_176
action_230 (62) = happyGoto action_177
action_230 (63) = happyGoto action_178
action_230 (64) = happyGoto action_179
action_230 _ = happyFail (happyExpListPerState 230)

action_231 (66) = happyShift action_180
action_231 (71) = happyShift action_181
action_231 (85) = happyShift action_182
action_231 (86) = happyShift action_183
action_231 (90) = happyShift action_184
action_231 (95) = happyShift action_185
action_231 (115) = happyShift action_190
action_231 (118) = happyShift action_191
action_231 (119) = happyShift action_192
action_231 (128) = happyShift action_2
action_231 (129) = happyShift action_194
action_231 (130) = happyShift action_195
action_231 (131) = happyShift action_196
action_231 (132) = happyShift action_20
action_231 (133) = happyShift action_33
action_231 (134) = happyShift action_197
action_231 (4) = happyGoto action_165
action_231 (5) = happyGoto action_166
action_231 (6) = happyGoto action_167
action_231 (7) = happyGoto action_168
action_231 (8) = happyGoto action_169
action_231 (9) = happyGoto action_170
action_231 (10) = happyGoto action_171
action_231 (56) = happyGoto action_173
action_231 (59) = happyGoto action_174
action_231 (61) = happyGoto action_237
action_231 (62) = happyGoto action_177
action_231 (63) = happyGoto action_178
action_231 (64) = happyGoto action_179
action_231 _ = happyFail (happyExpListPerState 231)

action_232 _ = happyReduce_144

action_233 (66) = happyShift action_180
action_233 (71) = happyShift action_181
action_233 (85) = happyShift action_182
action_233 (86) = happyShift action_183
action_233 (90) = happyShift action_184
action_233 (95) = happyShift action_185
action_233 (115) = happyShift action_190
action_233 (118) = happyShift action_191
action_233 (119) = happyShift action_192
action_233 (128) = happyShift action_2
action_233 (129) = happyShift action_194
action_233 (130) = happyShift action_195
action_233 (131) = happyShift action_196
action_233 (132) = happyShift action_20
action_233 (133) = happyShift action_33
action_233 (134) = happyShift action_197
action_233 (4) = happyGoto action_165
action_233 (5) = happyGoto action_166
action_233 (6) = happyGoto action_167
action_233 (7) = happyGoto action_168
action_233 (8) = happyGoto action_169
action_233 (9) = happyGoto action_170
action_233 (10) = happyGoto action_171
action_233 (56) = happyGoto action_173
action_233 (59) = happyGoto action_174
action_233 (63) = happyGoto action_236
action_233 (64) = happyGoto action_179
action_233 _ = happyFail (happyExpListPerState 233)

action_234 (66) = happyShift action_180
action_234 (71) = happyShift action_181
action_234 (85) = happyShift action_182
action_234 (86) = happyShift action_183
action_234 (90) = happyShift action_184
action_234 (95) = happyShift action_185
action_234 (115) = happyShift action_190
action_234 (118) = happyShift action_191
action_234 (119) = happyShift action_192
action_234 (128) = happyShift action_2
action_234 (129) = happyShift action_194
action_234 (130) = happyShift action_195
action_234 (131) = happyShift action_196
action_234 (132) = happyShift action_20
action_234 (133) = happyShift action_33
action_234 (134) = happyShift action_197
action_234 (4) = happyGoto action_165
action_234 (5) = happyGoto action_166
action_234 (6) = happyGoto action_167
action_234 (7) = happyGoto action_168
action_234 (8) = happyGoto action_169
action_234 (9) = happyGoto action_170
action_234 (10) = happyGoto action_171
action_234 (56) = happyGoto action_173
action_234 (59) = happyGoto action_174
action_234 (63) = happyGoto action_235
action_234 (64) = happyGoto action_179
action_234 _ = happyFail (happyExpListPerState 234)

action_235 _ = happyReduce_165

action_236 _ = happyReduce_164

action_237 (69) = happyShift action_220
action_237 (71) = happyShift action_221
action_237 _ = happyReduce_147

action_238 _ = happyReduce_113

action_239 (69) = happyShift action_220
action_239 (71) = happyShift action_221
action_239 _ = happyReduce_148

action_240 (69) = happyShift action_220
action_240 (71) = happyShift action_221
action_240 _ = happyReduce_146

action_241 (69) = happyShift action_220
action_241 (71) = happyShift action_221
action_241 _ = happyReduce_151

action_242 (69) = happyShift action_220
action_242 (71) = happyShift action_221
action_242 _ = happyReduce_149

action_243 (69) = happyShift action_220
action_243 (71) = happyShift action_221
action_243 _ = happyReduce_156

action_244 (69) = happyShift action_220
action_244 (71) = happyShift action_221
action_244 _ = happyReduce_154

action_245 (69) = happyShift action_220
action_245 (71) = happyShift action_221
action_245 _ = happyReduce_155

action_246 (69) = happyShift action_220
action_246 (71) = happyShift action_221
action_246 _ = happyReduce_153

action_247 (68) = happyShift action_217
action_247 (74) = happyShift action_218
action_247 _ = happyReduce_159

action_248 (68) = happyShift action_217
action_248 (74) = happyShift action_218
action_248 _ = happyReduce_158

action_249 (69) = happyShift action_220
action_249 (71) = happyShift action_221
action_249 _ = happyReduce_152

action_250 _ = happyReduce_162

action_251 _ = happyReduce_161

action_252 (66) = happyShift action_156
action_252 (72) = happyShift action_276
action_252 (76) = happyShift action_277
action_252 (133) = happyShift action_33
action_252 (9) = happyGoto action_152
action_252 (26) = happyGoto action_153
action_252 _ = happyFail (happyExpListPerState 252)

action_253 _ = happyReduce_139

action_254 _ = happyReduce_133

action_255 _ = happyReduce_124

action_256 (66) = happyShift action_180
action_256 (71) = happyShift action_181
action_256 (85) = happyShift action_182
action_256 (86) = happyShift action_183
action_256 (90) = happyShift action_184
action_256 (95) = happyShift action_185
action_256 (99) = happyShift action_186
action_256 (106) = happyShift action_187
action_256 (107) = happyShift action_188
action_256 (111) = happyShift action_189
action_256 (115) = happyShift action_190
action_256 (118) = happyShift action_191
action_256 (119) = happyShift action_192
action_256 (120) = happyShift action_193
action_256 (128) = happyShift action_2
action_256 (129) = happyShift action_194
action_256 (130) = happyShift action_195
action_256 (131) = happyShift action_196
action_256 (132) = happyShift action_20
action_256 (133) = happyShift action_33
action_256 (134) = happyShift action_197
action_256 (4) = happyGoto action_165
action_256 (5) = happyGoto action_166
action_256 (6) = happyGoto action_167
action_256 (7) = happyGoto action_168
action_256 (8) = happyGoto action_169
action_256 (9) = happyGoto action_170
action_256 (10) = happyGoto action_171
action_256 (51) = happyGoto action_209
action_256 (56) = happyGoto action_173
action_256 (57) = happyGoto action_210
action_256 (58) = happyGoto action_275
action_256 (59) = happyGoto action_174
action_256 (60) = happyGoto action_175
action_256 (61) = happyGoto action_176
action_256 (62) = happyGoto action_177
action_256 (63) = happyGoto action_178
action_256 (64) = happyGoto action_179
action_256 _ = happyFail (happyExpListPerState 256)

action_257 (129) = happyShift action_194
action_257 (5) = happyGoto action_274
action_257 _ = happyFail (happyExpListPerState 257)

action_258 (66) = happyShift action_180
action_258 (71) = happyShift action_181
action_258 (85) = happyShift action_182
action_258 (86) = happyShift action_183
action_258 (90) = happyShift action_184
action_258 (95) = happyShift action_185
action_258 (99) = happyShift action_186
action_258 (106) = happyShift action_187
action_258 (107) = happyShift action_188
action_258 (111) = happyShift action_189
action_258 (115) = happyShift action_190
action_258 (118) = happyShift action_191
action_258 (119) = happyShift action_192
action_258 (120) = happyShift action_193
action_258 (128) = happyShift action_2
action_258 (129) = happyShift action_194
action_258 (130) = happyShift action_195
action_258 (131) = happyShift action_196
action_258 (132) = happyShift action_20
action_258 (133) = happyShift action_33
action_258 (134) = happyShift action_197
action_258 (4) = happyGoto action_165
action_258 (5) = happyGoto action_166
action_258 (6) = happyGoto action_167
action_258 (7) = happyGoto action_168
action_258 (8) = happyGoto action_169
action_258 (9) = happyGoto action_170
action_258 (10) = happyGoto action_171
action_258 (51) = happyGoto action_273
action_258 (56) = happyGoto action_173
action_258 (59) = happyGoto action_174
action_258 (60) = happyGoto action_175
action_258 (61) = happyGoto action_176
action_258 (62) = happyGoto action_177
action_258 (63) = happyGoto action_178
action_258 (64) = happyGoto action_179
action_258 _ = happyFail (happyExpListPerState 258)

action_259 (126) = happyShift action_272
action_259 _ = happyFail (happyExpListPerState 259)

action_260 (77) = happyShift action_271
action_260 _ = happyReduce_115

action_261 (66) = happyShift action_180
action_261 (71) = happyShift action_181
action_261 (85) = happyShift action_182
action_261 (86) = happyShift action_183
action_261 (90) = happyShift action_184
action_261 (95) = happyShift action_185
action_261 (99) = happyShift action_186
action_261 (106) = happyShift action_187
action_261 (107) = happyShift action_188
action_261 (111) = happyShift action_189
action_261 (115) = happyShift action_190
action_261 (118) = happyShift action_191
action_261 (119) = happyShift action_192
action_261 (120) = happyShift action_193
action_261 (128) = happyShift action_2
action_261 (129) = happyShift action_194
action_261 (130) = happyShift action_195
action_261 (131) = happyShift action_196
action_261 (132) = happyShift action_20
action_261 (133) = happyShift action_33
action_261 (134) = happyShift action_197
action_261 (4) = happyGoto action_165
action_261 (5) = happyGoto action_166
action_261 (6) = happyGoto action_167
action_261 (7) = happyGoto action_168
action_261 (8) = happyGoto action_169
action_261 (9) = happyGoto action_170
action_261 (10) = happyGoto action_171
action_261 (51) = happyGoto action_270
action_261 (56) = happyGoto action_173
action_261 (59) = happyGoto action_174
action_261 (60) = happyGoto action_175
action_261 (61) = happyGoto action_176
action_261 (62) = happyGoto action_177
action_261 (63) = happyGoto action_178
action_261 (64) = happyGoto action_179
action_261 _ = happyFail (happyExpListPerState 261)

action_262 (66) = happyShift action_156
action_262 (76) = happyShift action_268
action_262 (80) = happyShift action_269
action_262 (133) = happyShift action_33
action_262 (9) = happyGoto action_152
action_262 (26) = happyGoto action_153
action_262 _ = happyFail (happyExpListPerState 262)

action_263 (124) = happyShift action_267
action_263 _ = happyFail (happyExpListPerState 263)

action_264 (66) = happyShift action_180
action_264 (71) = happyShift action_181
action_264 (85) = happyShift action_182
action_264 (86) = happyShift action_183
action_264 (90) = happyShift action_184
action_264 (95) = happyShift action_185
action_264 (99) = happyShift action_186
action_264 (106) = happyShift action_187
action_264 (107) = happyShift action_188
action_264 (111) = happyShift action_189
action_264 (115) = happyShift action_190
action_264 (118) = happyShift action_191
action_264 (119) = happyShift action_192
action_264 (120) = happyShift action_193
action_264 (128) = happyShift action_2
action_264 (129) = happyShift action_194
action_264 (130) = happyShift action_195
action_264 (131) = happyShift action_196
action_264 (132) = happyShift action_20
action_264 (133) = happyShift action_33
action_264 (134) = happyShift action_197
action_264 (4) = happyGoto action_165
action_264 (5) = happyGoto action_166
action_264 (6) = happyGoto action_167
action_264 (7) = happyGoto action_168
action_264 (8) = happyGoto action_169
action_264 (9) = happyGoto action_170
action_264 (10) = happyGoto action_171
action_264 (51) = happyGoto action_266
action_264 (56) = happyGoto action_173
action_264 (59) = happyGoto action_174
action_264 (60) = happyGoto action_175
action_264 (61) = happyGoto action_176
action_264 (62) = happyGoto action_177
action_264 (63) = happyGoto action_178
action_264 (64) = happyGoto action_179
action_264 _ = happyFail (happyExpListPerState 264)

action_265 _ = happyReduce_41

action_266 (103) = happyShift action_289
action_266 _ = happyFail (happyExpListPerState 266)

action_267 (66) = happyShift action_180
action_267 (71) = happyShift action_181
action_267 (85) = happyShift action_182
action_267 (86) = happyShift action_183
action_267 (90) = happyShift action_184
action_267 (95) = happyShift action_185
action_267 (99) = happyShift action_186
action_267 (106) = happyShift action_187
action_267 (107) = happyShift action_188
action_267 (111) = happyShift action_189
action_267 (115) = happyShift action_190
action_267 (118) = happyShift action_191
action_267 (119) = happyShift action_192
action_267 (120) = happyShift action_193
action_267 (128) = happyShift action_2
action_267 (129) = happyShift action_194
action_267 (130) = happyShift action_195
action_267 (131) = happyShift action_196
action_267 (132) = happyShift action_20
action_267 (133) = happyShift action_33
action_267 (134) = happyShift action_197
action_267 (4) = happyGoto action_165
action_267 (5) = happyGoto action_166
action_267 (6) = happyGoto action_167
action_267 (7) = happyGoto action_168
action_267 (8) = happyGoto action_169
action_267 (9) = happyGoto action_170
action_267 (10) = happyGoto action_171
action_267 (51) = happyGoto action_286
action_267 (54) = happyGoto action_287
action_267 (55) = happyGoto action_288
action_267 (56) = happyGoto action_173
action_267 (59) = happyGoto action_174
action_267 (60) = happyGoto action_175
action_267 (61) = happyGoto action_176
action_267 (62) = happyGoto action_177
action_267 (63) = happyGoto action_178
action_267 (64) = happyGoto action_179
action_267 _ = happyFail (happyExpListPerState 267)

action_268 (66) = happyShift action_40
action_268 (132) = happyShift action_20
action_268 (133) = happyShift action_33
action_268 (8) = happyGoto action_35
action_268 (9) = happyGoto action_36
action_268 (22) = happyGoto action_285
action_268 (23) = happyGoto action_38
action_268 _ = happyFail (happyExpListPerState 268)

action_269 (66) = happyShift action_180
action_269 (71) = happyShift action_181
action_269 (85) = happyShift action_182
action_269 (86) = happyShift action_183
action_269 (90) = happyShift action_184
action_269 (95) = happyShift action_185
action_269 (99) = happyShift action_186
action_269 (106) = happyShift action_187
action_269 (107) = happyShift action_188
action_269 (111) = happyShift action_189
action_269 (115) = happyShift action_190
action_269 (118) = happyShift action_191
action_269 (119) = happyShift action_192
action_269 (120) = happyShift action_193
action_269 (128) = happyShift action_2
action_269 (129) = happyShift action_194
action_269 (130) = happyShift action_195
action_269 (131) = happyShift action_196
action_269 (132) = happyShift action_20
action_269 (133) = happyShift action_33
action_269 (134) = happyShift action_197
action_269 (4) = happyGoto action_165
action_269 (5) = happyGoto action_166
action_269 (6) = happyGoto action_167
action_269 (7) = happyGoto action_168
action_269 (8) = happyGoto action_169
action_269 (9) = happyGoto action_170
action_269 (10) = happyGoto action_171
action_269 (51) = happyGoto action_284
action_269 (56) = happyGoto action_173
action_269 (59) = happyGoto action_174
action_269 (60) = happyGoto action_175
action_269 (61) = happyGoto action_176
action_269 (62) = happyGoto action_177
action_269 (63) = happyGoto action_178
action_269 (64) = happyGoto action_179
action_269 _ = happyFail (happyExpListPerState 269)

action_270 _ = happyReduce_109

action_271 (133) = happyShift action_33
action_271 (9) = happyGoto action_204
action_271 (52) = happyGoto action_283
action_271 (53) = happyGoto action_260
action_271 _ = happyFail (happyExpListPerState 271)

action_272 (103) = happyShift action_282
action_272 _ = happyFail (happyExpListPerState 272)

action_273 (94) = happyShift action_281
action_273 _ = happyFail (happyExpListPerState 273)

action_274 (88) = happyShift action_280
action_274 _ = happyFail (happyExpListPerState 274)

action_275 _ = happyReduce_142

action_276 (66) = happyShift action_180
action_276 (71) = happyShift action_181
action_276 (85) = happyShift action_182
action_276 (86) = happyShift action_183
action_276 (90) = happyShift action_184
action_276 (95) = happyShift action_185
action_276 (99) = happyShift action_186
action_276 (106) = happyShift action_187
action_276 (107) = happyShift action_188
action_276 (111) = happyShift action_189
action_276 (115) = happyShift action_190
action_276 (118) = happyShift action_191
action_276 (119) = happyShift action_192
action_276 (120) = happyShift action_193
action_276 (128) = happyShift action_2
action_276 (129) = happyShift action_194
action_276 (130) = happyShift action_195
action_276 (131) = happyShift action_196
action_276 (132) = happyShift action_20
action_276 (133) = happyShift action_33
action_276 (134) = happyShift action_197
action_276 (4) = happyGoto action_165
action_276 (5) = happyGoto action_166
action_276 (6) = happyGoto action_167
action_276 (7) = happyGoto action_168
action_276 (8) = happyGoto action_169
action_276 (9) = happyGoto action_170
action_276 (10) = happyGoto action_171
action_276 (51) = happyGoto action_279
action_276 (56) = happyGoto action_173
action_276 (59) = happyGoto action_174
action_276 (60) = happyGoto action_175
action_276 (61) = happyGoto action_176
action_276 (62) = happyGoto action_177
action_276 (63) = happyGoto action_178
action_276 (64) = happyGoto action_179
action_276 _ = happyFail (happyExpListPerState 276)

action_277 (66) = happyShift action_88
action_277 (132) = happyShift action_20
action_277 (133) = happyShift action_33
action_277 (8) = happyGoto action_83
action_277 (9) = happyGoto action_84
action_277 (18) = happyGoto action_278
action_277 (19) = happyGoto action_86
action_277 _ = happyFail (happyExpListPerState 277)

action_278 (72) = happyShift action_298
action_278 _ = happyFail (happyExpListPerState 278)

action_279 (67) = happyShift action_297
action_279 _ = happyFail (happyExpListPerState 279)

action_280 _ = happyReduce_126

action_281 (66) = happyShift action_180
action_281 (71) = happyShift action_181
action_281 (85) = happyShift action_182
action_281 (86) = happyShift action_183
action_281 (90) = happyShift action_184
action_281 (95) = happyShift action_185
action_281 (99) = happyShift action_186
action_281 (106) = happyShift action_187
action_281 (107) = happyShift action_188
action_281 (111) = happyShift action_189
action_281 (115) = happyShift action_190
action_281 (118) = happyShift action_191
action_281 (119) = happyShift action_192
action_281 (120) = happyShift action_193
action_281 (128) = happyShift action_2
action_281 (129) = happyShift action_194
action_281 (130) = happyShift action_195
action_281 (131) = happyShift action_196
action_281 (132) = happyShift action_20
action_281 (133) = happyShift action_33
action_281 (134) = happyShift action_197
action_281 (4) = happyGoto action_165
action_281 (5) = happyGoto action_166
action_281 (6) = happyGoto action_167
action_281 (7) = happyGoto action_168
action_281 (8) = happyGoto action_169
action_281 (9) = happyGoto action_170
action_281 (10) = happyGoto action_171
action_281 (51) = happyGoto action_296
action_281 (56) = happyGoto action_173
action_281 (59) = happyGoto action_174
action_281 (60) = happyGoto action_175
action_281 (61) = happyGoto action_176
action_281 (62) = happyGoto action_177
action_281 (63) = happyGoto action_178
action_281 (64) = happyGoto action_179
action_281 _ = happyFail (happyExpListPerState 281)

action_282 (66) = happyShift action_180
action_282 (71) = happyShift action_181
action_282 (85) = happyShift action_182
action_282 (86) = happyShift action_183
action_282 (90) = happyShift action_184
action_282 (95) = happyShift action_185
action_282 (99) = happyShift action_186
action_282 (106) = happyShift action_187
action_282 (107) = happyShift action_188
action_282 (111) = happyShift action_189
action_282 (115) = happyShift action_190
action_282 (118) = happyShift action_191
action_282 (119) = happyShift action_192
action_282 (120) = happyShift action_193
action_282 (128) = happyShift action_2
action_282 (129) = happyShift action_194
action_282 (130) = happyShift action_195
action_282 (131) = happyShift action_196
action_282 (132) = happyShift action_20
action_282 (133) = happyShift action_33
action_282 (134) = happyShift action_197
action_282 (4) = happyGoto action_165
action_282 (5) = happyGoto action_166
action_282 (6) = happyGoto action_167
action_282 (7) = happyGoto action_168
action_282 (8) = happyGoto action_169
action_282 (9) = happyGoto action_170
action_282 (10) = happyGoto action_171
action_282 (51) = happyGoto action_295
action_282 (56) = happyGoto action_173
action_282 (59) = happyGoto action_174
action_282 (60) = happyGoto action_175
action_282 (61) = happyGoto action_176
action_282 (62) = happyGoto action_177
action_282 (63) = happyGoto action_178
action_282 (64) = happyGoto action_179
action_282 _ = happyFail (happyExpListPerState 282)

action_283 _ = happyReduce_116

action_284 _ = happyReduce_118

action_285 (80) = happyShift action_294
action_285 _ = happyFail (happyExpListPerState 285)

action_286 (72) = happyShift action_293
action_286 _ = happyFail (happyExpListPerState 286)

action_287 (126) = happyShift action_292
action_287 _ = happyFail (happyExpListPerState 287)

action_288 (77) = happyShift action_291
action_288 _ = happyReduce_119

action_289 (66) = happyShift action_180
action_289 (71) = happyShift action_181
action_289 (85) = happyShift action_182
action_289 (86) = happyShift action_183
action_289 (90) = happyShift action_184
action_289 (95) = happyShift action_185
action_289 (99) = happyShift action_186
action_289 (106) = happyShift action_187
action_289 (107) = happyShift action_188
action_289 (111) = happyShift action_189
action_289 (115) = happyShift action_190
action_289 (118) = happyShift action_191
action_289 (119) = happyShift action_192
action_289 (120) = happyShift action_193
action_289 (128) = happyShift action_2
action_289 (129) = happyShift action_194
action_289 (130) = happyShift action_195
action_289 (131) = happyShift action_196
action_289 (132) = happyShift action_20
action_289 (133) = happyShift action_33
action_289 (134) = happyShift action_197
action_289 (4) = happyGoto action_165
action_289 (5) = happyGoto action_166
action_289 (6) = happyGoto action_167
action_289 (7) = happyGoto action_168
action_289 (8) = happyGoto action_169
action_289 (9) = happyGoto action_170
action_289 (10) = happyGoto action_171
action_289 (51) = happyGoto action_290
action_289 (56) = happyGoto action_173
action_289 (59) = happyGoto action_174
action_289 (60) = happyGoto action_175
action_289 (61) = happyGoto action_176
action_289 (62) = happyGoto action_177
action_289 (63) = happyGoto action_178
action_289 (64) = happyGoto action_179
action_289 _ = happyFail (happyExpListPerState 289)

action_290 _ = happyReduce_112

action_291 (66) = happyShift action_180
action_291 (71) = happyShift action_181
action_291 (85) = happyShift action_182
action_291 (86) = happyShift action_183
action_291 (90) = happyShift action_184
action_291 (95) = happyShift action_185
action_291 (99) = happyShift action_186
action_291 (106) = happyShift action_187
action_291 (107) = happyShift action_188
action_291 (111) = happyShift action_189
action_291 (115) = happyShift action_190
action_291 (118) = happyShift action_191
action_291 (119) = happyShift action_192
action_291 (120) = happyShift action_193
action_291 (128) = happyShift action_2
action_291 (129) = happyShift action_194
action_291 (130) = happyShift action_195
action_291 (131) = happyShift action_196
action_291 (132) = happyShift action_20
action_291 (133) = happyShift action_33
action_291 (134) = happyShift action_197
action_291 (4) = happyGoto action_165
action_291 (5) = happyGoto action_166
action_291 (6) = happyGoto action_167
action_291 (7) = happyGoto action_168
action_291 (8) = happyGoto action_169
action_291 (9) = happyGoto action_170
action_291 (10) = happyGoto action_171
action_291 (51) = happyGoto action_286
action_291 (54) = happyGoto action_302
action_291 (55) = happyGoto action_288
action_291 (56) = happyGoto action_173
action_291 (59) = happyGoto action_174
action_291 (60) = happyGoto action_175
action_291 (61) = happyGoto action_176
action_291 (62) = happyGoto action_177
action_291 (63) = happyGoto action_178
action_291 (64) = happyGoto action_179
action_291 _ = happyFail (happyExpListPerState 291)

action_292 _ = happyReduce_110

action_293 (66) = happyShift action_180
action_293 (71) = happyShift action_181
action_293 (85) = happyShift action_182
action_293 (86) = happyShift action_183
action_293 (90) = happyShift action_184
action_293 (95) = happyShift action_185
action_293 (99) = happyShift action_186
action_293 (106) = happyShift action_187
action_293 (107) = happyShift action_188
action_293 (111) = happyShift action_189
action_293 (115) = happyShift action_190
action_293 (118) = happyShift action_191
action_293 (119) = happyShift action_192
action_293 (120) = happyShift action_193
action_293 (128) = happyShift action_2
action_293 (129) = happyShift action_194
action_293 (130) = happyShift action_195
action_293 (131) = happyShift action_196
action_293 (132) = happyShift action_20
action_293 (133) = happyShift action_33
action_293 (134) = happyShift action_197
action_293 (4) = happyGoto action_165
action_293 (5) = happyGoto action_166
action_293 (6) = happyGoto action_167
action_293 (7) = happyGoto action_168
action_293 (8) = happyGoto action_169
action_293 (9) = happyGoto action_170
action_293 (10) = happyGoto action_171
action_293 (51) = happyGoto action_301
action_293 (56) = happyGoto action_173
action_293 (59) = happyGoto action_174
action_293 (60) = happyGoto action_175
action_293 (61) = happyGoto action_176
action_293 (62) = happyGoto action_177
action_293 (63) = happyGoto action_178
action_293 (64) = happyGoto action_179
action_293 _ = happyFail (happyExpListPerState 293)

action_294 (66) = happyShift action_180
action_294 (71) = happyShift action_181
action_294 (85) = happyShift action_182
action_294 (86) = happyShift action_183
action_294 (90) = happyShift action_184
action_294 (95) = happyShift action_185
action_294 (99) = happyShift action_186
action_294 (106) = happyShift action_187
action_294 (107) = happyShift action_188
action_294 (111) = happyShift action_189
action_294 (115) = happyShift action_190
action_294 (118) = happyShift action_191
action_294 (119) = happyShift action_192
action_294 (120) = happyShift action_193
action_294 (128) = happyShift action_2
action_294 (129) = happyShift action_194
action_294 (130) = happyShift action_195
action_294 (131) = happyShift action_196
action_294 (132) = happyShift action_20
action_294 (133) = happyShift action_33
action_294 (134) = happyShift action_197
action_294 (4) = happyGoto action_165
action_294 (5) = happyGoto action_166
action_294 (6) = happyGoto action_167
action_294 (7) = happyGoto action_168
action_294 (8) = happyGoto action_169
action_294 (9) = happyGoto action_170
action_294 (10) = happyGoto action_171
action_294 (51) = happyGoto action_300
action_294 (56) = happyGoto action_173
action_294 (59) = happyGoto action_174
action_294 (60) = happyGoto action_175
action_294 (61) = happyGoto action_176
action_294 (62) = happyGoto action_177
action_294 (63) = happyGoto action_178
action_294 (64) = happyGoto action_179
action_294 _ = happyFail (happyExpListPerState 294)

action_295 _ = happyReduce_108

action_296 _ = happyReduce_111

action_297 _ = happyReduce_123

action_298 (66) = happyShift action_180
action_298 (71) = happyShift action_181
action_298 (85) = happyShift action_182
action_298 (86) = happyShift action_183
action_298 (90) = happyShift action_184
action_298 (95) = happyShift action_185
action_298 (99) = happyShift action_186
action_298 (106) = happyShift action_187
action_298 (107) = happyShift action_188
action_298 (111) = happyShift action_189
action_298 (115) = happyShift action_190
action_298 (118) = happyShift action_191
action_298 (119) = happyShift action_192
action_298 (120) = happyShift action_193
action_298 (128) = happyShift action_2
action_298 (129) = happyShift action_194
action_298 (130) = happyShift action_195
action_298 (131) = happyShift action_196
action_298 (132) = happyShift action_20
action_298 (133) = happyShift action_33
action_298 (134) = happyShift action_197
action_298 (4) = happyGoto action_165
action_298 (5) = happyGoto action_166
action_298 (6) = happyGoto action_167
action_298 (7) = happyGoto action_168
action_298 (8) = happyGoto action_169
action_298 (9) = happyGoto action_170
action_298 (10) = happyGoto action_171
action_298 (51) = happyGoto action_299
action_298 (56) = happyGoto action_173
action_298 (59) = happyGoto action_174
action_298 (60) = happyGoto action_175
action_298 (61) = happyGoto action_176
action_298 (62) = happyGoto action_177
action_298 (63) = happyGoto action_178
action_298 (64) = happyGoto action_179
action_298 _ = happyFail (happyExpListPerState 298)

action_299 (67) = happyShift action_303
action_299 _ = happyFail (happyExpListPerState 299)

action_300 _ = happyReduce_117

action_301 _ = happyReduce_121

action_302 _ = happyReduce_120

action_303 _ = happyReduce_122

happyReduce_1 = happySpecReduce_1  4 happyReduction_1
happyReduction_1 (HappyTerminal (PT _ (TL happy_var_1)))
	 =  HappyAbsSyn4
		 (happy_var_1
	)
happyReduction_1 _  = notHappyAtAll 

happyReduce_2 = happySpecReduce_1  5 happyReduction_2
happyReduction_2 (HappyTerminal (PT _ (TI happy_var_1)))
	 =  HappyAbsSyn5
		 ((read ( happy_var_1)) :: Integer
	)
happyReduction_2 _  = notHappyAtAll 

happyReduce_3 = happySpecReduce_1  6 happyReduction_3
happyReduction_3 (HappyTerminal (PT _ (TD happy_var_1)))
	 =  HappyAbsSyn6
		 ((read ( happy_var_1)) :: Double
	)
happyReduction_3 _  = notHappyAtAll 

happyReduce_4 = happySpecReduce_1  7 happyReduction_4
happyReduction_4 (HappyTerminal (PT _ (TC happy_var_1)))
	 =  HappyAbsSyn7
		 ((read ( happy_var_1)) :: Char
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

happyReduce_8 = happySpecReduce_1  11 happyReduction_8
happyReduction_8 (HappyTerminal (PT _ (T_Op happy_var_1)))
	 =  HappyAbsSyn11
		 (Op (happy_var_1)
	)
happyReduction_8 _  = notHappyAtAll 

happyReduce_9 = happySpecReduce_2  12 happyReduction_9
happyReduction_9 (HappyAbsSyn13  happy_var_2)
	(HappyAbsSyn15  happy_var_1)
	 =  HappyAbsSyn12
		 (AbsVarg.Program (reverse happy_var_1) (reverse happy_var_2)
	)
happyReduction_9 _ _  = notHappyAtAll 

happyReduce_10 = happySpecReduce_0  13 happyReduction_10
happyReduction_10  =  HappyAbsSyn13
		 ([]
	)

happyReduce_11 = happySpecReduce_2  13 happyReduction_11
happyReduction_11 (HappyAbsSyn29  happy_var_2)
	(HappyAbsSyn13  happy_var_1)
	 =  HappyAbsSyn13
		 (flip (:) happy_var_1 happy_var_2
	)
happyReduction_11 _ _  = notHappyAtAll 

happyReduce_12 = happySpecReduce_2  14 happyReduction_12
happyReduction_12 (HappyAbsSyn4  happy_var_2)
	_
	 =  HappyAbsSyn14
		 (AbsVarg.Import happy_var_2
	)
happyReduction_12 _ _  = notHappyAtAll 

happyReduce_13 = happySpecReduce_0  15 happyReduction_13
happyReduction_13  =  HappyAbsSyn15
		 ([]
	)

happyReduce_14 = happySpecReduce_2  15 happyReduction_14
happyReduction_14 (HappyAbsSyn14  happy_var_2)
	(HappyAbsSyn15  happy_var_1)
	 =  HappyAbsSyn15
		 (flip (:) happy_var_1 happy_var_2
	)
happyReduction_14 _ _  = notHappyAtAll 

happyReduce_15 = happySpecReduce_0  16 happyReduction_15
happyReduction_15  =  HappyAbsSyn16
		 ([]
	)

happyReduce_16 = happySpecReduce_2  16 happyReduction_16
happyReduction_16 (HappyAbsSyn17  happy_var_2)
	(HappyAbsSyn16  happy_var_1)
	 =  HappyAbsSyn16
		 (flip (:) happy_var_1 happy_var_2
	)
happyReduction_16 _ _  = notHappyAtAll 

happyReduce_17 = happySpecReduce_1  17 happyReduction_17
happyReduction_17 (HappyAbsSyn9  happy_var_1)
	 =  HappyAbsSyn17
		 (AbsVarg.InferredTypeParam happy_var_1
	)
happyReduction_17 _  = notHappyAtAll 

happyReduce_18 = happySpecReduce_1  17 happyReduction_18
happyReduction_18 (HappyAbsSyn8  happy_var_1)
	 =  HappyAbsSyn17
		 (AbsVarg.ConcreteTypeParam happy_var_1
	)
happyReduction_18 _  = notHappyAtAll 

happyReduce_19 = happySpecReduce_1  17 happyReduction_19
happyReduction_19 _
	 =  HappyAbsSyn17
		 (AbsVarg.WildcardTypeParam
	)

happyReduce_20 = happyReduce 5 17 happyReduction_20
happyReduction_20 (_ `HappyStk`
	(HappyAbsSyn20  happy_var_4) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn9  happy_var_2) `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn17
		 (AbsVarg.SuperConstrainedTypeParam happy_var_2 happy_var_4
	) `HappyStk` happyRest

happyReduce_21 = happyReduce 5 17 happyReduction_21
happyReduction_21 (_ `HappyStk`
	(HappyAbsSyn20  happy_var_4) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn17
		 (AbsVarg.AnySuperConstrainedTypeParam happy_var_4
	) `HappyStk` happyRest

happyReduce_22 = happyReduce 5 17 happyReduction_22
happyReduction_22 (_ `HappyStk`
	(HappyAbsSyn20  happy_var_4) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn9  happy_var_2) `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn17
		 (AbsVarg.DerivingConstrainedTypeParam happy_var_2 happy_var_4
	) `HappyStk` happyRest

happyReduce_23 = happyReduce 5 17 happyReduction_23
happyReduction_23 (_ `HappyStk`
	(HappyAbsSyn20  happy_var_4) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn17
		 (AbsVarg.AnyDerivingConstrainedTypeParam happy_var_4
	) `HappyStk` happyRest

happyReduce_24 = happySpecReduce_2  18 happyReduction_24
happyReduction_24 (HappyAbsSyn16  happy_var_2)
	(HappyAbsSyn8  happy_var_1)
	 =  HappyAbsSyn18
		 (AbsVarg.ConcreteType happy_var_1 (reverse happy_var_2)
	)
happyReduction_24 _ _  = notHappyAtAll 

happyReduce_25 = happySpecReduce_2  18 happyReduction_25
happyReduction_25 (HappyAbsSyn16  happy_var_2)
	(HappyAbsSyn9  happy_var_1)
	 =  HappyAbsSyn18
		 (AbsVarg.InferredType happy_var_1 (reverse happy_var_2)
	)
happyReduction_25 _ _  = notHappyAtAll 

happyReduce_26 = happySpecReduce_1  18 happyReduction_26
happyReduction_26 (HappyAbsSyn18  happy_var_1)
	 =  HappyAbsSyn18
		 (happy_var_1
	)
happyReduction_26 _  = notHappyAtAll 

happyReduce_27 = happySpecReduce_3  19 happyReduction_27
happyReduction_27 _
	(HappyAbsSyn18  happy_var_2)
	_
	 =  HappyAbsSyn18
		 (happy_var_2
	)
happyReduction_27 _ _ _  = notHappyAtAll 

happyReduce_28 = happySpecReduce_1  20 happyReduction_28
happyReduction_28 (HappyAbsSyn18  happy_var_1)
	 =  HappyAbsSyn20
		 ((:[]) happy_var_1
	)
happyReduction_28 _  = notHappyAtAll 

happyReduce_29 = happySpecReduce_3  20 happyReduction_29
happyReduction_29 (HappyAbsSyn20  happy_var_3)
	_
	(HappyAbsSyn18  happy_var_1)
	 =  HappyAbsSyn20
		 ((:) happy_var_1 happy_var_3
	)
happyReduction_29 _ _ _  = notHappyAtAll 

happyReduce_30 = happySpecReduce_3  21 happyReduction_30
happyReduction_30 _
	(HappyAbsSyn22  happy_var_2)
	_
	 =  HappyAbsSyn21
		 (AbsVarg.ConcreteTypeFreeType happy_var_2
	)
happyReduction_30 _ _ _  = notHappyAtAll 

happyReduce_31 = happySpecReduce_1  21 happyReduction_31
happyReduction_31 (HappyAbsSyn9  happy_var_1)
	 =  HappyAbsSyn21
		 (AbsVarg.TemplateFreeType happy_var_1
	)
happyReduction_31 _  = notHappyAtAll 

happyReduce_32 = happySpecReduce_1  21 happyReduction_32
happyReduction_32 (HappyAbsSyn8  happy_var_1)
	 =  HappyAbsSyn21
		 (AbsVarg.ConcreteFreeType happy_var_1
	)
happyReduction_32 _  = notHappyAtAll 

happyReduce_33 = happySpecReduce_2  22 happyReduction_33
happyReduction_33 (HappyAbsSyn24  happy_var_2)
	(HappyAbsSyn8  happy_var_1)
	 =  HappyAbsSyn22
		 (AbsVarg.FreeType happy_var_1 (reverse happy_var_2)
	)
happyReduction_33 _ _  = notHappyAtAll 

happyReduce_34 = happySpecReduce_2  22 happyReduction_34
happyReduction_34 (HappyAbsSyn24  happy_var_2)
	(HappyAbsSyn9  happy_var_1)
	 =  HappyAbsSyn22
		 (AbsVarg.InferredFreeType happy_var_1 (reverse happy_var_2)
	)
happyReduction_34 _ _  = notHappyAtAll 

happyReduce_35 = happySpecReduce_1  22 happyReduction_35
happyReduction_35 (HappyAbsSyn22  happy_var_1)
	 =  HappyAbsSyn22
		 (happy_var_1
	)
happyReduction_35 _  = notHappyAtAll 

happyReduce_36 = happySpecReduce_3  23 happyReduction_36
happyReduction_36 _
	(HappyAbsSyn22  happy_var_2)
	_
	 =  HappyAbsSyn22
		 (happy_var_2
	)
happyReduction_36 _ _ _  = notHappyAtAll 

happyReduce_37 = happySpecReduce_0  24 happyReduction_37
happyReduction_37  =  HappyAbsSyn24
		 ([]
	)

happyReduce_38 = happySpecReduce_2  24 happyReduction_38
happyReduction_38 (HappyAbsSyn21  happy_var_2)
	(HappyAbsSyn24  happy_var_1)
	 =  HappyAbsSyn24
		 (flip (:) happy_var_1 happy_var_2
	)
happyReduction_38 _ _  = notHappyAtAll 

happyReduce_39 = happySpecReduce_0  25 happyReduction_39
happyReduction_39  =  HappyAbsSyn25
		 ([]
	)

happyReduce_40 = happySpecReduce_2  25 happyReduction_40
happyReduction_40 (HappyAbsSyn26  happy_var_2)
	(HappyAbsSyn25  happy_var_1)
	 =  HappyAbsSyn25
		 (flip (:) happy_var_1 happy_var_2
	)
happyReduction_40 _ _  = notHappyAtAll 

happyReduce_41 = happyReduce 5 26 happyReduction_41
happyReduction_41 (_ `HappyStk`
	(HappyAbsSyn22  happy_var_4) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn9  happy_var_2) `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn26
		 (AbsVarg.ArgumentDefinition happy_var_2 happy_var_4
	) `HappyStk` happyRest

happyReduce_42 = happySpecReduce_1  26 happyReduction_42
happyReduction_42 (HappyAbsSyn9  happy_var_1)
	 =  HappyAbsSyn26
		 (AbsVarg.InferredArgumentDef happy_var_1
	)
happyReduction_42 _  = notHappyAtAll 

happyReduce_43 = happySpecReduce_1  27 happyReduction_43
happyReduction_43 (HappyAbsSyn22  happy_var_1)
	 =  HappyAbsSyn27
		 (AbsVarg.Superclass happy_var_1
	)
happyReduction_43 _  = notHappyAtAll 

happyReduce_44 = happySpecReduce_1  28 happyReduction_44
happyReduction_44 (HappyAbsSyn27  happy_var_1)
	 =  HappyAbsSyn28
		 ((:[]) happy_var_1
	)
happyReduction_44 _  = notHappyAtAll 

happyReduce_45 = happySpecReduce_3  28 happyReduction_45
happyReduction_45 (HappyAbsSyn28  happy_var_3)
	_
	(HappyAbsSyn27  happy_var_1)
	 =  HappyAbsSyn28
		 ((:) happy_var_1 happy_var_3
	)
happyReduction_45 _ _ _  = notHappyAtAll 

happyReduce_46 = happyReduce 7 29 happyReduction_46
happyReduction_46 (_ `HappyStk`
	(HappyAbsSyn49  happy_var_6) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn8  happy_var_3) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn32  happy_var_1) `HappyStk`
	happyRest)
	 = HappyAbsSyn29
		 (AbsVarg.StructDefinition (reverse happy_var_1) happy_var_3 happy_var_6
	) `HappyStk` happyRest

happyReduce_47 = happyReduce 9 29 happyReduction_47
happyReduction_47 (_ `HappyStk`
	(HappyAbsSyn34  happy_var_8) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn30  happy_var_5) `HappyStk`
	(HappyAbsSyn31  happy_var_4) `HappyStk`
	(HappyAbsSyn8  happy_var_3) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn32  happy_var_1) `HappyStk`
	happyRest)
	 = HappyAbsSyn29
		 (AbsVarg.ClassDefinition (reverse happy_var_1) happy_var_3 happy_var_4 happy_var_5 happy_var_8
	) `HappyStk` happyRest

happyReduce_48 = happyReduce 10 29 happyReduction_48
happyReduction_48 (_ `HappyStk`
	(HappyAbsSyn34  happy_var_9) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn30  happy_var_6) `HappyStk`
	(HappyAbsSyn31  happy_var_5) `HappyStk`
	(HappyAbsSyn16  happy_var_4) `HappyStk`
	(HappyAbsSyn8  happy_var_3) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn32  happy_var_1) `HappyStk`
	happyRest)
	 = HappyAbsSyn29
		 (AbsVarg.TemplateDefinition (reverse happy_var_1) happy_var_3 (reverse happy_var_4) happy_var_5 happy_var_6 happy_var_9
	) `HappyStk` happyRest

happyReduce_49 = happySpecReduce_2  30 happyReduction_49
happyReduction_49 (HappyAbsSyn28  happy_var_2)
	_
	 =  HappyAbsSyn30
		 (AbsVarg.Implementing happy_var_2
	)
happyReduction_49 _ _  = notHappyAtAll 

happyReduce_50 = happySpecReduce_0  30 happyReduction_50
happyReduction_50  =  HappyAbsSyn30
		 (AbsVarg.NotImplementing
	)

happyReduce_51 = happySpecReduce_2  31 happyReduction_51
happyReduction_51 (HappyAbsSyn27  happy_var_2)
	_
	 =  HappyAbsSyn31
		 (AbsVarg.Deriving happy_var_2
	)
happyReduction_51 _ _  = notHappyAtAll 

happyReduce_52 = happySpecReduce_0  31 happyReduction_52
happyReduction_52  =  HappyAbsSyn31
		 (AbsVarg.NotDeriving
	)

happyReduce_53 = happySpecReduce_0  32 happyReduction_53
happyReduction_53  =  HappyAbsSyn32
		 ([]
	)

happyReduce_54 = happySpecReduce_2  32 happyReduction_54
happyReduction_54 (HappyAbsSyn33  happy_var_2)
	(HappyAbsSyn32  happy_var_1)
	 =  HappyAbsSyn32
		 (flip (:) happy_var_1 happy_var_2
	)
happyReduction_54 _ _  = notHappyAtAll 

happyReduce_55 = happySpecReduce_1  33 happyReduction_55
happyReduction_55 _
	 =  HappyAbsSyn33
		 (AbsVarg.ClassModifier_module
	)

happyReduce_56 = happySpecReduce_1  33 happyReduction_56
happyReduction_56 _
	 =  HappyAbsSyn33
		 (AbsVarg.ClassModifier_interface
	)

happyReduce_57 = happySpecReduce_1  33 happyReduction_57
happyReduction_57 _
	 =  HappyAbsSyn33
		 (AbsVarg.ClassModifier_sealed
	)

happyReduce_58 = happySpecReduce_1  33 happyReduction_58
happyReduction_58 _
	 =  HappyAbsSyn33
		 (AbsVarg.ClassModifier_native
	)

happyReduce_59 = happySpecReduce_2  34 happyReduction_59
happyReduction_59 (HappyAbsSyn45  happy_var_2)
	(HappyAbsSyn36  happy_var_1)
	 =  HappyAbsSyn34
		 (AbsVarg.ClassContent happy_var_1 happy_var_2
	)
happyReduction_59 _ _  = notHappyAtAll 

happyReduce_60 = happySpecReduce_1  35 happyReduction_60
happyReduction_60 (HappyAbsSyn8  happy_var_1)
	 =  HappyAbsSyn35
		 (AbsVarg.EmptyMemberDefinition happy_var_1
	)
happyReduction_60 _  = notHappyAtAll 

happyReduce_61 = happyReduce 5 35 happyReduction_61
happyReduction_61 (_ `HappyStk`
	(HappyAbsSyn49  happy_var_4) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn8  happy_var_1) `HappyStk`
	happyRest)
	 = HappyAbsSyn35
		 (AbsVarg.MemberDefinition happy_var_1 happy_var_4
	) `HappyStk` happyRest

happyReduce_62 = happySpecReduce_0  36 happyReduction_62
happyReduction_62  =  HappyAbsSyn36
		 ([]
	)

happyReduce_63 = happySpecReduce_1  36 happyReduction_63
happyReduction_63 (HappyAbsSyn35  happy_var_1)
	 =  HappyAbsSyn36
		 ((:[]) happy_var_1
	)
happyReduction_63 _  = notHappyAtAll 

happyReduce_64 = happySpecReduce_3  36 happyReduction_64
happyReduction_64 (HappyAbsSyn36  happy_var_3)
	_
	(HappyAbsSyn35  happy_var_1)
	 =  HappyAbsSyn36
		 ((:) happy_var_1 happy_var_3
	)
happyReduction_64 _ _ _  = notHappyAtAll 

happyReduce_65 = happyReduce 8 37 happyReduction_65
happyReduction_65 ((HappyAbsSyn51  happy_var_8) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn38  happy_var_6) `HappyStk`
	(HappyAbsSyn25  happy_var_5) `HappyStk`
	(HappyAbsSyn42  happy_var_4) `HappyStk`
	(HappyAbsSyn39  happy_var_3) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn46  happy_var_1) `HappyStk`
	happyRest)
	 = HappyAbsSyn37
		 (AbsVarg.MemberFunctionDefinition (reverse happy_var_1) happy_var_3 happy_var_4 (reverse happy_var_5) happy_var_6 happy_var_8
	) `HappyStk` happyRest

happyReduce_66 = happyReduce 6 37 happyReduction_66
happyReduction_66 ((HappyAbsSyn41  happy_var_6) `HappyStk`
	(HappyAbsSyn25  happy_var_5) `HappyStk`
	(HappyAbsSyn42  happy_var_4) `HappyStk`
	(HappyAbsSyn39  happy_var_3) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn46  happy_var_1) `HappyStk`
	happyRest)
	 = HappyAbsSyn37
		 (AbsVarg.AbstractFunctionDefinition (reverse happy_var_1) happy_var_3 happy_var_4 (reverse happy_var_5) happy_var_6
	) `HappyStk` happyRest

happyReduce_67 = happySpecReduce_2  38 happyReduction_67
happyReduction_67 (HappyAbsSyn22  happy_var_2)
	_
	 =  HappyAbsSyn38
		 (AbsVarg.ReturnType happy_var_2
	)
happyReduction_67 _ _  = notHappyAtAll 

happyReduce_68 = happySpecReduce_0  38 happyReduction_68
happyReduction_68  =  HappyAbsSyn38
		 (AbsVarg.InferredReturnType
	)

happyReduce_69 = happySpecReduce_1  39 happyReduction_69
happyReduction_69 (HappyAbsSyn9  happy_var_1)
	 =  HappyAbsSyn39
		 (AbsVarg.FFunction happy_var_1
	)
happyReduction_69 _  = notHappyAtAll 

happyReduce_70 = happySpecReduce_3  39 happyReduction_70
happyReduction_70 _
	(HappyAbsSyn40  happy_var_2)
	_
	 =  HappyAbsSyn39
		 (AbsVarg.FOperator happy_var_2
	)
happyReduction_70 _ _ _  = notHappyAtAll 

happyReduce_71 = happySpecReduce_3  39 happyReduction_71
happyReduction_71 _
	(HappyAbsSyn11  happy_var_2)
	_
	 =  HappyAbsSyn39
		 (AbsVarg.FOperatorDef happy_var_2
	)
happyReduction_71 _ _ _  = notHappyAtAll 

happyReduce_72 = happySpecReduce_1  40 happyReduction_72
happyReduction_72 _
	 =  HappyAbsSyn40
		 (AbsVarg.Op_plus
	)

happyReduce_73 = happySpecReduce_1  40 happyReduction_73
happyReduction_73 _
	 =  HappyAbsSyn40
		 (AbsVarg.Op_minus
	)

happyReduce_74 = happySpecReduce_1  40 happyReduction_74
happyReduction_74 _
	 =  HappyAbsSyn40
		 (AbsVarg.Op_mul
	)

happyReduce_75 = happySpecReduce_1  40 happyReduction_75
happyReduction_75 _
	 =  HappyAbsSyn40
		 (AbsVarg.Op_div
	)

happyReduce_76 = happySpecReduce_1  40 happyReduction_76
happyReduction_76 _
	 =  HappyAbsSyn40
		 (AbsVarg.Op_pow
	)

happyReduce_77 = happySpecReduce_1  40 happyReduction_77
happyReduction_77 _
	 =  HappyAbsSyn40
		 (AbsVarg.Op_less
	)

happyReduce_78 = happySpecReduce_1  40 happyReduction_78
happyReduction_78 _
	 =  HappyAbsSyn40
		 (AbsVarg.Op_gr
	)

happyReduce_79 = happySpecReduce_1  40 happyReduction_79
happyReduction_79 _
	 =  HappyAbsSyn40
		 (AbsVarg.Op_leq
	)

happyReduce_80 = happySpecReduce_1  40 happyReduction_80
happyReduction_80 _
	 =  HappyAbsSyn40
		 (AbsVarg.Op_geq
	)

happyReduce_81 = happySpecReduce_1  40 happyReduction_81
happyReduction_81 _
	 =  HappyAbsSyn40
		 (AbsVarg.Op_eq
	)

happyReduce_82 = happySpecReduce_1  40 happyReduction_82
happyReduction_82 _
	 =  HappyAbsSyn40
		 (AbsVarg.Op_cons
	)

happyReduce_83 = happySpecReduce_3  41 happyReduction_83
happyReduction_83 (HappyAbsSyn22  happy_var_3)
	_
	_
	 =  HappyAbsSyn41
		 (AbsVarg.AbsReturnType happy_var_3
	)
happyReduction_83 _ _ _  = notHappyAtAll 

happyReduce_84 = happySpecReduce_0  41 happyReduction_84
happyReduction_84  =  HappyAbsSyn41
		 (AbsVarg.AbsInferredReturnType
	)

happyReduce_85 = happySpecReduce_0  42 happyReduction_85
happyReduction_85  =  HappyAbsSyn42
		 (AbsVarg.NoFunctionTemplateParameter
	)

happyReduce_86 = happySpecReduce_3  42 happyReduction_86
happyReduction_86 _
	(HappyAbsSyn44  happy_var_2)
	_
	 =  HappyAbsSyn42
		 (AbsVarg.FunctionTemplateParameters happy_var_2
	)
happyReduction_86 _ _ _  = notHappyAtAll 

happyReduce_87 = happySpecReduce_1  43 happyReduction_87
happyReduction_87 (HappyAbsSyn17  happy_var_1)
	 =  HappyAbsSyn43
		 (AbsVarg.TemplateParameter happy_var_1
	)
happyReduction_87 _  = notHappyAtAll 

happyReduce_88 = happySpecReduce_1  44 happyReduction_88
happyReduction_88 (HappyAbsSyn43  happy_var_1)
	 =  HappyAbsSyn44
		 ((:[]) happy_var_1
	)
happyReduction_88 _  = notHappyAtAll 

happyReduce_89 = happySpecReduce_3  44 happyReduction_89
happyReduction_89 (HappyAbsSyn44  happy_var_3)
	_
	(HappyAbsSyn43  happy_var_1)
	 =  HappyAbsSyn44
		 ((:) happy_var_1 happy_var_3
	)
happyReduction_89 _ _ _  = notHappyAtAll 

happyReduce_90 = happySpecReduce_0  45 happyReduction_90
happyReduction_90  =  HappyAbsSyn45
		 ([]
	)

happyReduce_91 = happySpecReduce_1  45 happyReduction_91
happyReduction_91 (HappyAbsSyn37  happy_var_1)
	 =  HappyAbsSyn45
		 ((:[]) happy_var_1
	)
happyReduction_91 _  = notHappyAtAll 

happyReduce_92 = happySpecReduce_3  45 happyReduction_92
happyReduction_92 (HappyAbsSyn45  happy_var_3)
	_
	(HappyAbsSyn37  happy_var_1)
	 =  HappyAbsSyn45
		 ((:) happy_var_1 happy_var_3
	)
happyReduction_92 _ _ _  = notHappyAtAll 

happyReduce_93 = happySpecReduce_0  46 happyReduction_93
happyReduction_93  =  HappyAbsSyn46
		 ([]
	)

happyReduce_94 = happySpecReduce_2  46 happyReduction_94
happyReduction_94 (HappyAbsSyn47  happy_var_2)
	(HappyAbsSyn46  happy_var_1)
	 =  HappyAbsSyn46
		 (flip (:) happy_var_1 happy_var_2
	)
happyReduction_94 _ _  = notHappyAtAll 

happyReduce_95 = happySpecReduce_1  47 happyReduction_95
happyReduction_95 _
	 =  HappyAbsSyn47
		 (AbsVarg.FunctionModifier_static
	)

happyReduce_96 = happySpecReduce_1  47 happyReduction_96
happyReduction_96 _
	 =  HappyAbsSyn47
		 (AbsVarg.FunctionModifier_internal
	)

happyReduce_97 = happySpecReduce_1  47 happyReduction_97
happyReduction_97 _
	 =  HappyAbsSyn47
		 (AbsVarg.FunctionModifier_implement
	)

happyReduce_98 = happySpecReduce_1  47 happyReduction_98
happyReduction_98 _
	 =  HappyAbsSyn47
		 (AbsVarg.FunctionModifier_final
	)

happyReduce_99 = happySpecReduce_1  47 happyReduction_99
happyReduction_99 _
	 =  HappyAbsSyn47
		 (AbsVarg.FunctionModifier_unique
	)

happyReduce_100 = happySpecReduce_1  47 happyReduction_100
happyReduction_100 _
	 =  HappyAbsSyn47
		 (AbsVarg.FunctionModifier_native
	)

happyReduce_101 = happyReduce 4 48 happyReduction_101
happyReduction_101 ((HappyAbsSyn22  happy_var_4) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn9  happy_var_2) `HappyStk`
	(HappyAbsSyn50  happy_var_1) `HappyStk`
	happyRest)
	 = HappyAbsSyn48
		 (AbsVarg.ModifiedClassField happy_var_1 happy_var_2 happy_var_4
	) `HappyStk` happyRest

happyReduce_102 = happySpecReduce_3  48 happyReduction_102
happyReduction_102 (HappyAbsSyn22  happy_var_3)
	_
	(HappyAbsSyn9  happy_var_1)
	 =  HappyAbsSyn48
		 (AbsVarg.NormalClassField happy_var_1 happy_var_3
	)
happyReduction_102 _ _ _  = notHappyAtAll 

happyReduce_103 = happySpecReduce_0  49 happyReduction_103
happyReduction_103  =  HappyAbsSyn49
		 ([]
	)

happyReduce_104 = happySpecReduce_1  49 happyReduction_104
happyReduction_104 (HappyAbsSyn48  happy_var_1)
	 =  HappyAbsSyn49
		 ((:[]) happy_var_1
	)
happyReduction_104 _  = notHappyAtAll 

happyReduce_105 = happySpecReduce_3  49 happyReduction_105
happyReduction_105 (HappyAbsSyn49  happy_var_3)
	_
	(HappyAbsSyn48  happy_var_1)
	 =  HappyAbsSyn49
		 ((:) happy_var_1 happy_var_3
	)
happyReduction_105 _ _ _  = notHappyAtAll 

happyReduce_106 = happySpecReduce_1  50 happyReduction_106
happyReduction_106 _
	 =  HappyAbsSyn50
		 (AbsVarg.FieldModifier_internal
	)

happyReduce_107 = happySpecReduce_1  50 happyReduction_107
happyReduction_107 _
	 =  HappyAbsSyn50
		 (AbsVarg.FieldModifier_unique
	)

happyReduce_108 = happyReduce 6 51 happyReduction_108
happyReduction_108 ((HappyAbsSyn51  happy_var_6) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn52  happy_var_3) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn51
		 (AbsVarg.EDefinitionsList happy_var_3 happy_var_6
	) `HappyStk` happyRest

happyReduce_109 = happyReduce 4 51 happyReduction_109
happyReduction_109 ((HappyAbsSyn51  happy_var_4) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn53  happy_var_2) `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn51
		 (AbsVarg.EDefinition happy_var_2 happy_var_4
	) `HappyStk` happyRest

happyReduce_110 = happyReduce 6 51 happyReduction_110
happyReduction_110 (_ `HappyStk`
	(HappyAbsSyn54  happy_var_5) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn51  happy_var_2) `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn51
		 (AbsVarg.EMatch happy_var_2 happy_var_5
	) `HappyStk` happyRest

happyReduce_111 = happyReduce 6 51 happyReduction_111
happyReduction_111 ((HappyAbsSyn51  happy_var_6) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn51  happy_var_4) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn51  happy_var_2) `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn51
		 (AbsVarg.EIfThenElse happy_var_2 happy_var_4 happy_var_6
	) `HappyStk` happyRest

happyReduce_112 = happyReduce 6 51 happyReduction_112
happyReduction_112 ((HappyAbsSyn51  happy_var_6) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn51  happy_var_4) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn51  happy_var_2) `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn51
		 (AbsVarg.EUnify happy_var_2 happy_var_4 happy_var_6
	) `HappyStk` happyRest

happyReduce_113 = happySpecReduce_3  51 happyReduction_113
happyReduction_113 (HappyAbsSyn51  happy_var_3)
	_
	(HappyAbsSyn51  happy_var_1)
	 =  HappyAbsSyn51
		 (AbsVarg.ECons happy_var_1 happy_var_3
	)
happyReduction_113 _ _ _  = notHappyAtAll 

happyReduce_114 = happySpecReduce_1  51 happyReduction_114
happyReduction_114 (HappyAbsSyn51  happy_var_1)
	 =  HappyAbsSyn51
		 (happy_var_1
	)
happyReduction_114 _  = notHappyAtAll 

happyReduce_115 = happySpecReduce_1  52 happyReduction_115
happyReduction_115 (HappyAbsSyn53  happy_var_1)
	 =  HappyAbsSyn52
		 ((:[]) happy_var_1
	)
happyReduction_115 _  = notHappyAtAll 

happyReduce_116 = happySpecReduce_3  52 happyReduction_116
happyReduction_116 (HappyAbsSyn52  happy_var_3)
	_
	(HappyAbsSyn53  happy_var_1)
	 =  HappyAbsSyn52
		 ((:) happy_var_1 happy_var_3
	)
happyReduction_116 _ _ _  = notHappyAtAll 

happyReduce_117 = happyReduce 6 53 happyReduction_117
happyReduction_117 ((HappyAbsSyn51  happy_var_6) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn22  happy_var_4) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn25  happy_var_2) `HappyStk`
	(HappyAbsSyn9  happy_var_1) `HappyStk`
	happyRest)
	 = HappyAbsSyn53
		 (AbsVarg.IDefinition happy_var_1 (reverse happy_var_2) happy_var_4 happy_var_6
	) `HappyStk` happyRest

happyReduce_118 = happyReduce 4 53 happyReduction_118
happyReduction_118 ((HappyAbsSyn51  happy_var_4) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn25  happy_var_2) `HappyStk`
	(HappyAbsSyn9  happy_var_1) `HappyStk`
	happyRest)
	 = HappyAbsSyn53
		 (AbsVarg.IInferredDefinition happy_var_1 (reverse happy_var_2) happy_var_4
	) `HappyStk` happyRest

happyReduce_119 = happySpecReduce_1  54 happyReduction_119
happyReduction_119 (HappyAbsSyn55  happy_var_1)
	 =  HappyAbsSyn54
		 ((:[]) happy_var_1
	)
happyReduction_119 _  = notHappyAtAll 

happyReduce_120 = happySpecReduce_3  54 happyReduction_120
happyReduction_120 (HappyAbsSyn54  happy_var_3)
	_
	(HappyAbsSyn55  happy_var_1)
	 =  HappyAbsSyn54
		 ((:) happy_var_1 happy_var_3
	)
happyReduction_120 _ _ _  = notHappyAtAll 

happyReduce_121 = happySpecReduce_3  55 happyReduction_121
happyReduction_121 (HappyAbsSyn51  happy_var_3)
	_
	(HappyAbsSyn51  happy_var_1)
	 =  HappyAbsSyn55
		 (AbsVarg.IMatchClause happy_var_1 happy_var_3
	)
happyReduction_121 _ _ _  = notHappyAtAll 

happyReduce_122 = happyReduce 8 56 happyReduction_122
happyReduction_122 (_ `HappyStk`
	(HappyAbsSyn51  happy_var_7) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn18  happy_var_5) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn25  happy_var_3) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn51
		 (AbsVarg.ELambda (reverse happy_var_3) happy_var_5 happy_var_7
	) `HappyStk` happyRest

happyReduce_123 = happyReduce 6 56 happyReduction_123
happyReduction_123 (_ `HappyStk`
	(HappyAbsSyn51  happy_var_5) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn25  happy_var_3) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn51
		 (AbsVarg.EInferredLambda (reverse happy_var_3) happy_var_5
	) `HappyStk` happyRest

happyReduce_124 = happySpecReduce_3  56 happyReduction_124
happyReduction_124 _
	(HappyAbsSyn58  happy_var_2)
	_
	 =  HappyAbsSyn51
		 (AbsVarg.EList happy_var_2
	)
happyReduction_124 _ _ _  = notHappyAtAll 

happyReduce_125 = happySpecReduce_1  56 happyReduction_125
happyReduction_125 _
	 =  HappyAbsSyn51
		 (AbsVarg.EEmptyList
	)

happyReduce_126 = happyReduce 5 56 happyReduction_126
happyReduction_126 (_ `HappyStk`
	(HappyAbsSyn5  happy_var_4) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn5  happy_var_2) `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn51
		 (AbsVarg.ERange happy_var_2 happy_var_4
	) `HappyStk` happyRest

happyReduce_127 = happySpecReduce_1  56 happyReduction_127
happyReduction_127 (HappyAbsSyn64  happy_var_1)
	 =  HappyAbsSyn51
		 (AbsVarg.EBoolean happy_var_1
	)
happyReduction_127 _  = notHappyAtAll 

happyReduce_128 = happySpecReduce_1  56 happyReduction_128
happyReduction_128 _
	 =  HappyAbsSyn51
		 (AbsVarg.EThis
	)

happyReduce_129 = happySpecReduce_1  56 happyReduction_129
happyReduction_129 _
	 =  HappyAbsSyn51
		 (AbsVarg.ESuper
	)

happyReduce_130 = happySpecReduce_1  56 happyReduction_130
happyReduction_130 (HappyAbsSyn9  happy_var_1)
	 =  HappyAbsSyn51
		 (AbsVarg.EVar happy_var_1
	)
happyReduction_130 _  = notHappyAtAll 

happyReduce_131 = happySpecReduce_1  56 happyReduction_131
happyReduction_131 (HappyAbsSyn8  happy_var_1)
	 =  HappyAbsSyn51
		 (AbsVarg.EType happy_var_1
	)
happyReduction_131 _  = notHappyAtAll 

happyReduce_132 = happySpecReduce_1  56 happyReduction_132
happyReduction_132 (HappyAbsSyn10  happy_var_1)
	 =  HappyAbsSyn51
		 (AbsVarg.EMember happy_var_1
	)
happyReduction_132 _  = notHappyAtAll 

happyReduce_133 = happySpecReduce_3  56 happyReduction_133
happyReduction_133 _
	(HappyAbsSyn40  happy_var_2)
	_
	 =  HappyAbsSyn51
		 (AbsVarg.EOperator happy_var_2
	)
happyReduction_133 _ _ _  = notHappyAtAll 

happyReduce_134 = happySpecReduce_1  56 happyReduction_134
happyReduction_134 (HappyAbsSyn5  happy_var_1)
	 =  HappyAbsSyn51
		 (AbsVarg.EInt happy_var_1
	)
happyReduction_134 _  = notHappyAtAll 

happyReduce_135 = happySpecReduce_1  56 happyReduction_135
happyReduction_135 (HappyAbsSyn6  happy_var_1)
	 =  HappyAbsSyn51
		 (AbsVarg.EReal happy_var_1
	)
happyReduction_135 _  = notHappyAtAll 

happyReduce_136 = happySpecReduce_1  56 happyReduction_136
happyReduction_136 (HappyAbsSyn7  happy_var_1)
	 =  HappyAbsSyn51
		 (AbsVarg.EChar happy_var_1
	)
happyReduction_136 _  = notHappyAtAll 

happyReduce_137 = happySpecReduce_1  56 happyReduction_137
happyReduction_137 (HappyAbsSyn4  happy_var_1)
	 =  HappyAbsSyn51
		 (AbsVarg.EString happy_var_1
	)
happyReduction_137 _  = notHappyAtAll 

happyReduce_138 = happySpecReduce_1  56 happyReduction_138
happyReduction_138 _
	 =  HappyAbsSyn51
		 (AbsVarg.EWild
	)

happyReduce_139 = happySpecReduce_3  56 happyReduction_139
happyReduction_139 _
	(HappyAbsSyn51  happy_var_2)
	_
	 =  HappyAbsSyn51
		 (happy_var_2
	)
happyReduction_139 _ _ _  = notHappyAtAll 

happyReduce_140 = happySpecReduce_1  57 happyReduction_140
happyReduction_140 (HappyAbsSyn51  happy_var_1)
	 =  HappyAbsSyn57
		 (AbsVarg.EListElem happy_var_1
	)
happyReduction_140 _  = notHappyAtAll 

happyReduce_141 = happySpecReduce_1  58 happyReduction_141
happyReduction_141 (HappyAbsSyn57  happy_var_1)
	 =  HappyAbsSyn58
		 ((:[]) happy_var_1
	)
happyReduction_141 _  = notHappyAtAll 

happyReduce_142 = happySpecReduce_3  58 happyReduction_142
happyReduction_142 (HappyAbsSyn58  happy_var_3)
	_
	(HappyAbsSyn57  happy_var_1)
	 =  HappyAbsSyn58
		 ((:) happy_var_1 happy_var_3
	)
happyReduction_142 _ _ _  = notHappyAtAll 

happyReduce_143 = happySpecReduce_2  59 happyReduction_143
happyReduction_143 (HappyAbsSyn51  happy_var_2)
	_
	 =  HappyAbsSyn51
		 (AbsVarg.ENeg happy_var_2
	)
happyReduction_143 _ _  = notHappyAtAll 

happyReduce_144 = happySpecReduce_2  59 happyReduction_144
happyReduction_144 (HappyAbsSyn51  happy_var_2)
	(HappyAbsSyn51  happy_var_1)
	 =  HappyAbsSyn51
		 (AbsVarg.EApply happy_var_1 happy_var_2
	)
happyReduction_144 _ _  = notHappyAtAll 

happyReduce_145 = happySpecReduce_1  59 happyReduction_145
happyReduction_145 (HappyAbsSyn51  happy_var_1)
	 =  HappyAbsSyn51
		 (happy_var_1
	)
happyReduction_145 _  = notHappyAtAll 

happyReduce_146 = happySpecReduce_3  60 happyReduction_146
happyReduction_146 (HappyAbsSyn51  happy_var_3)
	(HappyAbsSyn11  happy_var_2)
	(HappyAbsSyn51  happy_var_1)
	 =  HappyAbsSyn51
		 (AbsVarg.EOp happy_var_1 happy_var_2 happy_var_3
	)
happyReduction_146 _ _ _  = notHappyAtAll 

happyReduce_147 = happySpecReduce_3  60 happyReduction_147
happyReduction_147 (HappyAbsSyn51  happy_var_3)
	_
	(HappyAbsSyn51  happy_var_1)
	 =  HappyAbsSyn51
		 (AbsVarg.EEq happy_var_1 happy_var_3
	)
happyReduction_147 _ _ _  = notHappyAtAll 

happyReduce_148 = happySpecReduce_3  60 happyReduction_148
happyReduction_148 (HappyAbsSyn51  happy_var_3)
	_
	(HappyAbsSyn51  happy_var_1)
	 =  HappyAbsSyn51
		 (AbsVarg.ENeq happy_var_1 happy_var_3
	)
happyReduction_148 _ _ _  = notHappyAtAll 

happyReduce_149 = happySpecReduce_3  60 happyReduction_149
happyReduction_149 (HappyAbsSyn51  happy_var_3)
	_
	(HappyAbsSyn51  happy_var_1)
	 =  HappyAbsSyn51
		 (AbsVarg.EMod happy_var_1 happy_var_3
	)
happyReduction_149 _ _ _  = notHappyAtAll 

happyReduce_150 = happySpecReduce_2  60 happyReduction_150
happyReduction_150 (HappyAbsSyn51  happy_var_2)
	_
	 =  HappyAbsSyn51
		 (AbsVarg.ENot happy_var_2
	)
happyReduction_150 _ _  = notHappyAtAll 

happyReduce_151 = happySpecReduce_3  60 happyReduction_151
happyReduction_151 (HappyAbsSyn51  happy_var_3)
	_
	(HappyAbsSyn51  happy_var_1)
	 =  HappyAbsSyn51
		 (AbsVarg.EOr happy_var_1 happy_var_3
	)
happyReduction_151 _ _ _  = notHappyAtAll 

happyReduce_152 = happySpecReduce_3  60 happyReduction_152
happyReduction_152 (HappyAbsSyn51  happy_var_3)
	_
	(HappyAbsSyn51  happy_var_1)
	 =  HappyAbsSyn51
		 (AbsVarg.EAnd happy_var_1 happy_var_3
	)
happyReduction_152 _ _ _  = notHappyAtAll 

happyReduce_153 = happySpecReduce_3  60 happyReduction_153
happyReduction_153 (HappyAbsSyn51  happy_var_3)
	_
	(HappyAbsSyn51  happy_var_1)
	 =  HappyAbsSyn51
		 (AbsVarg.ELt happy_var_1 happy_var_3
	)
happyReduction_153 _ _ _  = notHappyAtAll 

happyReduce_154 = happySpecReduce_3  60 happyReduction_154
happyReduction_154 (HappyAbsSyn51  happy_var_3)
	_
	(HappyAbsSyn51  happy_var_1)
	 =  HappyAbsSyn51
		 (AbsVarg.EGt happy_var_1 happy_var_3
	)
happyReduction_154 _ _ _  = notHappyAtAll 

happyReduce_155 = happySpecReduce_3  60 happyReduction_155
happyReduction_155 (HappyAbsSyn51  happy_var_3)
	_
	(HappyAbsSyn51  happy_var_1)
	 =  HappyAbsSyn51
		 (AbsVarg.ELeq happy_var_1 happy_var_3
	)
happyReduction_155 _ _ _  = notHappyAtAll 

happyReduce_156 = happySpecReduce_3  60 happyReduction_156
happyReduction_156 (HappyAbsSyn51  happy_var_3)
	_
	(HappyAbsSyn51  happy_var_1)
	 =  HappyAbsSyn51
		 (AbsVarg.EGeq happy_var_1 happy_var_3
	)
happyReduction_156 _ _ _  = notHappyAtAll 

happyReduce_157 = happySpecReduce_1  60 happyReduction_157
happyReduction_157 (HappyAbsSyn51  happy_var_1)
	 =  HappyAbsSyn51
		 (happy_var_1
	)
happyReduction_157 _  = notHappyAtAll 

happyReduce_158 = happySpecReduce_3  61 happyReduction_158
happyReduction_158 (HappyAbsSyn51  happy_var_3)
	_
	(HappyAbsSyn51  happy_var_1)
	 =  HappyAbsSyn51
		 (AbsVarg.EAdd happy_var_1 happy_var_3
	)
happyReduction_158 _ _ _  = notHappyAtAll 

happyReduce_159 = happySpecReduce_3  61 happyReduction_159
happyReduction_159 (HappyAbsSyn51  happy_var_3)
	_
	(HappyAbsSyn51  happy_var_1)
	 =  HappyAbsSyn51
		 (AbsVarg.ESub happy_var_1 happy_var_3
	)
happyReduction_159 _ _ _  = notHappyAtAll 

happyReduce_160 = happySpecReduce_1  61 happyReduction_160
happyReduction_160 (HappyAbsSyn51  happy_var_1)
	 =  HappyAbsSyn51
		 (happy_var_1
	)
happyReduction_160 _  = notHappyAtAll 

happyReduce_161 = happySpecReduce_3  62 happyReduction_161
happyReduction_161 (HappyAbsSyn51  happy_var_3)
	_
	(HappyAbsSyn51  happy_var_1)
	 =  HappyAbsSyn51
		 (AbsVarg.EMul happy_var_1 happy_var_3
	)
happyReduction_161 _ _ _  = notHappyAtAll 

happyReduce_162 = happySpecReduce_3  62 happyReduction_162
happyReduction_162 (HappyAbsSyn51  happy_var_3)
	_
	(HappyAbsSyn51  happy_var_1)
	 =  HappyAbsSyn51
		 (AbsVarg.EDiv happy_var_1 happy_var_3
	)
happyReduction_162 _ _ _  = notHappyAtAll 

happyReduce_163 = happySpecReduce_1  62 happyReduction_163
happyReduction_163 (HappyAbsSyn51  happy_var_1)
	 =  HappyAbsSyn51
		 (happy_var_1
	)
happyReduction_163 _  = notHappyAtAll 

happyReduce_164 = happySpecReduce_3  63 happyReduction_164
happyReduction_164 (HappyAbsSyn51  happy_var_3)
	_
	(HappyAbsSyn51  happy_var_1)
	 =  HappyAbsSyn51
		 (AbsVarg.EPow happy_var_1 happy_var_3
	)
happyReduction_164 _ _ _  = notHappyAtAll 

happyReduce_165 = happySpecReduce_3  63 happyReduction_165
happyReduction_165 (HappyAbsSyn51  happy_var_3)
	_
	(HappyAbsSyn51  happy_var_1)
	 =  HappyAbsSyn51
		 (AbsVarg.ECompose happy_var_1 happy_var_3
	)
happyReduction_165 _ _ _  = notHappyAtAll 

happyReduce_166 = happySpecReduce_1  63 happyReduction_166
happyReduction_166 (HappyAbsSyn51  happy_var_1)
	 =  HappyAbsSyn51
		 (happy_var_1
	)
happyReduction_166 _  = notHappyAtAll 

happyReduce_167 = happySpecReduce_1  64 happyReduction_167
happyReduction_167 _
	 =  HappyAbsSyn64
		 (AbsVarg.ETrue
	)

happyReduce_168 = happySpecReduce_1  64 happyReduction_168
happyReduction_168 _
	 =  HappyAbsSyn64
		 (AbsVarg.EFalse
	)

happyNewToken action sts stk [] =
	action 136 136 notHappyAtAll (HappyState action) sts stk []

happyNewToken action sts stk (tk:tks) =
	let cont i = action i i tk (HappyState action) sts stk tks in
	case tk of {
	PT _ (TS _ 1) -> cont 65;
	PT _ (TS _ 2) -> cont 66;
	PT _ (TS _ 3) -> cont 67;
	PT _ (TS _ 4) -> cont 68;
	PT _ (TS _ 5) -> cont 69;
	PT _ (TS _ 6) -> cont 70;
	PT _ (TS _ 7) -> cont 71;
	PT _ (TS _ 8) -> cont 72;
	PT _ (TS _ 9) -> cont 73;
	PT _ (TS _ 10) -> cont 74;
	PT _ (TS _ 11) -> cont 75;
	PT _ (TS _ 12) -> cont 76;
	PT _ (TS _ 13) -> cont 77;
	PT _ (TS _ 14) -> cont 78;
	PT _ (TS _ 15) -> cont 79;
	PT _ (TS _ 16) -> cont 80;
	PT _ (TS _ 17) -> cont 81;
	PT _ (TS _ 18) -> cont 82;
	PT _ (TS _ 19) -> cont 83;
	PT _ (TS _ 20) -> cont 84;
	PT _ (TS _ 21) -> cont 85;
	PT _ (TS _ 22) -> cont 86;
	PT _ (TS _ 23) -> cont 87;
	PT _ (TS _ 24) -> cont 88;
	PT _ (TS _ 25) -> cont 89;
	PT _ (TS _ 26) -> cont 90;
	PT _ (TS _ 27) -> cont 91;
	PT _ (TS _ 28) -> cont 92;
	PT _ (TS _ 29) -> cont 93;
	PT _ (TS _ 30) -> cont 94;
	PT _ (TS _ 31) -> cont 95;
	PT _ (TS _ 32) -> cont 96;
	PT _ (TS _ 33) -> cont 97;
	PT _ (TS _ 34) -> cont 98;
	PT _ (TS _ 35) -> cont 99;
	PT _ (TS _ 36) -> cont 100;
	PT _ (TS _ 37) -> cont 101;
	PT _ (TS _ 38) -> cont 102;
	PT _ (TS _ 39) -> cont 103;
	PT _ (TS _ 40) -> cont 104;
	PT _ (TS _ 41) -> cont 105;
	PT _ (TS _ 42) -> cont 106;
	PT _ (TS _ 43) -> cont 107;
	PT _ (TS _ 44) -> cont 108;
	PT _ (TS _ 45) -> cont 109;
	PT _ (TS _ 46) -> cont 110;
	PT _ (TS _ 47) -> cont 111;
	PT _ (TS _ 48) -> cont 112;
	PT _ (TS _ 49) -> cont 113;
	PT _ (TS _ 50) -> cont 114;
	PT _ (TS _ 51) -> cont 115;
	PT _ (TS _ 52) -> cont 116;
	PT _ (TS _ 53) -> cont 117;
	PT _ (TS _ 54) -> cont 118;
	PT _ (TS _ 55) -> cont 119;
	PT _ (TS _ 56) -> cont 120;
	PT _ (TS _ 57) -> cont 121;
	PT _ (TS _ 58) -> cont 122;
	PT _ (TS _ 59) -> cont 123;
	PT _ (TS _ 60) -> cont 124;
	PT _ (TS _ 61) -> cont 125;
	PT _ (TS _ 62) -> cont 126;
	PT _ (TS _ 63) -> cont 127;
	PT _ (TL happy_dollar_dollar) -> cont 128;
	PT _ (TI happy_dollar_dollar) -> cont 129;
	PT _ (TD happy_dollar_dollar) -> cont 130;
	PT _ (TC happy_dollar_dollar) -> cont 131;
	PT _ (T_UIdent happy_dollar_dollar) -> cont 132;
	PT _ (T_LIdent happy_dollar_dollar) -> cont 133;
	PT _ (T_MFun happy_dollar_dollar) -> cont 134;
	PT _ (T_Op happy_dollar_dollar) -> cont 135;
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
 happySomeParser = happyThen (happyParse action_0 tks) (\x -> case x of {HappyAbsSyn12 z -> happyReturn z; _other -> notHappyAtAll })

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
