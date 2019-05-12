module FieldParser where

import           PreprocessingState

import qualified AbsVarg            as Abs
import qualified Data.Set           as S

import           TypeDefParser

parseField :: Abs.ClassField -> HierarchyMonad Function
parseField (Abs.NormalClassField (Abs.LIdent fldname) freeTypeDef) =
  local
    (setParsedMember fldname)
    (do lookupFun <- readSubstsFromCurrentStub
        fieldTypeDef <- parseFreeTypeDef lookupFun freeTypeDef
        return $ Function [] fldname (ConcreteType "Void" []) fieldTypeDef EConst)

parseFields :: [Abs.ClassField] -> HierarchyMonad (S.Set Function)
parseFields [] = pure S.empty
parseFields (field:t) = do
  parsedTail <- parseFields t
  parsed <- parseField field
  if S.member parsed parsedTail
    then do
      typename <- asks currentParsedTypeName
      variant <- asks currentParsedTypeVariant
      throwError $
        VargException $
        "In definition of " ++
        typename ++ "." ++ variant ++ ": multiple definition of field " ++ qualifiedFunName parsed
    else return $ S.insert parsed parsedTail
