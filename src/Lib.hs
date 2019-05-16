module Lib where

import General
import Interpreter
import PreprocessingState
import System.Environment
import System.IO

runInterpreter' :: String -> IO (Either VargException String)
runInterpreter' filename = runExceptT $ interpret filename

runInterpreter :: IO ()
runInterpreter = do
  getArgs >>= mapM_ parse
  program >>= runInterpreter' >>= \case
    Left err -> printErr err
    Right res -> logStderr "\n[[Result]]\n\n" >> putStrLn res