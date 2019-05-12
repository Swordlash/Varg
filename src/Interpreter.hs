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

nats = 0 : [n + 1 | n <- nats]

argGen = map (\n -> "_arg" ++ show n) nats

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
              --logs ++
              --"[[Definitions]]\n\n" ++
              --intercalate "\n" (show <$> S.toList classes) ++
              --"\n[[Interpreter log]] \n\n" ++ interplog ++ "\n[[Result]] \n\n" ++
              show retval)
        (return . show)

runInterpreter :: (Type, Type) -> ClassHierarchy -> VargExceptionMonad (Instance, Log)
runInterpreter (main, list) hier =
  case lookupFunctionFromType "main" main of
    Left a -> throwError a
    Right f ->
      runIdentity $
      runExceptT $
      runWriterT $
      evalStateT (runReaderT (interpretExpression $ supplyArgs $ functionBody f) (emptyEnvironment list)) hier

emptyEnvironment :: Type -> Environment
emptyEnvironment listtype = M.insert "args" (emptyArgs listtype) M.empty

supplyArgs :: Expr -> Expr
supplyArgs main = EApply main (EVar "args")

emptyArgs :: Type -> Instance
emptyArgs listtype = TypeInstance listtype "Empty" [Template "List" [Primitive "Char"]] []

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
    --(TypeInstance {}, _) -> interpretExpression $ EApply (EMember (EInterpreted p1) name) (EInterpreted p2)
      -- FIXME: Add support for instance Num
    _ ->
      throwError $
      VargException $ "You want to " ++ name ++ " numbers " ++ show p1 ++ " and " ++ show p2 ++ ". Are they though?"

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
    EThis -> do
      env <- ask
      case M.lookup "this" env of
        Just inst -> pure inst
        Nothing -> throwError $ VargException "Referencing this from a static context"
    ESuper -> do
      env <- ask
      case M.lookup "super" env of
        Just inst -> pure inst
        Nothing -> throwError $ VargException "Referencing super from a static context"
    EVar name -> do
      inst <- asks (M.lookup name)
      case inst of
        Nothing -> throwError $ VargException $ name ++ "? I have never seen this man in my life!"
        Just val -> return val
    f@(ELambda _ int out _) -> do
      env <- ask
      let lam = FunctionInstance (Function [] int out f) env
      return lam
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
        FunctionInstance Function {functionBody = ELambda argname _ _ body} env ->
          local (\_ -> M.insert argname argval env) (interpretExpression body)
        _ ->
          throwError $
          VargException $
          "One does not simply apply argument to a non-function. Functor: " ++ show fun ++ ", argument: " ++ show arg
    ELet name expr1@(ELambda _ int out _) _ expr2 -- recursive def
     -> do
      env <- ask
      let fun = FunctionInstance (Function [] int out expr1) (M.insert name fun env)
      local (M.insert name fun) (interpretExpression expr2)
    ELet name expr1 _ expr2 -- TODO: try to actually care about types
     -> do
      p1 <- interpretExpression expr1
      local (M.insert name p1) (interpretExpression expr2)
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
    EEq expr1 expr2 -> do
      p1 <- interpretExpression expr1
      p2 <- interpretExpression expr2
      return $ BoolInstance (p1 == p2)
    ENeq expr1 expr2 -> do
      p1 <- interpretExpression expr1
      p2 <- interpretExpression expr2
      return $ BoolInstance $ p1 /= p2
    ECons expr1 expr2 -> interpretExpression $ EApply (EMember expr2 ":") expr1
    EMember (EClass tname) name -> do
      hier <- get
      t <- lookupTypeFromClassHierarchy tname hier
      Variant _ fieldsEx <- lookupVariantFromType name t
      let argstypes = zip argGen (map (functionOutputType . snd) fieldsEx)
      let nargs = map (EVar . fst) argstypes
      interpretExpression $
        fst $
        foldr
          (\(narg, typ) (expr, typename) ->
             let ftype = ConcreteType "Function" [Exact typ, Exact typename]
              in (ELambda narg typ ftype expr, ftype))
          (EConstructor tname name nargs, ConcreteType tname [])
          argstypes
    EMember expr name -> do
      pexpr <- interpretExpression expr
      case pexpr of
        obj@TypeInstance {baseType = t, fields = f} ->
          case lookup name f of
            Just fld -> pure fld
            Nothing ->
              case M.lookup name (typeMembers t) of
                Just (Function _ _ _ body) -> local (M.insert "this" pexpr) (interpretExpression body)
                Nothing -> throwError $ VargException $ "Call to nonexistent field " ++ name ++ " of class " ++ show obj
        _ -> throwError $ VargException $ "Call to member `" ++ name ++ "` on primitive type " ++ show pexpr
    EConstructor tname var flds -> do
      hier <- get
      typ <- lookupTypeFromClassHierarchy tname hier
      Variant _ fieldsEx <- lookupVariantFromType var typ
      vals <- mapM interpretExpression flds
      let flds = zip (map fst fieldsEx) vals
      return $ TypeInstance typ var [] flds
    _ -> throwError $ VargException $ "Cannot interpret expr " ++ show expr
