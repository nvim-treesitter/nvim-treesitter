; Indentation queries for CEL (Common Expression Language).
; Marks nodes that should increase or decrease indentation level.
; Indent after opening delimiters of collection literals and function arguments
[
  (map_expression)
  (list_expression)
  (struct_expression)
  (arguments)
] @indent.begin

; Dedent before closing delimiters
[
  "}"
  "]"
  ")"
] @indent.dedent
