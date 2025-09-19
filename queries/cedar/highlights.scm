
; Main policy structure
(policy) @keyword
(effect) @keyword
(scope) @keyword

; Expressions
(binary_expression) @operator
(unary_expression) @operator
(call_expression) @function.call
(ext_fun_call) @function.call
(selector_expression) @property
(has_expression) @operator
(like_expression) @operator
(contains_expression) @operator
(contains_all_expression) @operator
(is_expression) @operator

; Literals
(record_literal) @punctuation.bracket
(set_literal) @punctuation.bracket
(entity) @constant

; Conditions
(condition) @keyword

; Annotations
(annotation) @attribute

; Constraints
(principal_constraint) @variable.builtin
(action_constraint) @variable.builtin
(resource_constraint) @variable.builtin

; Basic punctuation
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
  ";"
  "."
  "::"
  "@"
] @punctuation.delimiter
