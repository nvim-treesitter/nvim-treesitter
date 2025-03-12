([
  (directive)
  (directive_start)
  (directive_end)
] @tag
  (#set! priority 101))

([
  (bracket_start)
  (bracket_end)
] @tag.delimiter
  (#set! priority 101))

((comment) @comment @spell
  (#set! priority 101))
