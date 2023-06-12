; Keywords
[
  "as"
  "let"
  "panic"
  "todo"
  "use"
  "echo"
] @keyword

"type" @keyword.type

; Function Keywords
"fn" @keyword.function

; Imports
"import" @keyword.import

; Conditionals
[
  "case"
  "if"
] @keyword.conditional

; Exceptions
"assert" @keyword.exception

; Punctuation
[
  "("
  ")"
  "<<"
  ">>"
  "["
  "]"
  "{"
  "}"
] @punctuation.bracket

[
  ","
  "."
  ":"
  "->"
] @punctuation.delimiter

"#" @punctuation.special

; Operators
[
  "%"
  "&&"
  "*"
  "*."
  "+"
  "+."
  "-"
  "-."
  ".."
  "/"
  "/."
  "<"
  "<."
  "<="
  "<=."
  "="
  "=="
  ">"
  ">."
  ">="
  ">=."
  "|>"
  "||"
] @operator

; Identifiers
(identifier) @variable

; Comments
(comment) @comment @spell

[
  (module_comment)
  (statement_comment)
] @comment.documentation @spell

; Unused Identifiers
[
  (discard)
  (hole)
] @comment

; Modules & Imports
(module) @module

(import
  alias: ((identifier) @module)?)

(remote_type_identifier
  module: (identifier) @module)

(unqualified_import
  name: (identifier) @function)

; Strings
(string) @string

; Bit Strings
(bit_string_segment) @string.special

; Numbers
(integer) @number

(float) @number.float

; Function Parameter Labels
(function_call
  arguments: (arguments
    (argument
      label: (label) @label)))

(function_parameter
  label: (label)? @label
  name: (identifier) @variable.parameter)

; Records
(record
  arguments: (arguments
    (argument
      label: (label) @variable.member)?))

(record_pattern_argument
  label: (label) @variable.member)

(record_update_argument
  label: (label) @variable.member)

(field_access
  record: (identifier) @variable
  field: (label) @variable.member)

(data_constructor_argument
  (label) @variable.member)

; Types
[
  (type_identifier)
  (type_parameter)
  (type_var)
] @type

; Type Qualifiers
[
  "const"
  "external"
  (opacity_modifier)
  (visibility_modifier)
] @keyword.modifier

; Tuples
(tuple_access
  index: (integer) @operator)

; Functions
(function
  name: (identifier) @function)

(function_call
  function: (identifier) @function.call)

(function_call
  function: (field_access
    field: (label) @function.call))

; External Functions
(external_function
  name: (identifier) @function)

(external_function_body
  (string) @module
  .
  (string) @function)

; Constructors
(constructor_name) @type @constructor

([
  (type_identifier)
  (constructor_name)
] @constant.builtin
  (#any-of? @constant.builtin "Ok" "Error"))

; Booleans
((constructor_name) @boolean
  (#any-of? @boolean "True" "False"))

; Pipe Operator
(binary_expression
  operator: "|>"
  right: (identifier) @function)
