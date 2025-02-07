[
  (block)
  (decl_class)
  (decl_enum)
  (switch)
  (formal_parameters)
  (actual_parameters)
] @indent.begin

[
  "(" ")"
  "[" "]"
  "{" "}"
] @indent.branch

[
 ")"
 "]"
 "}"
] @indent.end

(comment_line) @indent.ignore

[
  (ERROR)
  (comment_block)
] @indent.auto
