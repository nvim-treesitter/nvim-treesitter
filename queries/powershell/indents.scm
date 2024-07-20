[
  "}"
  ")"
] @indent.end

(function_statement) @indent.begin

(function_statement
  "}" @indent.end)

(param_block) @indent.begin

(param_block
  ")" @indent.end)

(script_block_expression) @indent.begin

(script_block_expression
  "}" @indent.end)

(statement_block) @indent.begin

(statement_block
  "}" @indent.end)

(switch_body) @indent.begin

(switch_body
  "}" @indent.end)

(array_expression) @indent.begin

(array_expression
  ")" @indent.end)

(hash_literal_expression) @indent.begin

(hash_literal_expression
  "}" @indent.end)

(class_statement) @indent.begin

(class_statement
  "}" @indent.end)

(class_method_definition) @indent.begin

(class_method_definition
  "}" @indent.end)

[
  (comment)
  (string_literal)
  (ERROR)
] @indent.auto
