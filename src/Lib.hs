module Lib where

import           Interpreter
import           PreprocessingState
import           System.Environment
import           System.IO

usage :: String
usage = "Invalid arguments given. Usage: varg <program>"

runInterpreter' :: String -> IO (Either VargException String)
runInterpreter' filename = runExceptT $ interpret filename

runInterpreter :: IO ()
runInterpreter = do
  args <- getArgs
  contents <- getContents
  result <-
    case args of
      []         -> runInterpreter' "Main"
      [filename] -> runInterpreter' filename
      _          -> return $ Right usage
  putStrLn $
    case result of
      Left err  -> show err
      Right res -> "\n[[Result]]\n\n" ++ res
