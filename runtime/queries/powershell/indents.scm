(function_statement
  "}" @indent.branch) @indent.begin

(param_block
  [
    "param"
    "("
    ")"
  ] @indent.branch) @indent.begin

(script_block_expression
  "}" @indent.branch) @indent.begin

(statement_block
  "}" @indent.branch) @indent.begin

(switch_body
  "}" @indent.branch) @indent.begin

(array_expression
  ")" @indent.branch) @indent.begin

(hash_literal_expression
  "}" @indent.branch) @indent.begin

(class_statement
  "}" @indent.branch) @indent.begin

(class_method_definition
  "}" @indent.branch) @indent.begin

[
  "}"
  ")"
] @indent.end

[
  (comment)
  (string_literal)
  (ERROR)
] @indent.auto
