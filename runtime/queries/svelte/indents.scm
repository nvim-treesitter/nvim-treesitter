; inherits: html_tags
[
  (if_statement)
  (each_statement)
  (await_statement)
  (key_statement)
] @indent.begin

(if_end_expr
  "}" @indent.end)

(each_end_expr
  "}" @indent.end)

(await_end_expr
  "}" @indent.end)

(key_end_expr
  "}" @indent.end)

[
  (if_end_expr)
  (else_if_statement)
  (else_statement)
  (each_end_expr)
  (await_end_expr)
  (key_end_expr)
] @indent.branch
