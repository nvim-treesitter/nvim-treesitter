[
  (class_body)
  (function_body)
  (declaration (initializers))
  (switch_block)
  (if_statement)
  (formal_parameter_list)
  (formal_parameter)
  (list_literal)
  (return_statement)
  (arguments)
  (try_statement)
] @indent.begin

[
  "("
  ")"
  "{"
  "}"
  "["
  "]"
] @indent.branch

[
 "}"
] @indent.end

; this one is for dedenting the else block
(if_statement (block) @indent.branch)
; Issue #4637
(function_expression_body (block) @indent.branch)

(comment) @indent.ignore
