[
  (ast_block)
  (array)
  (expr)
  (json_array)
  (json_object)
  (parenthesized_expression)
] @indent

; TODO: can't get this to work, goal is to indent at the property ":" prefix
; ((list (identifier) (property)) @aligned_indent
;   (#set! "delimiter" ":"))

[")" "}" "]"] @indent_end

[ "{" "}" ] @branch

[ "(" ")" ] @branch

[ "[" "]" ] @branch

[
 (ERROR)
 (comment)
] @auto
