[
  (braced_expression)
  (parenthesized_expression)
  (call)
  "if"
  "else"
  "while"
  "repeat"
  "for"
] @indent.begin

(binary_operator
  rhs: (_) @_no_indent
  (#not-kind-eq? @_no_indent function_definition)) @indent.begin

[
  "}"
  ")"
] @indent.branch

((parameters
  .
  (parameter
    name: (identifier))) @indent.align
  (#set! indent.open_delimiter "(")
  (#set! indent.close_delimiter ")"))

[
  ")"
  "}"
] @indent.end

(comment) @indent.ignore
