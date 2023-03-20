(definition) @indent

((parameters (parameter)) @aligned_indent
 (#set! "open_delimiter" "(")
 (#set! "close_delimiter" ")"))

"}" @indent_end

[ "{" "}" ] @branch

[ "(" ")" ] @branch

[
  (ERROR)
  (comment)
] @auto
