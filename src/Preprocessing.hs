{-  Preprocessing module
    Recursive bnfc-parsing of imports -}
module Preprocessing where

import PreprocessingState
import Types

import ErrM
import LayoutVarg
import LexVarg
import ParVarg
import PrintVarg

import Data.Maybe

import qualified AbsVarg as Abs
import qualified Data.Map as M
import qualified Data.Set as S

import ClassHierarchyBuilder
import ClassStubPreprocessing

------------------------------------ running Alex and Happy ----------------------------------------------
runLexer :: String -> StateT (S.Set String) VargMonad Abs.ProgramDef
runLexer s =
  let ts = lexer s
   in case pProgramDef ts of
        Bad s -> throwException $ "\nParse failed with " ++ s ++ "\n"
        Ok tree -> do
          liftIO $ logStderr $ "[[Abstract syntax]]\n\n" ++ show tree ++ "\n\n"
          pure tree
  where
    lexer = resolveLayout True . tokens

f =
  \case
    '.' -> '/'
    x -> x

loadImports :: [Abs.ImportDef] -> StateT (S.Set String) VargMonad [Abs.ClassDef]
loadImports [] = pure []
loadImports (Abs.Import modulename:t) = do
  stat <- get
  let isloaded = S.member modulename stat
  if isloaded
    then loadImports t
    else do
      liftIO $ logStderr $ "-------------------- Reading module " ++ modulename ++ "--------------------\n"
      _module <- liftIO $ readFile (map f modulename ++ ".vg")
      Abs.Program imports cldefs <- runLexer _module
      put $ S.insert modulename stat
      rest <- loadImports (t ++ imports)
      return $ cldefs ++ rest

preprocessClasses :: String -> VargMonad ClassHierarchy
preprocessClasses programName = do
  cldefs <- evalStateT (loadImports [Abs.Import programName]) S.empty
  PreprocessState stubs _ _ <- runReadClassHeaders cldefs
  HierarchyState _ hier _ _ <- runBuildClassHierarchy stubs cldefs
  return hier