module Interpreter where

import ErrM
import LexVarg
import AbsVarg
import ParVarg
import PrintVarg
import LayoutVarg

import Control.Monad.State
import Control.Monad.Writer
import Control.Monad.Reader
import Control.Monad.Except
import Control.Monad.Identity

import qualified Data.Map as M
import Data.List

newtype ParseException = ParseException{reason :: String} deriving (Eq, Ord, Show)
type ParseMonad = Either ParseException

type InterpreterState = Integer
type Runtime = Integer
type Log = [String]

type InterpreterMonad a = WriterT Log (ReaderT Runtime (StateT InterpreterState (ExceptT ParseException Identity))) a

runLexer :: String -> InterpreterMonad String
runLexer s = let ts = lexer s in case runParser ts of
  Bad s -> throwError $ ParseException s
  Ok tree -> return $ "\n [Abstract Syntax]\n\n" ++ show tree ++ "\n\n [Linearized Syntax]\n\n" ++ printTree tree
  where lexer = resolveLayout True . tokens

runLexerState :: String -> ParseMonad (String, Log)
runLexerState s = runIdentity $ runExceptT $ evalStateT (runReaderT (runWriterT $ runLexer s) 0) 0

interpret :: String -> String
interpret text = concat $ intersperse "\n" log
  where
    (Right (interpreterResult, log)) = runLexerState text `catchError` (\err -> return $ ("", [show err]))

