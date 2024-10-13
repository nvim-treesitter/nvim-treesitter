; Keywords
[
  "if"
  "then"
  "else"
  "let"
  "in"
] @keyword.conditional

(case) @keyword.conditional

(of) @keyword.conditional

(colon) @operator

(backslash) @operator

(as) @keyword

(port) @keyword

(exposing) @keyword

(alias) @keyword

(infix) @keyword

(arrow) @operator

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

(operator_identifier) @operator

(eq) @operator

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

(import) @keyword.import

(module) @keyword.import

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

; comments
(line_comment) @comment

(block_comment) @comment

; strings
(string_escape) @string.escape

(open_quote) @string

(close_quote) @string

(regular_string_part) @string

(open_char) @character

(close_char) @character
