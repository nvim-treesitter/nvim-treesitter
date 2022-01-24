[
  (array_creation_expression)
  (compound_statement)
  (declaration_list)
  (binary_expression)
  (return_statement)
] @indent

[
  ")"
  "}"
  "]"
] @branch

[
  (comment)
] @ignore

(compound_statement "}" @indent_end)
([
  (arguments)
  (formal_parameters)
] @aligned_indent
  (#set! "delimiter" "()"))
