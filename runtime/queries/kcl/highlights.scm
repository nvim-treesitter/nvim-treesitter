(identifier) @variable

(import_stmt
  (dotted_name
    (identifier) @module))

(import_stmt
  (dotted_name
    (identifier) @module)
  (identifier) @module)

(basic_type) @type.builtin

(schema_type
  (dotted_name
    (identifier) @type))

(schema_type
  (dotted_name
    (identifier) @module
    (identifier) @type))

(schema_expr
  (identifier) @type)

(protocol_stmt
  (identifier) @type)

(rule_stmt
  (identifier) @type)

(schema_stmt
  (identifier) @type)

(lambda_expr
  (typed_parameter
    (identifier) @variable.parameter))

(lambda_expr
  (identifier) @variable.parameter)

(selector_expr
  (select_suffix
    (identifier) @property))

(comment) @comment @spell

(string) @string

(escape_sequence) @string.escape

(schema_stmt
  body: (block
    .
    (string
      (string_content) @string.documentation)))

(decorator
  (identifier) @attribute)

(call_expr
  function: (identifier) @function)

(call_expr
  function: (selector_expr
    (select_suffix
      (identifier) @function)))

(integer) @number

(float) @number.float

[
  (true)
  (false)
] @boolean

[
  (none)
  (undefined)
] @constant.builtin

"for" @keyword.repeat

[
  "elif"
  "else"
  "if"
] @keyword.conditional

"lambda" @keyword.function

(quant_op) @keyword.operator

[
  "protocol"
  "rule"
  "schema"
  "type"
  "mixin"
] @keyword.type

"assert" @keyword.debug

[
  "as"
  "import"
] @keyword.import

"check" @keyword

[
  "("
  ")"
  "["
  "]"
  "{"
  "}"
] @punctuation.bracket

[
  ","
  ":"
  "."
  "?."
  "?:"
  "?"
] @punctuation.delimiter

(interpolation
  "${" @punctuation.special
  "}" @punctuation.special)

[
  "+"
  "-"
  "*"
  "**"
  "/"
  "//"
  "%"
  "<<"
  ">>"
  "&"
  "|"
  "^"
  "<"
  ">"
  "~"
  "<="
  ">="
  "=="
  "!="
  "="
  "+="
  "-="
  "*="
  "**="
  "/="
  "//="
  "%="
  "<<="
  ">>="
  "&="
  "^="
  "->"
] @operator

"@" @attribute

[
  "and"
  "or"
  "not"
  "in"
  "is"
] @keyword.operator

; second argument is a regex in all regex functions with at least two arguments
(call_expr
  function: (selector_expr
    (identifier) @_regex)
  arguments: (argument_list
    (_)
    .
    (string
      (string_content) @string.regexp))
  (#eq? @_regex "regex"))

; first argument is a regex in 'regex.compile' function
(call_expr
  function: (selector_expr
    (identifier) @_regex
    (select_suffix
      (identifier) @_fn
      (#eq? @_fn "compile")))
  arguments: (argument_list
    .
    (string
      (string_content) @string.regexp))
  (#eq? @_regex "regex"))
