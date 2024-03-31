[
  (list_expression)
  (indented_string_expression)
  (let_expression)
  (if_expression)
  (binding)
  (parenthesized_expression)
] @indent.begin

((attrset_expression) @indent.begin
  (#not-has-parent? @indent.begin if_expression))

((rec_attrset_expression) @indent.begin
  (#not-has-parent? @indent.begin if_expression))

((binding
  "=" @indent.begin)
  (#set! indent.immediate 1))

(binding
  ";" @indent.end)

(parenthesized_expression
  ")" @indent.branch @indent.end)

(attrset_expression
  "}" @indent.branch @indent.end)

(rec_attrset_expression
  "}" @indent.branch @indent.end)

(list_expression
  "]" @indent.branch @indent.dedent)

(indented_string_expression
  "''" @indent.branch @indent.end .)

[
  "else"
  "in"
] @indent.branch

(let_expression
  body: (_) @indent.end @indent.dedent)

(string_fragment) @indent.ignore @indent.auto

(if_expression
  condition: (_) @indent.auto)

alternative: (if_expression) @indent.dedent

(interpolation) @indent.begin @indent.dedent

(interpolation
  "}" @indent.end @indent.branch)

(ERROR
  "then" @indent.begin)

(ERROR
  "then"
  .
  (formals) @indent.begin)

(ERROR
  "then"
  .
  (formals
    "}" @indent.branch @indent.end))

(ERROR
  "let") @indent.begin

(comment) @indent.ignore
