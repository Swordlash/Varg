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

type Loc = Int

type Obj = Either Loc

type Clos inst = M.Map String (Obj inst)

data Inst f t e
  = IntInstance Integer
  | DoubleInstance Double
  | CharInstance Char
  | BoolInstance Bool
  | FunctionInstance f
                     (Clos (Inst f t e))
                     Loc
  | ThunkInstance e
                  (Clos (Inst f t e))
                  Loc
  | UnboundVar String
  | TypeInstance { baseType        :: t
                 , typeVariantName :: String
                 , instanceParams  :: [TypeParam]
                 , fields          :: [(String, Inst f t e)]
                 , memoryLocation  :: Loc }
  deriving (Eq, Ord)

isManaged :: Inst f t e -> Bool
isManaged TypeInstance {}     = True
isManaged ThunkInstance {}    = True
isManaged FunctionInstance {} = True
isManaged UnboundVar {}       = False
isManaged _                   = False

address :: Inst f t e -> Int
address IntInstance {}             = undefined
address DoubleInstance {}          = undefined
address CharInstance {}            = undefined
address BoolInstance {}            = undefined
address UnboundVar {}              = undefined
address (FunctionInstance _ _ loc) = loc
address (ThunkInstance _ _ loc)    = loc
address t@TypeInstance {}          = memoryLocation t

instanceMember :: String -> Inst f t e -> Maybe (Inst f t e)
instanceMember name inst@TypeInstance {} = lookup name (fields inst)
instanceMember _ _                       = Nothing

instanceListToList :: Inst f t e -> [Inst f t e]
instanceListToList inst =
  if isNothing (instanceMember "head" inst)
    then []
    else fromJust (instanceMember "head" inst) : instanceListToList (fromJust $ instanceMember "tail" inst)
