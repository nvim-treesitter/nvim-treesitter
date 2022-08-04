[
  (array_creation_expression)
  (compound_statement)
  (declaration_list)
  (binary_expression)
  (return_statement)
  (arguments)
  (formal_parameters)
] @indent

[
  ")"
  "}"
  "]"
] @branch

[
  (comment)
] @auto

(compound_statement "}" @indent_end)

(ERROR) @auto
