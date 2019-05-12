{-# LANGUAGE FlexibleContexts #-}

module Interpreter where

import           Control.Monad.Except (catchError)
import           Instances
import           InterpreterState
import           Preprocessing
import           PreprocessingState

import           Data.Fixed           (mod')
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
            main <- lookupTypeFromClassHierarchy "Main" classes
            list <- lookupTypeFromClassHierarchy "List" classes
            (retval, interplog) <- runInterpreter (main, list) classes
            return $
              logs ++
              "[[Definitions]]\n\n" ++
              intercalate "\n" (show <$> S.toList classes) ++
              "\n[[Interpreter log]] \n\n" ++ interplog ++ "\n[[Result]] \n\n" ++ show retval)
        (return . show)

runInterpreter :: (Type, Type) -> ClassHierarchy -> VargExceptionMonad (Instance, Log)
runInterpreter (main, list) hier =
  case lookupFunctionFromType "main" main of
    Left a -> throwError a
    Right f ->
      runIdentity $
      runExceptT $
      runWriterT $
      evalStateT
        (runReaderT (interpretExpression $ supplyArgs $ functionBody f) (InterpreterRuntime $ emptyEnvironment list))
        (InterpreterState hier)

emptyEnvironment :: Type -> Environment
emptyEnvironment listtype = M.insert "args" (emptyArgs listtype) M.empty

supplyArgs :: Expr -> Expr
supplyArgs main = EApply main (EVar "args")

emptyArgs :: Type -> Instance
emptyArgs listtype = TypeInstance listtype "Empty" [Template "List" [Primitive "Char"]] [] M.empty

interpretBinaryArithmetic ::
     String
  -> Expr
  -> Expr
  -> (Integer -> Integer -> InterpreterMonad Instance)
  -> (Double -> Double -> InterpreterMonad Instance)
  -> (Bool -> Bool -> InterpreterMonad Instance)
  -> InterpreterMonad Instance
interpretBinaryArithmetic name expr1 expr2 intfun dblfun boolfun = do
  p1 <- interpretExpression expr1
  p2 <- interpretExpression expr2
  case (p1, p2) of
    (IntInstance v1, IntInstance v2) -> intfun v1 v2
    (DoubleInstance v1, DoubleInstance v2) -> dblfun v1 v2
    (BoolInstance v1, BoolInstance v2) -> boolfun v1 v2
    (TypeInstance {}, _) -> interpretExpression $ EApply (EMember (EInterpreted p1) name) (EInterpreted p2)
    _ ->
      throwError $ VargException $ "Roll safe, think about computing " ++ show expr1 ++ " " ++ name ++ " " ++ show expr2

ifn f v1 v2 = pure $ IntInstance $ f v1 v2

dfn f v1 v2 = pure $ DoubleInstance $ f v1 v2

bfn f b1 b2 = pure $ BoolInstance $ f b1 b2

efn str _ _ = throwError $ VargException str

interpretExpression :: Expr -> InterpreterMonad Instance
interpretExpression expr =
  case expr of
    EInterpreted inst -> pure inst
    EInt val -> pure $ IntInstance val
    EDouble val -> pure $ DoubleInstance val
    EBool val -> pure $ BoolInstance val
    EChar val -> pure $ CharInstance val
    EVar name -> do
      inst <- asks (M.lookup name . environment)
      case inst of
        Nothing -> throwError $ VargException $ name ++ "? I have never seen this man in my life!"
        Just val -> return val
    ELambda {} -> pure $ FunctionInstance expr
    EIfThenElse ife thene elsee -> do
      res <- interpretExpression ife
      case res of
        BoolInstance True -> interpretExpression thene
        BoolInstance False -> interpretExpression elsee
        _ -> throwError $ VargException $ "Usage of invalid type (" ++ typeof res ++ ") in if clause"
    EApply fun arg -> do
      funval <- interpretExpression fun
      argval <- interpretExpression arg
      case funval of
        FunctionInstance (ELambda argname _ _ body) ->
          local (InterpreterRuntime . M.insert argname argval . environment) (interpretExpression body)
        _ ->
          throwError $
          VargException $
          "One does not simply apply argument to a non-function. Functor: " ++ show fun ++ ", argument: " ++ show arg
    ELet name expr1 expr2 -> do
      p1 <- interpretExpression expr1
      local (InterpreterRuntime . M.insert name p1 . environment) (interpretExpression expr2)
    ENot expr -> do
      p <- interpretExpression expr
      case p of
        BoolInstance val -> pure $ BoolInstance $ not val
        _ -> throwError $ VargException $ "You can only negate bools, change my mind\nTrying to negate " ++ show expr
    EMod expr1 expr2 ->
      interpretBinaryArithmetic "mod" expr1 expr2 (ifn mod) (dfn mod') (efn "Roll safe, think about moduling booleans")
    EAdd expr1 expr2 ->
      interpretBinaryArithmetic "+" expr1 expr2 (ifn (+)) (dfn (+)) (efn "Roll safe, think about adding booleans")
    ESub expr1 expr2 ->
      interpretBinaryArithmetic "-" expr1 expr2 (ifn (-)) (dfn (-)) (efn "Roll safe, think about subtracting booleans")
    EOr expr1 expr2 ->
      interpretBinaryArithmetic
        "||"
        expr1
        expr2
        (efn "One does not simply alternate integers")
        (efn "One does not simply alternate doubles")
        (bfn (||))
    EAnd expr1 expr2 ->
      interpretBinaryArithmetic
        "&&"
        expr1
        expr2
        (efn "One does not simply conjunct integers")
        (efn "One does not simply conjunct doubles")
        (bfn (&&))
    EMul expr1 expr2 ->
      interpretBinaryArithmetic "*" expr1 expr2 (ifn (*)) (dfn (*)) (efn "Roll safe, think about multiplying booleans")
    EDiv expr1 expr2 ->
      interpretBinaryArithmetic "/" expr1 expr2 (ifn quot) (dfn (/)) (efn "Roll safe, think about dividing booleans")
    EPow expr1 expr2 -> interpretBinaryArithmetic "^" expr1 expr2 (ifn (^)) (dfn (**)) (bfn (/=))
    ELt expr1 expr2 ->
      interpretBinaryArithmetic "<" expr1 expr2 (bfn (<)) (bfn (<)) (efn "Roll safe, think about comparing booleans")
    EGt expr1 expr2 ->
      interpretBinaryArithmetic "<" expr1 expr2 (bfn (>)) (bfn (>)) (efn "Roll safe, think about comparing booleans")
    ELeq expr1 expr2 ->
      interpretBinaryArithmetic "<=" expr1 expr2 (bfn (<=)) (bfn (<=)) (efn "Roll safe, think about comparing booleans")
    EGeq expr1 expr2 ->
      interpretBinaryArithmetic ">=" expr1 expr2 (bfn (>=)) (bfn (>=)) (efn "Roll safe, think about comparing booleans")
    EEq expr1 expr2 -> interpretBinaryArithmetic "==" expr1 expr2 (bfn (==)) (bfn (==)) (bfn (==))
    _ -> throwError $ VargException $ "Cannot interpret expr " ++ show expr
