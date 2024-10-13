; Keywords
[
  "if"
  "then"
  "else"
  "let"
  "in"
] @keyword.control

(case) @keyword.control

(of) @keyword.control

(colon) @keyword.other

(backslash) @keyword.other

(as) @keyword.other

(port) @keyword.other

(exposing) @keyword.other

(alias) @keyword.other

(infix) @keyword.other

(arrow) @keyword.operator.arrow

(port) @keyword.other.port

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
    (value_qid)) @local.function)

(lower_pattern) @local.function

(record_base_identifier) @local.function

(operator_identifier) @keyword.operator

(eq) @keyword.operator.assignment

"(" @punctuation.section.braces

")" @punctuation.section.braces

"|" @keyword.other

"," @punctuation.separator.comma

(import) @keyword.import

(module) @keyword.import

(number_constant_expr) @constant.numeric

(type) @keyword.type

(type_declaration
  (upper_case_identifier) @storage.type)

(type_ref) @storage.type

(type_alias_declaration
  name: (upper_case_identifier) @storage.type)

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
