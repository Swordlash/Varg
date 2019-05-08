module Expressions where

import           InterpreterState

import qualified AbsVarg          as Abs
import qualified Data.Map         as M
import qualified Data.Set         as S

parseExpression :: LookupFunction -> Abs.Expr -> HierarchyMonad Expr
parseExpression lookupFun expr =
  case expr of
    _ -> pure ENative
