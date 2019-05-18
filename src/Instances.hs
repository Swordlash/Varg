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

type Clos f t e = M.Map String (Inst f t e)

data Inst f t e
  = IntInstance Integer
  | DoubleInstance Double
  | CharInstance Char
  | BoolInstance Bool
  | FunctionInstance f
                     (Clos f t e)
  | ThunkInstance e
                  (Clos f t e)
  | UnificatorInstance (Clos f t e)
  | TypeInstance { baseType        :: t
                 , typeVariantName :: String
                 , instanceParams  :: [TypeParam]
                 , fields          :: [(String, Inst f t e)] }
  deriving (Eq, Ord)

instanceMember :: String -> Inst f t e -> Maybe (Inst f t e)
instanceMember name inst@TypeInstance {} = lookup name (fields inst)
instanceMember _ _                       = Nothing

instanceListToList :: Inst f t e -> [Inst f t e]
instanceListToList inst =
  if isNothing (instanceMember "head" inst)
    then []
    else fromJust (instanceMember "head" inst) : instanceListToList (fromJust $ instanceMember "tail" inst)
