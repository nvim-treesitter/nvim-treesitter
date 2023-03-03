; [
;   "end"
;   "cast"
;   "out"
;   "using"
;   "ptr"
;   "ref"
;   "nil"
;   "addr"
; ] @keyword
(staticStmt (keyw) @keyword)
(deferStmt (keyw) @keyword)
(asmStmt (keyw) @keyword)
(bindStmt (keyw) @keyword)
(mixinStmt (keyw) @keyword)

(blockStmt
  (keyw) @keyword
  (symbol) @label)

(ifStmt (keyw) @conditional)
(whenStmt (keyw) @conditional)
(elifStmt (keyw) @conditional)
(elseStmt (keyw) @conditional)
(caseStmt (keyw) @conditional)
(ofBranch (keyw) @conditional)
(inlineIfStmt (keyw) @conditional)
(inlineWhenStmt (keyw) @conditional)
; todo: do

(forStmt
  (keyw) @repeat
  (symbol) @variable)
(whileStmt (keyw) @repeat)

(importStmt
  (keyw) @include
  (expr (primary (symbol) @include)))
(importExceptStmt
  (keyw) @include
  (expr (primary (symbol) @include)))
(exportStmt
  (keyw) @include
  (expr (primary (symbol) @include)))
(fromStmt
  (keyw) @include
  (expr (primary (symbol) @include)))
(includeStmt
  (keyw) @include
  (expr (primary (symbol) @include)))

(returnStmt (keyw) @keyword.return)
(yieldStmt (keyw) @keyword.return)
(discardStmt (keyw) @keyword.return)
(breakStmt (keyw) @keyword.return)
(continueStmt (keyw) @keyword.return)

(raiseStmt (keyw) @exception)
(tryStmt (keyw) @exception)
(tryExceptStmt (keyw) @exception)
(tryFinallyStmt (keyw) @exception)
(inlineTryStmt (keyw) @exception)
; (inlineTryExceptStmt (keyw) @exception)
; (inlineTryFinallyStmt (keyw) @exception)

[
  "and"
  "or"
  "xor"
  "not"
  "in"
  "notin"
  "is"
  "isnot"
  "div"
  "mod"
  "shl"
  "shr"
] @keyword.operator

(typeDef
  (keyw) @type.definition
  (symbol) @type)

(typeDesc
  (primaryTypeDesc
    (symbol) @type))

(primary
  (primarySuffix
    (indexSuffix
      (exprColonEqExprList
        (exprColonEqExpr
          (expr
            (primary
              (symbol) @type)))))))

(primaryTypeDef
  (symbol) @type
  (primarySuffix
    (indexSuffix
      (exprColonEqExprList
        (exprColonEqExpr
          (expr
            (primary
              (symbol) @type)))))))

(primaryTypeDesc
  (primarySuffix
    (indexSuffix
      (exprColonEqExprList
        (exprColonEqExpr
          (expr
            (primary
              (symbol) @type)))))))

(genericParamList
  (genericParam
    (symbol) @type))

(enumDecl
  (enumElement
    (symbol) @type))

(symbolColonExpr
  (symbol) @parameter
  (expr
    (primary
      (symbol) @type)))

(enumDecl (keyw) @type.definition)
(tupleDecl (keyw) @type.definition)
; objectDecl, conceptDecl not implemented
; distinct?

[(operator) (opr) "="] @operator

[
  "."
  ","
  ";"
  ":"
] @punctuation.delimiter
[
  "("
  ")"
  "["
  "]"
  "{"
  "}"
  "{."
  ".}"
  "#["
  "]#"
] @punctuation.bracket
; [] @punctuation.special

; [
;   "array"
;   "seq"
;   "range"
;   ; array, seq, range: *_type?
;   "int"
;   "uint"
;   "int8"
;   "int16"
;   "int32"
;   "int64"
;   "uint8"
;   "uint16"
;   "uint32"
;   "uint64"
;   "float"
;   "float32"
;   "float64"
;   "bool"
;   "string"
;   "char"
; ] @type.builtin
; [] @type.constructor

[(literal) (generalizedLit)] @constant
[(nil_lit)] @constant.builtin
[(bool_lit)] @boolean
[(char_lit)] @character
[(char_esc_seq)] @character.special
[(custom_numeric_lit)] @number
[(int_lit) (int_suffix)] @number
[(float_lit) (float_suffix)] @float

[(str_lit) (triplestr_lit)] @string
[(generalized_str_lit) (generalized_triplestr_lit)] @string.special

(comment) @comment
(multilineComment) @comment
(docComment) @comment
(multilineDocComment) @comment

(pragma) @attribute

(routine
  . (keyw) @keyword.function
  . (ident) @function)

(primary
  . (symbol (ident) @function.call)
  . (primarySuffix (functionCall)))

(primary
  (primarySuffix (qualifiedSuffix (symbol (ident) @function.call)))
  . (primarySuffix (functionCall)))

; somehow breaks ordinary function calls
; (primary
;   (symbol) @function.call
;   (primarySuffix
;     (objectConstr
;       (symbolColonExpr
;         (symbol) @variable))))

; todo: identify `echo "foo"` as a function call

; does not appear to be a way to distinguish these without verbatium matching
; [] @function.builtin
; [] @function.macro

(variable
  (keyw) @type.definition
  (declColonEquals
    (symbol) @variable))

(expr
  (primary
    (symbol) @variable))

; note: both this and exprStmt MUST come after the function queries
(expr
  (primary
    (primarySuffix
      (qualifiedSuffix
        (symbol
          (ident) @variable)))))
(exprStmt
  (primary
    (symbol) @variable))

(exprStmt
  (primary
    (primarySuffix
      (qualifiedSuffix
        (symbol
          (ident) @variable)))))

(paramList
  (paramColonEquals
    (symbol) @parameter))

(keyw) @keyword
