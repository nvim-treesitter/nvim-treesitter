[
  (brace_list)
  (paren_list)
  (special)
  (pipe)
  "|>"
  "if"
  "else"
  "while"
  "repeat"
  "for"
] @indent

[
  "}"
  ")"
] @branch


((call) @aligned_indent
  (#set! "delimiter" "()"))

((formal_parameters (identifier)) @aligned_indent
 (#set! "delimiter" "()"))

[
  ")"
  "}"
] @indent_end

[
  (comment)
] @ignore
