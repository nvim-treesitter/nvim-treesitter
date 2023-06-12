[
  (compound_statement)
  (loop_statement)
  (struct_declaration)
] @indent.begin

((parameter_list) @indent.begin
  (#set! indent.immediate)
  (#set! indent.start_at_same_line))

(function_declaration
  "(" @indent.begin
  (#set! indent.immediate))

(ERROR
  "fn"
  (identifier)
  "(" @indent.begin
  (#set! indent.immediate))

(compound_statement
  "}" @indent.end)

(loop_statement
  "}" @indent.end)

(function_declaration
  ")" @indent.end)

(struct_declaration
  "}" @indent.end)

[
  "else"
  ")"
  "}"
] @indent.branch

[
  (line_comment)
  (block_comment)
] @indent.auto
