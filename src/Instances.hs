module Instances where

import           Data.List  (intercalate)
import qualified Data.Map   as M
import           Data.Maybe

data TypeParam
  = Primitive String
  | Template String
             [TypeParam]
  deriving (Eq, Ord)

instance Show TypeParam where
  show (Primitive str) = str
  show (Template str params) = str ++ " (" ++ intercalate ")(" (map show params)

type Clos f t = M.Map String (Inst f t)

data Inst f t
  = IntInstance Integer
  | DoubleInstance Double
  | CharInstance Char
  | BoolInstance Bool
  | FunctionInstance f
                     (Clos f t)
  | TypeInstance { baseType        :: t
                 , typeVariantName :: String
                 , instanceParams  :: [TypeParam]
                 , fields          :: [(String, Inst f t)] }
  deriving (Ord)

instanceMember :: String -> Inst f t -> Maybe (Inst f t)
instanceMember name inst@TypeInstance {} = lookup name (fields inst)
instanceMember _ _                       = Nothing

instanceListToList :: Inst f t -> [Inst f t]
instanceListToList inst =
  if isNothing (instanceMember "head" inst)
    then []
    else fromJust (instanceMember "head" inst) : instanceListToList (fromJust $ instanceMember "tail" inst)

instance (Eq f, Eq t) => Eq (Inst f t) where
  IntInstance v1 == IntInstance v2 = v1 == v2
  DoubleInstance v1 == DoubleInstance v2 = v1 == v2
  CharInstance v1 == CharInstance v2 = v1 == v2
  BoolInstance v1 == BoolInstance v2 = v1 == v2
  FunctionInstance f cl == FunctionInstance f2 cl2 = f == f2
  (TypeInstance b1 v1 _ f1) == (TypeInstance b2 v2 _ f2) = (b1 == b2) && (v1 == v2) && (f1 == f2)
  _ == _ = False
