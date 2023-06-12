(variable) @variable

(identifier) @variable

((variable) @variable.builtin
  (#eq? @variable.builtin "$this"))

(braced_expression) @none

(scoped_identifier
  (qualified_identifier
    (identifier) @type))

[
  (comment)
  (heredoc)
] @comment @spell

((comment) @comment.documentation
  (#lua-match? @comment.documentation "^/[*][*][^*].*[*]/$"))

"function" @keyword.function

[
  "implements"
  "using"
  "attribute"
  "const"
  "extends"
  "insteadof"
] @keyword

[
  "class"
  "type"
  "interface"
  "namespace"
] @keyword.type

[
  "async"
  "await"
] @keyword.coroutine

[
  "use"
  "include"
  "include_once"
  "require"
  "require_once"
] @keyword.import

[
  "new"
  "print"
  "echo"
  "newtype"
  "clone"
  "as"
] @keyword.operator

"return" @keyword.return

[
  (abstract_modifier)
  (final_modifier)
  (static_modifier)
  (visibility_modifier)
  (xhp_modifier)
] @keyword.modifier

[
  "shape"
  "tuple"
  (array_type)
  "bool"
  "float"
  "int"
  "string"
  "arraykey"
  "void"
  "nonnull"
  "mixed"
  "dynamic"
  "noreturn"
] @type.builtin

(null) @constant.builtin

[
  (true)
  (false)
] @boolean

(type_specifier) @type

(new_expression
  (_) @type)

(alias_declaration
  "newtype"
  .
  (_) @type)

(alias_declaration
  "type"
  .
  (_) @type)

(class_declaration
  name: (identifier) @type)

(type_parameter
  name: (identifier) @type)

(collection
  (qualified_identifier
    (identifier) @type .))

[
  "@required"
  "@lateinit"
  (attribute_modifier)
] @attribute

[
  "="
  "??="
  ".="
  "|="
  "^="
  "&="
  "<<="
  ">>="
  "+="
  "-="
  "*="
  "/="
  "%="
  "**="
  "==>"
  "|>"
  "??"
  "||"
  "&&"
  "|"
  "^"
  "&"
  "=="
  "!="
  "==="
  "!=="
  "<"
  ">"
  "<="
  ">="
  "<=>"
  "<<"
  ">>"
  "->"
  "+"
  "-"
  "."
  "*"
  "/"
  "%"
  "**"
  "++"
  "--"
  "!"
  "?:"
  "="
  "??="
  ".="
  "|="
  "^="
  "&="
  "<<="
  ">>="
  "+="
  "-="
  "*="
  "/="
  "%="
  "**="
  "=>"
  ; type modifiers
  "@"
  "?"
  "~"
] @operator

(integer) @number

(float) @number.float

(parameter
  (variable) @variable.parameter)

(call_expression
  function: (qualified_identifier
    (identifier) @function.call .))

(call_expression
  function: (scoped_identifier
    (identifier) @function.call .))

(call_expression
  function: (selection_expression
    (qualified_identifier
      (identifier) @function.method.call .)))

(qualified_identifier
  (_) @module
  .
  (_))

(use_statement
  (qualified_identifier
    (_) @module .)
  (use_clause))

(use_statement
  (use_type
    "namespace")
  (use_clause
    (qualified_identifier
      (identifier) @module .)
    alias: (identifier)? @module))

(use_statement
  (use_type
    "const")
  (use_clause
    (qualified_identifier
      (identifier) @constant .)
    alias: (identifier)? @constant))

(use_statement
  (use_type
    "function")
  (use_clause
    (qualified_identifier
      (identifier) @function .)
    alias: (identifier)? @function))

(use_statement
  (use_type
    "type")
  (use_clause
    (qualified_identifier
      (identifier) @type .)
    alias: (identifier)? @type))

(use_clause
  (use_type
    "namespace")
  (qualified_identifier
    (_) @module .)
  alias: (identifier)? @module)

(use_clause
  (use_type
    "function")
  (qualified_identifier
    (_) @function .)
  alias: (identifier)? @function)

(use_clause
  (use_type
    "const")
  (qualified_identifier
    (_) @constant .)
  alias: (identifier)? @constant)

(use_clause
  (use_type
    "type")
  (qualified_identifier
    (_) @type .)
  alias: (identifier)? @type)

(function_declaration
  name: (identifier) @function)

(method_declaration
  name: (identifier) @function.method)

(type_arguments
  [
    "<"
    ">"
  ] @punctuation.bracket)

[
  "("
  ")"
  "["
  "]"
  "{"
  "}"
  "<<"
  ">>"
] @punctuation.bracket

(xhp_open
  [
    "<"
    ">"
  ] @tag.delimiter)

(xhp_close
  [
    "</"
    ">"
  ] @tag.delimiter)

[
  "."
  ";"
  "::"
  ":"
  ","
] @punctuation.delimiter

(qualified_identifier
  "\\" @punctuation.delimiter)

(ternary_expression
  [
    "?"
    ":"
  ] @keyword.conditional.ternary)

[
  "if"
  "else"
  "elseif"
  "switch"
  "case"
] @keyword.conditional

[
  "try"
  "catch"
  "finally"
] @keyword.exception

[
  "for"
  "while"
  "foreach"
  "do"
  "continue"
  "break"
] @keyword.repeat

[
  (string)
  (xhp_string)
] @string

[
  (xhp_open)
  (xhp_close)
] @tag
