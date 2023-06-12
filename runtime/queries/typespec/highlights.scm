(identifier_or_member_expression) @type

[
  "is"
  "extends"
  "valueof"
] @keyword.operator

[
  "namespace"
  "model"
  "scalar"
  "interface"
  "enum"
  "union"
  "alias"
] @keyword.type

[
  "op"
  "fn"
  "dec"
] @keyword.function

"extern" @keyword.modifier

[
  "import"
  "using"
] @keyword.import

[
  "("
  ")"
  "{"
  "}"
  "<"
  ">"
  "["
  "]"
] @punctuation.bracket

[
  ","
  ";"
  "."
  ":"
] @punctuation.delimiter

[
  "|"
  "&"
  "="
  "..."
] @operator

"?" @punctuation.special

[
  (single_line_comment)
  (multi_line_comment)
] @comment @spell

[
  (quoted_string_literal)
  (triple_quoted_string_literal)
] @string

(boolean_literal) @boolean

[
  (decimal_literal)
  (hex_integer_literal)
  (binary_integer_literal)
] @number

(escape_sequence) @string.escape

(builtin_type) @type.builtin

(decorator
  "@" @attribute
  name: (identifier_or_member_expression) @attribute)

(augment_decorator_statement
  name: (identifier_or_member_expression) @attribute)

(using_statement
  module: (identifier_or_member_expression) @module)

(namespace_statement
  name: (identifier_or_member_expression) @module)

(model_statement
  name: (identifier) @type)

(model_property
  name: (identifier) @variable.member)

(union_statement
  name: (identifier) @type)

(union_variant
  name: (identifier) @variable.member)

(scalar_statement
  name: (identifier) @type)

(interface_statement
  name: (identifier) @type)

(enum_statement
  name: (identifier) @type)

(enum_member
  name: (identifier) @constant)

(operation_statement
  name: (identifier) @function)

(template_parameter
  name: (identifier) @type)

(alias_statement
  name: (identifier) @type)

(decorator_declaration_statement
  name: (identifier) @attribute)

(function_parameter
  name: (identifier) @variable.parameter)

(operation_arguments
  (model_property
    name: (identifier) @variable.parameter))
