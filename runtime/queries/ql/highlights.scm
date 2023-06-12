[
  "as"
  "by"
  "extends"
  "from"
  "implies"
  "in"
  "module"
  "order"
  "select"
  "where"
  (predicate)
  (result)
  (specialId)
] @keyword

[
  "newtype"
  "class"
] @keyword.type

[
  "and"
  "not"
  "or"
] @keyword.operator

[
  "avg"
  "any"
  "count"
  "concat"
  "exists"
  "max"
  "min"
  "instanceof"
  "rank"
  "sum"
  "strictconcat"
  "strictcount"
  "strictsum"
] @function.builtin

"import" @keyword.import

[
  "if"
  "then"
  "else"
] @keyword.conditional

[
  "forall"
  "forex"
] @keyword.repeat

[
  "asc"
  "desc"
] @keyword.modifier

[
  (true)
  (false)
] @boolean

[
  (this)
  (super)
] @variable.builtin

[
  "boolean"
  "float"
  "int"
  "date"
  "string"
] @type.builtin

(annotName) @attribute

[
  "<"
  "<="
  "="
  ">"
  ">="
  "-"
  "!="
  "/"
  "*"
  "%"
  "+"
  "::"
] @operator

[
  "("
  ")"
  "{"
  "}"
  "["
  "]"
] @punctuation.bracket

[
  ","
  "|"
] @punctuation.delimiter

(moduleExpr
  (simpleId) @module)

(module
  name: (moduleName) @module)

(dataclass
  name: (className) @type)

(typeExpr
  name: (className) @type)

(datatype
  name: (className) @type.definition)

(importModuleExpr
  qualName: (simpleId) @variable)

(varName) @variable

(integer) @number

(float) @number.float

(string) @string

(aritylessPredicateExpr
  (literalId) @function)

(memberPredicate
  name: (predicateName) @function)

(classlessPredicate
  name: (predicateName) @function)

(charpred
  (className) @function)

[
  (line_comment)
  (block_comment)
] @comment @spell

(qldoc) @comment.documentation
