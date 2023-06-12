[
  (block)
  (class_body)
  (enum_body)
  (switch_body)
  (array_creation)
  (formal_parameters)
  (actual_parameters)
] @indent.begin

[
  "("
  ")"
  "["
  "]"
  "}"
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
