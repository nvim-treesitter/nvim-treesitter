; Keywords
[
  (as)
  (port)
  (exposing)
  (alias)
  (infix)
] @keyword

; Keywords - Conditionals
[
  "if"
  "then"
  "else"
  "let"
  "in"
  (when)
  (is)
] @keyword.conditional

; Keywords - Imports
[
  (import)
  (module)
] @keyword.import

; Operators
[
  (arrow)
  (backslash)
  (colon)
  (operator_identifier)
  (eq)
] @operator

; Punctuation
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
  (dot)
] @punctuation.delimiter

; Comments
[
  (block_comment)
  (line_comment)
] @comment

; Strings
[
  (close_quote)
  (open_quote)
  (regular_string_part)
] @string

; Strings - Escape
(string_escape) @string.escape

; Characters
[
  (open_char)
  (close_char)
] @character

(type_annotation
  (lower_case_identifier) @function)

(port_annotation
  (lower_case_identifier) @function)

(function_declaration_left
  (lower_case_identifier) @function)

(function_call_expr
  target: (value_expr) @function)

(field_access_expr
  (value_expr
    (value_qid) @variable.member))

(lower_pattern) @variable.parameter

(record_base_identifier) @variable

(number_constant_expr) @number

(type) @keyword.type

(type_declaration
  (upper_case_identifier) @type)

(type_ref) @type

(type_alias_declaration
  name: (upper_case_identifier) @type)

(union_variant
  (upper_case_identifier) @type)

(union_pattern
  constructor: (upper_case_qid
    (upper_case_identifier) @label
    (dot)
    (upper_case_identifier) @type))

(union_pattern
  constructor: (upper_case_qid
    (upper_case_identifier) @type))

(value_expr
  (upper_case_qid
    (upper_case_identifier)) @type)
