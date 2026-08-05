[
  (template_body)
  (block)
  (parameters)
  (arguments)
  (match_expression)
  (splice_expression)
  (import_declaration)
  (function_definition)
  "match"
  ":"
  "="
] @indent.begin

(ERROR
  ":") @indent.begin

(ERROR
  "=") @indent.begin

(arguments
  ")" @indent.end)

"}" @indent.end

(end_marker) @indent.end

[
  ")"
  "]"
  "}"
] @indent.branch
