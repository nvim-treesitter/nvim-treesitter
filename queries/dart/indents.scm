[
  (class_body)
  (function_body)
  (function_expression_body)
  (declaration (initializers))
  (switch_block)
  (if_statement)
  (formal_parameter_list)
  (formal_parameter)
  (list_literal)
  (return_statement)
  (arguments)
] @indent

[
  "("
  ")"
  "{"
  "}"
  "["
  "]"
] @branch

[
 "}"
] @indent_end

; this one is for dedenting the else block
(if_statement (block) @branch)

(comment) @ignore
