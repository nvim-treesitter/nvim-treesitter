(keyw) @keyword
; more specific matches are done below whenever possible

; note: the below four statements match overzealously,
; and so are placed at the start of the file.

(primary (symbol) @variable)
; overzealous, matches generic symbols

(primary
  (primarySuffix
    (qualifiedSuffix
      (symbol) @variable.other.member)))
; overzealous, matches x in foo.x

((primary (symbol) @type)
 (#match? @type "[A-Z].+"))
; assume PascalCase identifiers to be types

((primary
  (primarySuffix
    (qualifiedSuffix
      (symbol) @type)))
 (#match? @type "[A-Z].+"))
; assume PascalCase member variables to be enum entries

((primary (symbol) @variable.builtin)
 (#match? @variable.builtin "result"))
; `result` is an implicit builtin variable inside function scopes

(variable
  (keyw) @type.definition
  (declColonEquals (symbol) @variable))
; let, var, const expressions

(symbolEqExpr
  (symbol) @variable)
; named parameters

(symbolColonExpr
  (symbol) @variable)
; object constructor parameters

(identColon (ident) @variable)
; named parts of tuples

(paramList
  (paramColonEquals
    (symbol) @parameter))
; parameter identifiers

(routine
  . (keyw) @keyword.function
  . (symbol) @function)
; function declarations

(routineExpr
  (keyw) @keyword.function)
; discarded function

(routineExprTypeDesc
  (keyw) @keyword.function)
; function declarations as types

(primary
  . (symbol) @function.call
  . (primarySuffix (functionCall)))
; regular function calls

(primary
  . (symbol) @function.call
  . (primarySuffix (cmdCall)))
; function calls without parenthesis

(primary
  (primarySuffix (qualifiedSuffix (symbol) @function.call))
  . (primarySuffix (functionCall)))
; uniform function call syntax calls

(primary
  (symbol) @constructor
  (primarySuffix (objectConstr)))
; object constructor

; does not appear to be a way to distinguish these without verbatium matching
; [] @function.builtin
; [] @function.method
; [] @function.macro
; [] @function.special

(pragma) @preproc

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
(interpolated_str_lit ["&" "{" "}"] @punctuation.special)

[(literal) (generalizedLit)] @constant
[(nil_lit)] @constant.builtin
[(bool_lit)] @boolean
[(char_lit)] @character
[(char_esc_seq) (str_esc_seq)] @string.escape
[(custom_numeric_lit)] @number
[(int_lit) (int_suffix)] @number
[(float_lit) (float_suffix)] @float
; note: somewhat irritatingly for testing, lits have the same syntax highlighting as types

[(str_lit) (triplestr_lit) (rstr_lit)] @string
; [] @string.regexp
[(generalized_str_lit) (generalized_triplestr_lit) (interpolated_str_lit) (interpolated_triplestr_lit)] @string.special
; [] @string.special.path
; [] @string.special.url
; [] @string.special.symbol

(comment) @comment
(multilineComment) @comment
(docComment) @comment.documentation
(multilineDocComment) @comment.documentation
; comments

(typeDef
  (keyw) @type.definition
  (symbol) @type)

(primarySuffix
  (indexSuffix
    (exprColonEqExprList
      (exprColonEqExpr
        (expr
          (primary
            (symbol) @type))))))
; types in brackets, i.e. seq[string]
; FIXME: this is overzealous. seq[tuple[a, b: int]] matches both a and b when it shouldn't.

(primaryTypeDef
  (symbol) @type)
; primary types of type declarations (nested types in brackets are matched with above)

(primaryTypeDesc
  (symbol) @type)
; type annotations, on declarations or in objects

(primaryTypeDesc
  (primaryPrefix
    (keyw) @type))
; var types

(genericParamList
  (genericParam
    (symbol) @type))
; types in generic blocks

(enumDecl
  (keyw) @type.definition
  (enumElement
    (symbol) @type.enum.variant))

(tupleDecl
  (keyw) @type.definition)

(objectDecl
  (keyw) @type.definition)

(objectPart
  (symbol) @variable.other.member)
; object field

(objectCase
  (keyw) @conditional
  (symbol) @variable
  (objectBranches
    ; (objectWhen (keyw) @conditional)?
    (objectElse (keyw) @conditional)?
    (objectElif (keyw) @conditional)?
    (objectBranch (keyw) @conditional)?))

(conceptDecl
  (keyw) @type.definition
  (conceptParam
    (symbol) @variable))

((exprStmt
  (primary (symbol))
  (operator) @operator
  (primary (symbol) @type))
 (#match? @operator "is"))
; "x is t" means t is either a type or a type variable

; distinct?

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
; todo: better to just use (operator) and (opr)?

(staticStmt (keyw) @keyword)
(deferStmt (keyw) @keyword)
(asmStmt (keyw) @keyword)
(bindStmt (keyw) @keyword)
(mixinStmt (keyw) @keyword)

(blockStmt
  (keyw) @repeat
  (symbol) @label)

(ifStmt (keyw) @conditional)
(whenStmt (keyw) @conditional)
(elifStmt (keyw) @conditional)
(elseStmt (keyw) @conditional)
(caseStmt (keyw) @conditional)
(ofBranch (keyw) @conditional)
(inlineIfStmt (keyw) @conditional)
(inlineWhenStmt (keyw) @conditional)
; todo: do block

(forStmt
  (keyw) @repeat
  (symbol) @variable
  (keyw) @repeat)
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
; FIXME: entries in std/[one, two] get highlighted as variables

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
