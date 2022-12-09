[
  (array_creation_expression)
  (compound_statement)
  (declaration_list)
  (binary_expression)
  (return_statement)
  (arguments)
  (formal_parameters)
  (enum_declaration_list)
  (switch_block)
  (match_block)
  (case_statement)
  "["
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
