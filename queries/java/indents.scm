[
  (class_declaration)
  (class_body)
  (enum_declaration)
  (enum_body)
  (constructor_declaration)
  (constructor_body)
  (block)
  (switch_block)
  (array_initializer)
  (argument_list)
  (formal_parameters)
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
  ")"
] @indent_end

[(block_comment) (line_comment)] @ignore
