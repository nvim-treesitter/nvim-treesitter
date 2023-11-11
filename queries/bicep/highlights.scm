; Includes
(import_statement
  "import" @keyword.import)

(import_with_statement
  "import" @keyword.import
  "with" @keyword.import)

; Namespaces
(module_declaration
  (identifier) @module)

; Builtins
(primitive_type) @type.builtin

((member_expression
  object: (identifier) @type.builtin)
  (#eq? @type.builtin "sys"))

; Functions
(call_expression
  function: (identifier) @function.call)

; Properties
(object_property
  (identifier) @property
  ":" @punctuation.delimiter
  (_))

(object_property
  (compatible_identifier) @property
  ":" @punctuation.delimiter
  (_))

(property_identifier) @property

; Attributes
(decorator
  "@" @attribute)

(decorator
  (call_expression
    (identifier) @attribute))

(decorator
  (call_expression
    (member_expression
      object: (identifier) @attribute
      property: (property_identifier) @attribute)))

; Types
(type_declaration
  (identifier) @type)

(type_declaration
  (identifier)
  "="
  (identifier) @type)

(type_declaration
  (identifier)
  "="
  (array_type
    (identifier) @type))

(type
  (identifier) @type)

(resource_declaration
  (identifier) @type)

(resource_expression
  (identifier) @type)

; Parameters
(parameter_declaration
  (identifier) @variable.parameter
  (_))

(call_expression
  function: (_)
  (arguments
    (identifier) @variable.parameter))

(call_expression
  function: (_)
  (arguments
    (member_expression
      object: (identifier) @variable.parameter)))

; Variables
(variable_declaration
  (identifier) @variable
  (_))

(metadata_declaration
  (identifier) @variable
  (_))

(output_declaration
  (identifier) @variable
  (_))

(object_property
  (_)
  ":"
  (identifier) @variable)

(for_statement
  "for"
  (for_loop_parameters
    (loop_variable) @variable
    (loop_enumerator) @variable))

; Conditionals
"if" @keyword.conditional

(ternary_expression
  "?" @keyword.conditional.ternary
  ":" @keyword.conditional.ternary)

; Loops
(for_statement
  "for" @keyword.repeat
  "in"
  ":" @punctuation.delimiter)

; Keywords
[
  "module"
  "metadata"
  "output"
  "param"
  "resource"
  "existing"
  "targetScope"
  "type"
  "var"
] @keyword

; Operators
[
  "+"
  "-"
  "*"
  "/"
  "%"
  "||"
  "&&"
  "|"
  "=="
  "!="
  "=~"
  "!~"
  ">"
  ">="
  "<="
  "<"
  "??"
  "="
  "!"
] @operator

"in" @keyword.operator

; Literals
(string) @string

(import_string
  "'" @string
  (import_name) @module
  "@" @string.special.symbol
  (import_version) @string.special)

(escape_sequence) @string.escape

(number) @number

(boolean) @boolean

(null) @constant.builtin

; Misc
(compatible_identifier
  "?" @punctuation.special)

(nullable_return_type) @punctuation.special

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

[
  "."
  "::"
  "=>"
] @punctuation.delimiter

; Interpolation
(interpolation) @none

(interpolation
  "${" @punctuation.special
  "}" @punctuation.special)

(interpolation
  (identifier) @variable)

; Comments
[
  (comment)
  (diagnostic_comment)
] @comment @spell
