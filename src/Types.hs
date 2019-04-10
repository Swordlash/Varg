module Types where

import qualified AbsVarg as AV
import qualified Data.Set as S
import Data.List (intercalate)

data TypeParamConstraint = Any | Super Type | Deriving Type deriving Eq

type TypeName = String
type MemberName = String

{-
isSuperType :: ConcreteType -> ConcreteType -> Bool
isSuperType _ _ = True

isDerivingType :: ConcreteType -> ConcreteType -> Bool
isDerivingType _ _ = True

satisfiesConstraint :: ConcreteType -> TypeParamConstraint -> Bool
satisfiesConstraint typ constraint = case constraint of
  Any -> True
  Super underclass -> True
  Deriving superclass -> True
-}


data Function = Function
  {
    qualifiedFunName :: MemberName,
    functionInputType :: Type,
    functionOutputType :: Type,
    functionBody :: AV.Expr
  } deriving Eq

instance Show Function where
  show (Function name int outt _) = "function " ++ name ++ " : " ++ show int ++" -> "++ show outt

instance Ord Function where
  f1 <= f2 = qualifiedFunName f1 <= qualifiedFunName f2



data Type = VoidType | Type
  {
    supertype :: Type,
    supertypeParamBindings :: [TypeName],
    implementing :: [Type],
    implementingParamBindings :: [[TypeName]],
    qualifiedTypeName :: TypeName,
    typeVariants :: [TypeName],
    typeParamCount :: Int,
    typeParamConstraints :: [[TypeParamConstraint]],
    typeMembers :: S.Set Function
  } deriving Eq

genParams :: Int -> [String]
genParams n = map (\n -> "_t"++show n) [0..(n-1)]

instance Show Type where
  show VoidType = "Void"
  show t = qualifiedTypeName t ++ " " ++ (unwords $ genParams $ typeParamCount t) ++ deriv ++ impl where
      deriv = if supertype t == VoidType then "" else
        " deriving " ++ qualifiedTypeName (supertype t) ++ unwords (supertypeParamBindings t)
      impl = if null (implementing t) then "" else
        " implementing " ++ intercalate ", " ((\(t, binds) -> show t ++ " " ++ unwords binds) <$> zip (implementing t) (implementingParamBindings t))

emptySupertype :: TypeName -> Type
emptySupertype name = if name == "Function" then VoidType else
  Type VoidType [] [] [] "Function" [] 2 [] S.empty -- TODO: add type member .call

instance Ord Type where
  t1 <= t2 = qualifiedTypeName t1 <= qualifiedTypeName t2

data ConcreteType = Void | PrimBool | PrimInt | PrimReal | PrimChar | ConcreteType
  {
    concreteTypeShape :: Type,
    concreteTypeParams :: [ConcreteType]
  }

