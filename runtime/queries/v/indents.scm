[
  (import_declaration)
  (const_declaration)
  (type_declaration)
  (type_initializer)
  (block)
  (map_init_expression)
  (call_expression)
  (parameter_list)
] @indent.begin

"}" @indent.branch

(parameter_list
  ")" @indent.branch)

[
  (line_comment)
  (block_comment)
] @indent.ignore
