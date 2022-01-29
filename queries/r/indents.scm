[
  (call)
  (brace_list)
  (paren_list)
  (special)
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


(pipe
  (call) @aligned_indent
  (#set! "delimiter" "()"))

((special)
  (call) @aligned_indent
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
