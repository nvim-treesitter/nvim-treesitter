[
  (import_spec_list)
  (field)
] @indent

[
  "}"
  "]"
  ")"
] @indent_end

[ "{" "}" ] @branch

[ "[" "]" ] @branch

[ "(" ")" ] @branch

[
  (ERROR)
  (comment)
] @auto
