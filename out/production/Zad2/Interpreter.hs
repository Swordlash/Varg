module Interpreter where

import ErrM
import LexVarg
import AbsVarg hiding (Type)
import ParVarg
import PrintVarg
import LayoutVarg
import Types

import Control.Monad.State
import Control.Monad.Writer
import Control.Monad.Reader
import Control.Monad.Except
import Control.Monad.Identity

import qualified Data.Set as S
import Data.List

newtype ParseException = ParseException{reason :: String} deriving (Eq, Ord, Show)
type ParseMonad = Either ParseException

newtype InterpreterState = InterpreterState
  {
    classHierarchy :: S.Set Type
  }

type Runtime = Integer
type Log = [String]

type InterpreterMonad a = WriterT Log (ReaderT Runtime (StateT InterpreterState (ExceptT ParseException Identity))) a

runLexer :: String -> InterpreterMonad ProgramDef
runLexer s = let ts = lexer s in case pProgramDef ts of
  Bad s -> throwError $ ParseException s
  Ok tree -> return tree
  where lexer = resolveLayout True . tokens

runLexerState :: String -> ParseMonad (ProgramDef, Log)
runLexerState s = runIdentity $ runExceptT $ evalStateT (runReaderT (runWriterT $ runLexer s) 0) 0

buildClassHierarchy :: [ClassDef] -> InterpreterMonad ()
buildClassHierarchy [] = pure ()
buildClassHierarchy (cl:t) = do
  newcl <- parseClass cl
  if S.member newcl get then throwError $ ParseException "Multiple definition of class " ++ qualifiedTypeName newcl else do
    puts (S.insert newcl)
    buildClassHierarchy t
    return ()


parseClass :: ClassDef -> InterpreterMonad Type
parseClass classDef = case classDef of
  StructDefinition _ name _ ->
    return $ Type voidType [] [emptySupertype name] [["Void", "_t0"]] name [] 0 [] S.empty
  ClassDefinition _ name impl deriv _ ->
    return $ Type voidType [] [emptySupertype name] [["Void", "_t0"]] name [] 0 [] S.empty
  TemplateDefinition _ name params impl deriv _ ->
    return $ Type voidType [] [emptySupertype name] [["Void", "_t0"]] name [] 0 [] S.empty

runClassHierarchy :: (ProgramDef, Log) -> ParseMonad (InterpreterState, Log)
runClassHierarchy ((Program _ cldefs), log) =
  (state, newlog) <- runIdentity $ runExceptT $ execStateT (runReaderT (runWriterT $ buildClassHierarchy cldefs) 0) S.empty
  return $ (state, log ++ newlog)