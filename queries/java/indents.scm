[
  (class_body)
  (enum_body)
  (interface_body)
  (constructor_body)
  (block)
  (switch_block)
  (array_initializer)
  (argument_list)
  (formal_parameters)
] @indent.begin

(expression_statement (method_invocation) @indent.begin)

[
  "("
  ")"
  "{"
  "}"
  "["
  "]"
] @indent.branch

"}" @indent.end

(line_comment) @indent.ignore

[
  (ERROR)
  (block_comment)
] @indent.auto

