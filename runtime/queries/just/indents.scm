; Source: https://github.com/IndianBoy42/tree-sitter-just/blob/main/queries/just/indents.scm
[
  (recipe)
  (string)
  (external_command)
] @indent.begin

(string
  [
    "'''"
    "\"\"\""
  ] @indent.branch @indent.end)

(comment) @indent.auto
