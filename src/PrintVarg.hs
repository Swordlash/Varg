{-# OPTIONS_GHC -fno-warn-incomplete-patterns #-}

module PrintVarg where

-- pretty-printer generated by the BNF converter
import           AbsVarg
import           Data.Char

-- the top-level printing method
printTree :: Print a => a -> String
printTree = render . prt 0

type Doc = [ShowS] -> [ShowS]

doc :: ShowS -> Doc
doc = (:)

render :: Doc -> String
render d = rend 0 (map ($ "") $ d []) ""
  where
    rend i ss =
      case ss of
        "[":ts -> showChar '[' . rend i ts
        "(":ts -> showChar '(' . rend i ts
        "{":ts -> showChar '{' . new (i + 1) . rend (i + 1) ts
        "}":";":ts -> new (i - 1) . space "}" . showChar ';' . new (i - 1) . rend (i - 1) ts
        "}":ts -> new (i - 1) . showChar '}' . new (i - 1) . rend (i - 1) ts
        ";":ts -> showChar ';' . new i . rend i ts
        t:",":ts -> showString t . space "," . rend i ts
        t:")":ts -> showString t . showChar ')' . rend i ts
        t:"]":ts -> showString t . showChar ']' . rend i ts
        t:ts -> space t . rend i ts
        _ -> id
    new i = showChar '\n' . replicateS (2 * i) (showChar ' ') . dropWhile isSpace
    space t =
      showString t .
      (\s ->
         if null s
           then ""
           else (' ' : s))

parenth :: Doc -> Doc
parenth ss = doc (showChar '(') . ss . doc (showChar ')')

concatS :: [ShowS] -> ShowS
concatS = foldr (.) id

concatD :: [Doc] -> Doc
concatD = foldr (.) id

replicateS :: Int -> ShowS -> ShowS
replicateS n f = concatS (replicate n f)

-- the printer class does the job
class Print a where
  prt :: Int -> a -> Doc
  prtList :: Int -> [a] -> Doc
  prtList i = concatD . map (prt i)

instance Print a => Print [a] where
  prt = prtList

instance Print Char where
  prt _ s = doc (showChar '\'' . mkEsc '\'' s . showChar '\'')
  prtList _ s = doc (showChar '"' . concatS (map (mkEsc '"') s) . showChar '"')

mkEsc :: Char -> Char -> ShowS
mkEsc q s =
  case s of
    _
      | s == q -> showChar '\\' . showChar s
    '\\' -> showString "\\\\"
    '\n' -> showString "\\n"
    '\t' -> showString "\\t"
    _ -> showChar s

prPrec :: Int -> Int -> Doc -> Doc
prPrec i j =
  if j < i
    then parenth
    else id

instance Print Integer where
  prt _ x = doc (shows x)

instance Print Double where
  prt _ x = doc (shows x)

instance Print UIdent where
  prt _ (UIdent i) = doc (showString (i))

instance Print LIdent where
  prt _ (LIdent i) = doc (showString (i))

instance Print MFun where
  prt _ (MFun i) = doc (showString (i))

instance Print ProgramDef where
  prt i e =
    case e of
      Program importdefs classdefs -> prPrec i 0 (concatD [prt 0 importdefs, prt 0 classdefs])

instance Print ImportDef where
  prt i e =
    case e of
      Import uident -> prPrec i 0 (concatD [doc (showString "import"), prt 0 uident, doc (showString ";")])
  prtList _ []     = (concatD [])
  prtList _ (x:xs) = (concatD [prt 0 x, prt 0 xs])

instance Print ConstrTypeParam where
  prt i e =
    case e of
      InferredTypeParam lident -> prPrec i 0 (concatD [prt 0 lident])
      ConcreteTypeParam uident -> prPrec i 0 (concatD [prt 0 uident])
      WildcardTypeParam -> prPrec i 0 (concatD [doc (showString "?")])
      AnotherClassTypeParam typedef -> prPrec i 0 (concatD [doc (showString "("), prt 0 typedef, doc (showString ")")])
      SuperConstrainedTypeParam lident typedefs ->
        prPrec
          i
          0
          (concatD [doc (showString "["), prt 0 lident, doc (showString "super"), prt 0 typedefs, doc (showString "]")])
      AnySuperConstrainedTypeParam typedefs ->
        prPrec
          i
          0
          (concatD
             [ doc (showString "[")
             , doc (showString "?")
             , doc (showString "super")
             , prt 0 typedefs
             , doc (showString "]")
             ])
      DerivingConstrainedTypeParam lident typedefs ->
        prPrec
          i
          0
          (concatD
             [doc (showString "["), prt 0 lident, doc (showString "deriving"), prt 0 typedefs, doc (showString "]")])
      AnyDerivingConstrainedTypeParam typedefs ->
        prPrec
          i
          0
          (concatD
             [ doc (showString "[")
             , doc (showString "?")
             , doc (showString "deriving")
             , prt 0 typedefs
             , doc (showString "]")
             ])
  prtList _ []     = (concatD [])
  prtList _ (x:xs) = (concatD [prt 0 x, prt 0 xs])

instance Print TypeDef where
  prt i e =
    case e of
      ConcreteType uident constrtypeparams -> prPrec i 0 (concatD [prt 0 uident, prt 0 constrtypeparams])
      InferredType lident constrtypeparams -> prPrec i 0 (concatD [prt 0 lident, prt 0 constrtypeparams])
  prtList _ [x]    = (concatD [prt 0 x])
  prtList _ (x:xs) = (concatD [prt 0 x, doc (showString ","), prt 0 xs])

instance Print PrimFreeType where
  prt i e =
    case e of
      ConcreteTypeFreeType freetypedef ->
        prPrec i 0 (concatD [doc (showString "("), prt 0 freetypedef, doc (showString ")")])
      TemplateFreeType lident -> prPrec i 0 (concatD [prt 0 lident])
      ConcreteFreeType uident -> prPrec i 0 (concatD [prt 0 uident])
  prtList _ []     = (concatD [])
  prtList _ (x:xs) = (concatD [prt 0 x, prt 0 xs])

instance Print FreeTypeDef where
  prt i e =
    case e of
      FreeType uident primfreetypes -> prPrec i 0 (concatD [prt 0 uident, prt 0 primfreetypes])
      InferredFreeType lident primfreetypes -> prPrec i 0 (concatD [prt 0 lident, prt 0 primfreetypes])
  prtList _ [x]    = (concatD [prt 0 x])
  prtList _ (x:xs) = (concatD [prt 0 x, doc (showString ","), prt 0 xs])

instance Print ArgDef where
  prt i e =
    case e of
      ArgumentDefinition lident typedef ->
        prPrec
          i
          0
          (concatD [doc (showString "("), prt 0 lident, doc (showString ":"), prt 0 typedef, doc (showString ")")])
      InferredArgumentDef lident -> prPrec i 0 (concatD [prt 0 lident])
  prtList _ []     = (concatD [])
  prtList _ (x:xs) = (concatD [prt 0 x, prt 0 xs])

instance Print SuperclassType where
  prt i e =
    case e of
      Superclass freetypedef -> prPrec i 0 (concatD [prt 0 freetypedef])
  prtList _ [x]    = (concatD [prt 0 x])
  prtList _ (x:xs) = (concatD [prt 0 x, doc (showString ","), prt 0 xs])

instance Print ClassDef where
  prt i e =
    case e of
      StructDefinition classmodifiers uident classfields ->
        prPrec
          i
          0
          (concatD
             [ prt 0 classmodifiers
             , doc (showString "struct")
             , prt 0 uident
             , doc (showString "where")
             , doc (showString "{")
             , prt 0 classfields
             , doc (showString "}")
             ])
      ClassDefinition classmodifiers uident isderiving isimplementing classcontents ->
        prPrec
          i
          0
          (concatD
             [ prt 0 classmodifiers
             , doc (showString "class")
             , prt 0 uident
             , prt 0 isderiving
             , prt 0 isimplementing
             , doc (showString "where")
             , doc (showString "{")
             , prt 0 classcontents
             , doc (showString "}")
             ])
      TemplateDefinition classmodifiers uident constrtypeparams isderiving isimplementing classcontents ->
        prPrec
          i
          0
          (concatD
             [ prt 0 classmodifiers
             , doc (showString "template")
             , prt 0 uident
             , prt 0 constrtypeparams
             , prt 0 isderiving
             , prt 0 isimplementing
             , doc (showString "where")
             , doc (showString "{")
             , prt 0 classcontents
             , doc (showString "}")
             ])
  prtList _ []     = (concatD [])
  prtList _ (x:xs) = (concatD [prt 0 x, prt 0 xs])

instance Print IsImplementing where
  prt i e =
    case e of
      Implementing superclasstypes -> prPrec i 0 (concatD [doc (showString "implementing"), prt 0 superclasstypes])
      NotImplementing -> prPrec i 0 (concatD [])

instance Print IsDeriving where
  prt i e =
    case e of
      Deriving superclasstype -> prPrec i 0 (concatD [doc (showString "deriving"), prt 0 superclasstype])
      NotDeriving -> prPrec i 0 (concatD [])

instance Print ClassModifier where
  prt i e =
    case e of
      ClassModifier_module -> prPrec i 0 (concatD [doc (showString "module")])
      ClassModifier_interface -> prPrec i 0 (concatD [doc (showString "interface")])
      ClassModifier_sealed -> prPrec i 0 (concatD [doc (showString "sealed")])
  prtList _ []     = (concatD [])
  prtList _ (x:xs) = (concatD [prt 0 x, prt 0 xs])

instance Print ClassContents where
  prt i e =
    case e of
      ClassContent memberdefs fundefs -> prPrec i 0 (concatD [prt 0 memberdefs, prt 0 fundefs])

instance Print MemberDef where
  prt i e =
    case e of
      EmptyMemberDefinition uident -> prPrec i 0 (concatD [prt 0 uident])
      MemberDefinition uident classfields ->
        prPrec
          i
          0
          (concatD [prt 0 uident, doc (showString "has"), doc (showString "{"), prt 0 classfields, doc (showString "}")])
  prtList _ []     = (concatD [])
  prtList _ [x]    = (concatD [prt 0 x])
  prtList _ (x:xs) = (concatD [prt 0 x, doc (showString ";"), prt 0 xs])

instance Print FunDef where
  prt i e =
    case e of
      MemberFunctionDefinition functionmodifiers lident argdefs rettype expr ->
        prPrec
          i
          0
          (concatD
             [ prt 0 functionmodifiers
             , doc (showString "function")
             , prt 0 lident
             , prt 0 argdefs
             , prt 0 rettype
             , doc (showString "=")
             , prt 0 expr
             ])
      AbstractFunctionDefinition functionmodifiers lident argdefs absrettype ->
        prPrec
          i
          0
          (concatD [prt 0 functionmodifiers, doc (showString "function"), prt 0 lident, prt 0 argdefs, prt 0 absrettype])
  prtList _ []     = (concatD [])
  prtList _ [x]    = (concatD [prt 0 x])
  prtList _ (x:xs) = (concatD [prt 0 x, doc (showString ";"), prt 0 xs])

instance Print RetType where
  prt i e =
    case e of
      ReturnType freetypedef -> prPrec i 0 (concatD [doc (showString ":"), prt 0 freetypedef])
      InferredReturnType -> prPrec i 0 (concatD [])

instance Print AbsRetType where
  prt i e =
    case e of
      AbsReturnType freetypedef ->
        prPrec i 0 (concatD [doc (showString ":"), doc (showString "abstract"), prt 0 freetypedef])
      AbsInferredReturnType -> prPrec i 0 (concatD [])

instance Print FunctionModifier where
  prt i e =
    case e of
      FunctionModifier_static -> prPrec i 0 (concatD [doc (showString "static")])
      FunctionModifier_internal -> prPrec i 0 (concatD [doc (showString "internal")])
      FunctionModifier_implement -> prPrec i 0 (concatD [doc (showString "implement")])
      FunctionModifier_final -> prPrec i 0 (concatD [doc (showString "final")])
      FunctionModifier_unique -> prPrec i 0 (concatD [doc (showString "unique")])
  prtList _ []     = (concatD [])
  prtList _ (x:xs) = (concatD [prt 0 x, prt 0 xs])

instance Print ClassField where
  prt i e =
    case e of
      ModifiedClassField fieldmodifier lident freetypedef ->
        prPrec i 0 (concatD [prt 0 fieldmodifier, prt 0 lident, doc (showString ":"), prt 0 freetypedef])
      NormalClassField lident freetypedef ->
        prPrec i 0 (concatD [prt 0 lident, doc (showString ":"), prt 0 freetypedef])
  prtList _ []     = (concatD [])
  prtList _ [x]    = (concatD [prt 0 x])
  prtList _ (x:xs) = (concatD [prt 0 x, doc (showString ";"), prt 0 xs])

instance Print FieldModifier where
  prt i e =
    case e of
      FieldModifier_internal -> prPrec i 0 (concatD [doc (showString "internal")])
      FieldModifier_unique -> prPrec i 0 (concatD [doc (showString "unique")])

instance Print Expr where
  prt i e =
    case e of
      EDefinitionsList asdefs expr ->
        prPrec
          i
          0
          (concatD
             [ doc (showString "define")
             , doc (showString "{")
             , prt 0 asdefs
             , doc (showString "}")
             , doc (showString "in")
             , prt 0 expr
             ])
      EDefinition asdef expr ->
        prPrec i 0 (concatD [doc (showString "define"), prt 0 asdef, doc (showString "in"), prt 0 expr])
      EMatch expr matchclauses ->
        prPrec
          i
          0
          (concatD
             [ doc (showString "match")
             , prt 0 expr
             , doc (showString "with")
             , doc (showString "{")
             , prt 0 matchclauses
             , doc (showString "}")
             ])
      EIfThenElse expr1 expr2 expr3 ->
        prPrec
          i
          0
          (concatD
             [ doc (showString "if")
             , prt 0 expr1
             , doc (showString "then")
             , prt 0 expr2
             , doc (showString "else")
             , prt 0 expr3
             ])
      EApply functorial args -> prPrec i 5 (concatD [prt 0 functorial, prt 0 args])
      ELambda argdefs typedef expr ->
        prPrec
          i
          0
          (concatD
             [ doc (showString "(")
             , doc (showString "\\")
             , prt 0 argdefs
             , doc (showString ":")
             , prt 0 typedef
             , doc (showString "=>")
             , prt 0 expr
             , doc (showString ")")
             ])
      EList listelems -> prPrec i 0 (concatD [doc (showString "["), prt 0 listelems, doc (showString "]")])
      EEq expr1 expr2 -> prPrec i 1 (concatD [prt 1 expr1, doc (showString "=="), prt 2 expr2])
      ELq expr1 expr2 -> prPrec i 1 (concatD [prt 2 expr1, doc (showString "<"), prt 2 expr2])
      EGt expr1 expr2 -> prPrec i 1 (concatD [prt 2 expr1, doc (showString ">"), prt 2 expr2])
      ELeq expr1 expr2 -> prPrec i 1 (concatD [prt 2 expr1, doc (showString "<="), prt 2 expr2])
      EGeq expr1 expr2 -> prPrec i 1 (concatD [prt 2 expr1, doc (showString ">="), prt 2 expr2])
      EAdd expr1 expr2 -> prPrec i 2 (concatD [prt 2 expr1, doc (showString "+"), prt 3 expr2])
      ESub expr1 expr2 -> prPrec i 2 (concatD [prt 2 expr1, doc (showString "-"), prt 3 expr2])
      EMul expr1 expr2 -> prPrec i 3 (concatD [prt 3 expr1, doc (showString "*"), prt 4 expr2])
      EDiv expr1 expr2 -> prPrec i 3 (concatD [prt 3 expr1, doc (showString "/"), prt 4 expr2])
      EPow expr1 expr2 -> prPrec i 4 (concatD [prt 5 expr1, doc (showString "^"), prt 4 expr2])
      EInt n -> prPrec i 6 (concatD [prt 0 n])
      EReal d -> prPrec i 6 (concatD [prt 0 d])
      EWild -> prPrec i 6 (concatD [doc (showString "_")])

instance Print AsDef where
  prt i e =
    case e of
      IDefinition expr lident -> prPrec i 0 (concatD [prt 0 expr, doc (showString "as"), prt 0 lident])
  prtList _ []     = (concatD [])
  prtList _ [x]    = (concatD [prt 0 x])
  prtList _ (x:xs) = (concatD [prt 0 x, doc (showString ";"), prt 0 xs])

instance Print MatchClause where
  prt i e =
    case e of
      IMatchClause expr1 expr2 -> prPrec i 0 (concatD [prt 0 expr1, doc (showString "->"), prt 0 expr2])
  prtList _ []     = (concatD [])
  prtList _ [x]    = (concatD [prt 0 x])
  prtList _ (x:xs) = (concatD [prt 0 x, doc (showString ";"), prt 0 xs])

instance Print Functorial where
  prt i e =
    case e of
      ThisFunctor -> prPrec i 0 (concatD [doc (showString "this")])
      SuperFunctor -> prPrec i 0 (concatD [doc (showString "super")])
      TypeFunctor uident -> prPrec i 0 (concatD [prt 0 uident])
      InstanceFunctor lident -> prPrec i 0 (concatD [prt 0 lident])
      MemberFunctor mfun -> prPrec i 0 (concatD [prt 0 mfun])

instance Print Arg where
  prt i e =
    case e of
      ArgExpr expr       -> prPrec i 0 (concatD [prt 6 expr])
      ArgFunc functorial -> prPrec i 0 (concatD [prt 0 functorial])
  prtList _ []     = (concatD [])
  prtList _ (x:xs) = (concatD [prt 0 x, prt 0 xs])

instance Print ListElem where
  prt i e =
    case e of
      EListElem expr -> prPrec i 0 (concatD [prt 0 expr])
  prtList _ []     = (concatD [])
  prtList _ [x]    = (concatD [prt 0 x])
  prtList _ (x:xs) = (concatD [prt 0 x, doc (showString ","), prt 0 xs])
