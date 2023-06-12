[
  (braced_expression)
  (parenthesized_expression)
  (call)
  "special"
  "|>"
  "if"
  "else"
  "while"
  "repeat"
  "for"
] @indent.begin

(binary_operator
  operator: (_)) @indent.begin

[
  "}"
  ")"
] @indent.branch

((parameters
  (parameter
    name: (identifier))) @indent.align
  (#set! indent.open_delimiter "(")
  (#set! indent.close_delimiter ")"))

[
  ")"
  "}"
] @indent.end

(comment) @indent.ignore
