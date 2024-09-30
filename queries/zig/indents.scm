[
  (block)
  (switch_expression)
  (initializer_list)
  (struct_declaration)
  (opaque_declaration)
  (enum_declaration)
  (union_declaration)
] @indent.begin

(block
  "}" @indent.end)

[
  ")"
  "]"
  "}"
] @indent.branch

[
  (comment)
  (multiline_string)
] @indent.ignore
