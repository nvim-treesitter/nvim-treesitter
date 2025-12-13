(block) @indent.begin

"}" @indent.end

[
  "{"
  "}"
] @indent.branch

[
  (comment)
  (multiline_value)
] @indent.ignore
