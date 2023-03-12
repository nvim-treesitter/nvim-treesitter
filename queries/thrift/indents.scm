(definition) @indent

((parameters (parameter)) @aligned_indent
  (#set! "delimiter" "()"))

"}" @indent_end

[ "{" "}" ] @branch

[ "(" ")" ] @branch

[
  (ERROR)
  (comment)
] @auto
