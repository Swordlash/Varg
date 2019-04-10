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

emptyState :: InterpreterState
emptyState = InterpreterState S.empty

type Runtime = Integer
type Log = [String]

type InterpreterMonad a = ReaderT Runtime (StateT InterpreterState (WriterT Log (ExceptT ParseException Identity))) a

runLexer :: String -> InterpreterMonad ProgramDef
runLexer s = let ts = lexer s in case pProgramDef ts of
  Bad s -> throwError $ ParseException s
  Ok tree -> return tree
  where lexer = resolveLayout True . tokens

runLexerState :: String -> ParseMonad (ProgramDef, Log)
runLexerState s = runIdentity $ runExceptT $ runWriterT (evalStateT (runReaderT (runLexer s) 0) emptyState)

buildClassHierarchy :: [ClassDef] -> InterpreterMonad ()
buildClassHierarchy [] = pure ()
buildClassHierarchy (cl:t) = do
  newcl <- parseClass cl
  hierarchy <- get
  if S.member newcl (classHierarchy hierarchy) then throwError $ ParseException ("Multiple definition of class " ++ qualifiedTypeName newcl) else do
    modify (\s -> InterpreterState $ S.insert newcl $ classHierarchy s)
    buildClassHierarchy t
    return ()


parseClass :: ClassDef -> InterpreterMonad Type
parseClass classDef = case classDef of
  StructDefinition _ (UIdent name) _ ->
    return $ Type VoidType [] [emptySupertype name] [["Void", "_t0"]] name [] 0 [] S.empty
  ClassDefinition _ (UIdent name) impl deriv _ ->
    return $ Type VoidType [] [emptySupertype name] [["Void", "_t0"]] name [] 0 [] S.empty
  TemplateDefinition _ (UIdent name) params impl deriv _ ->
    return $ Type VoidType [] [emptySupertype name] [["Void", "_t0"]] name [] 0 [] S.empty

runClassHierarchy :: ProgramDef -> ParseMonad (InterpreterState, Log)
runClassHierarchy (Program _ cldefs) =
  runIdentity $ runExceptT $ runWriterT (execStateT (runReaderT (buildClassHierarchy cldefs) 0) emptyState)

interpret :: String -> String
interpret text = interpreterResult
  where
    Right interpreterResult = catchError (do
      (progDef, _) <- runLexerState text
      (InterpreterState hier, _) <- runClassHierarchy progDef
      return $ "[[Definitions]]\n\n" ++ intercalate "\n" (show <$> S.toList hier)
      ) (\err -> return $ "Error: " ++ show err)