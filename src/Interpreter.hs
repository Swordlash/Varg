module Interpreter where

import           Control.Monad.Except (catchError)
import           InterpreterState
import           Preprocessing

import           Data.List
import qualified Data.Map             as M
import qualified Data.Set             as S
import           Types

interpret :: String -> String
interpret text = interpreterResult
  where
    Right interpreterResult =
      catchError
        (do (classes, logs) <- preprocessClasses text
            return $ logs ++ "[[Definitions]]\n\n" ++ intercalate "\n" (show <$> S.toList classes))
        (return . show)
