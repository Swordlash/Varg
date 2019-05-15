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
        Bad s -> throwException $ "Tokens: " ++ show ts ++ "\n\nParse failed with " ++ s
        Ok tree -> do
          liftIO $ putStr $ "[[Abstract syntax]]\n\n" ++ show tree ++ "\n\n"
          pure tree
  where
    lexer = resolveLayout True . tokens

loadImports :: [Abs.ImportDef] -> StateT (S.Set String) VargMonad [Abs.ClassDef]
loadImports [] = pure []
loadImports (Abs.Import modulename:t) = do
  stat <- get
  let isloaded = S.member modulename stat
  if isloaded
    then loadImports t
    else do
      liftIO $ putStrLn $ "-------------------- Reading module " ++ modulename ++ "--------------------"
      _module <-
        liftIO $
        readFile
          (map
             (\case
                '.' -> '/'
                x -> x)
             modulename ++
           ".vg")
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