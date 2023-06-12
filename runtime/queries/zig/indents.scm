[
  (block)
  (struct_declaration)
  (enum_declaration)
  (union_declaration)
  (switch_expression)
  (if_expression)
  (while_expression)
  (for_expression)
  (initializer_list)
] @indent.begin

(block
  "}" @indent.end)

[
  "("
  ")"
  "["
  "]"
  "{"
  "}"
] @indent.branch

[
  (comment)
  (multiline_string)
] @indent.ignore
