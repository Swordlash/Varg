module Preprocessing where

import           PreprocessingState
import           Types

import           ErrM
import           LayoutVarg
import           LexVarg
import           ParVarg
import           PrintVarg

import           Data.Maybe

import qualified AbsVarg                as Abs
import qualified Data.Map               as M
import qualified Data.Set               as S

import           ClassHierarchyBuilder
import           ClassStubPreprocessing

------------------------------------ running Alex and Happy ----------------------------------------------
runLexer :: String -> PreprocessMonad Abs.ProgramDef
runLexer s =
  let ts = lexer s
   in case pProgramDef ts of
        Bad s -> throwError $ VargException $ "Tokens: " ++ show ts ++ "\n\nParse failed with " ++ s
        Ok tree -> do
          tell $ "[[Abstract syntax]]\n\n" ++ show tree ++ "\n\n"
          pure tree
  where
    lexer = resolveLayout True . tokens

runLexerState :: String -> VargExceptionMonad (Abs.ProgramDef, Log)
runLexerState s =
  runIdentity $
  runExceptT $ runWriterT (evalStateT (runReaderT (runLexer s) emptyPreprocessRuntime) emptyPreprocessState)

preprocessClasses :: String -> VargExceptionMonad (ClassHierarchy, Log)
preprocessClasses programText = do
  (Abs.Program _ cldefs, l1) <- runLexerState programText
  (PreprocessState stubs _ _, l2) <- runReadClassHeaders cldefs
  (HierarchyState _ hier _ _, l3) <- runBuildClassHierarchy stubs cldefs
  return (hier, l1 ++ l2 ++ l3)
