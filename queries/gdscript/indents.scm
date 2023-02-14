[
  (if_statement)

  (for_statement)
  (while_statement)

  (parenthesized_expression)

  (function_definition)
  (class_definition)
] @indent

((arguments) @aligned_indent
 (#set! "delimiter" "()"))
((parameters) @aligned_indent
 (#set! "delimiter" "()"))

[
  ")"
  "]"
  "}"
  (elif_clause)
  (else_clause)
] @branch
