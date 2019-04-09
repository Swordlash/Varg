module Lib where

import System.IO
import Interpreter

runInterpreter :: IO ()
runInterpreter = do
   prog <- readFile "Main.vg"
   let result = interpret prog
   putStrLn result


