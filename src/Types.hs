module Types where

import qualified AbsVarg   as AV
import           Data.List (intercalate)
import qualified Data.Set  as S

type TypeName = String

type MemberName = String

data TypeParamConstraint
  = Any
  | SuperClass TypeName
  | SuperTemplate TypeName
                  [TypeParamConstraint]
  | DerivingClass TypeName
  | DerivingTemplate TypeName
                     [TypeParamConstraint]
  deriving (Eq)

data TypeModifier
  = ModuleType
  | InterfaceType
  | SealedType

data MethodModifier
  = StaticMethod
  | InternalMethod
  | ImplementMethod
  | FinalMethod
  | UniqueMethod

data FieldModifier
  = InternalField
  | UniqueField

data Function = Function
  { qualifiedFunName   :: MemberName
  , functionInputType  :: Type
  , functionOutputType :: Type
  , functionBody       :: AV.Expr
  } deriving (Eq)

instance Show Function where
  show (Function name int outt _) = "function " ++ name ++ " : " ++ show int ++ " -> " ++ show outt

instance Ord Function where
  f1 <= f2 = qualifiedFunName f1 <= qualifiedFunName f2

data DerivationKind
  = Unbound String
  | Concrete TypeName
             [DerivationKind]
  deriving (Eq, Ord)

instance Show DerivationKind where
  show (Unbound v) = v
  show (Concrete name []) = name
  show (Concrete name kinds) = name ++ " (" ++ intercalate ") (" (show <$> kinds) ++ ")"

voidDerivation :: DerivationKind
voidDerivation = Concrete "Void" []

functorialDerivation :: TypeName -> DerivationKind
functorialDerivation typename = Concrete "Function" [voidDerivation, Concrete typename []]

data Type
  = VoidType
  | EmptyType TypeName
  | Type { qualifiedTypeName    :: TypeName
         , supertype            :: DerivationKind
         , implementing         :: [DerivationKind]
         , typeVariants         :: [TypeName]
         , typeParamCount       :: Int
         , typeParamConstraints :: [[TypeParamConstraint]]
         , typeMembers          :: S.Set Function }
  deriving (Eq)

genParams :: Int -> [String]
genParams n = map (\n -> "_t" ++ show n) [0 .. (n - 1)]

instance Show Type where
  show VoidType = "Void"
  show (EmptyType name) = "I" ++ name
  show t = qualifiedTypeName t ++ " " ++ unwords (genParams $ typeParamCount t) ++ deriv ++ impl
    where
      deriv = " deriving " ++ show (supertype t)
      impl = " implementing " ++ intercalate ", " (show <$> implementing t)

instance Ord Type where
  t1 <= t2 = qualifiedTypeName t1 <= qualifiedTypeName t2

data ConcreteType
  = Void
  | PrimBool
  | PrimInt
  | PrimReal
  | PrimChar
  | ConcreteType { concreteTypeShape  :: Type
                 , concreteTypeParams :: [ConcreteType] }
