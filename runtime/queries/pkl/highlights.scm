(identifier) @variable

(qualifiedAccessExpr
  (identifier) @function.method.call
  .
  (argumentList))

(qualifiedAccessExpr
  (identifier) @variable.member .)

; Operators
[
  "??"
  "@"
  "="
  "<"
  ">"
  "!"
  "=="
  "!="
  "<="
  ">="
  "&&"
  "||"
  "+"
  "-"
  "**"
  "*"
  "/"
  "~/"
  "%"
  "|>"
  "..."
  "|"
  "->"
] @operator

[
  ","
  ":"
  "."
  "?."
] @punctuation.delimiter

[
  "("
  ")"
  "["
  "]"
  "{"
  "}"
] @punctuation.bracket

; Types
(clazz
  (identifier) @type.definition)

(typeAlias
  (identifier) @type.definition)

((identifier) @type
  (#lua-match? @type "^[A-Z]"))

(typeArgumentList
  [
    "<"
    ">"
  ] @punctuation.bracket)

; Method definitions
(classMethod
  (methodHeader
    (identifier) @function.method))

(objectMethod
  (methodHeader
    (identifier) @function.method))

; Identifiers
(classProperty
  (identifier) @property)

(objectProperty
  (identifier) @property)

(parameterList
  (typedIdentifier
    (identifier) @variable.parameter))

(objectBodyParameters
  (typedIdentifier
    (identifier) @variable.parameter))

; Literals
[
  (stringConstant)
  (slStringLiteralExpr)
  (mlStringLiteralExpr)
] @string

(escapeSequence) @string.escape

(intLiteralExpr) @number

(floatLiteralExpr) @number.float

(stringInterpolation
  [
    "\\("
    "\\#("
    "\\##("
    "\\###("
    "\\####("
    "\\#####("
    "\\######("
  ] @punctuation.special
  ")" @punctuation.special)

(nullableType
  "?" @punctuation.special)

[
  (lineComment)
  (blockComment)
] @comment @spell

(docComment) @comment.documentation @spell

(shebangComment) @keyword.directive

; Keywords
[
  "abstract"
  "external"
  "for"
  "is"
  "let"
  "new"
  "out"
] @keyword

"function" @keyword.function

[
  "as"
  "in"
] @keyword.operator

[
  "typealias"
  "class"
  "module"
] @keyword.type

[
  "import"
  "import*"
  "amends"
  "extends"
] @keyword.import

[
  "when"
  "if"
  "else"
] @keyword.conditional

(modifier) @keyword.modifier

(importExpr
  [
    "import"
    "import*"
  ] @function.builtin)

(moduleExpr
  "module" @type.builtin)

[
  (outerExpr)
  "super"
  (thisExpr)
] @variable.builtin

[
  "read"
  "read?"
  "read*"
  "throw"
  "trace"
] @function.builtin

(nullLiteralExpr) @constant.builtin

[
  (falseLiteralExpr)
  (trueLiteralExpr)
] @boolean

(newExpr
  (declaredType
    (qualifiedIdentifier
      (identifier) @constructor .)))
