; Variables
(identifier) @variable

; Includes
"include" @keyword.import

(include_statement
  (identifier) @type)

(include_statement
  (class_identifier
    (identifier) @type .))

; Keywords
[
  "inherits"
  "node"
  "tag"
  "require"
] @keyword

[
  "type"
  "class"
] @keyword.type

[
  "define"
  "function"
] @keyword.function

[
  "if"
  "elsif"
  "else"
  "unless"
  "case"
] @keyword.conditional

(default_case
  "default" @keyword.conditional)

; Attributes
(attribute
  name: (identifier) @attribute)

(attribute
  name: (variable
    (identifier) @attribute))

; Parameters
(lambda
  (variable
    (identifier) @variable.parameter))

(parameter
  (variable
    (identifier) @variable.parameter))

(function_call
  (identifier) @variable.parameter)

(iterator_statement
  (variable) @variable.parameter)

; Functions
(function_declaration
  "function"
  .
  (identifier) @function)

(function_call
  (identifier) @function.call
  "(")

(defined_resource_type
  "define"
  .
  (identifier) @function)

; Methods
(function_declaration
  "function"
  .
  (class_identifier
    (identifier) @function.method .))

(function_call
  (class_identifier
    (identifier) @function.method.call .))

(defined_resource_type
  "define"
  .
  (class_identifier
    (identifier) @function.method .))

(function_call
  (field_expression
    "."
    (identifier) @function.method.call)
  "(")

; Types
(type) @type

(builtin_type) @type.builtin

(class_definition
  (identifier) @type)

(class_definition
  (class_identifier
    (identifier) @type .))

(class_inherits
  (identifier) @type)

(class_inherits
  (class_identifier
    (identifier) @type .))

(resource_declaration
  (identifier) @type)

(resource_declaration
  (class_identifier
    (identifier) @type .))

(node_definition
  (node_name
    (identifier) @type))

((identifier) @type
  (#lua-match? @type "^[A-Z]"))

((identifier) @type.builtin
  (#any-of? @type.builtin
    "Boolean" "Integer" "Float" "String" "Array" "Hash" "Regexp" "Variant" "Data" "Undef" "Default"
    "File"))

; "Namespaces"
(class_identifier
  .
  (identifier) @module)

; Operators
[
  "or"
  "and"
  "in"
] @keyword.operator

[
  "="
  "+="
  "->"
  "~>"
  "<<|"
  "<|"
  "|>"
  "|>>"
  "?"
  ">"
  ">="
  "<="
  "<"
  "=="
  "!="
  "<<"
  ">>"
  "+"
  "-"
  "*"
  "/"
  "%"
  "=~"
  "!~"
] @operator

; Punctuation
[
  "|"
  "."
  ","
  ";"
  ":"
  "::"
  "=>"
] @punctuation.delimiter

[
  "{"
  "}"
] @punctuation.bracket

[
  "["
  "]"
] @punctuation.bracket

[
  "("
  ")"
] @punctuation.bracket

(interpolation
  [
    "${"
    "}"
  ] @punctuation.special)

[
  "$"
  "@"
  "@@"
] @punctuation.special

; Literals
(number) @number

(float) @number.float

(string) @string

(escape_sequence) @string.escape

(regex) @string.regexp

(boolean) @boolean

[
  (undef)
  (default)
] @variable.builtin

; Comments
(comment) @comment @spell
