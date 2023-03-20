[
  (meta_map)
  (map)
  (imap)
  (array)
] @indent.begin

[
  "]"
  "}"
  ">"
] @indent.end

[ "{" "}" ] @indent.branch

[ "[" "]" ] @indent.branch

[ "<" ">" ] @indent.branch

[
  (ERROR)
  (comment)
] @indent.auto
