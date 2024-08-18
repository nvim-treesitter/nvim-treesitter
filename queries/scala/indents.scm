[
  (template_body)
  (block)
  (parameters)
  (arguments)
  (match_expression)
  (splice_expression)
  (import_declaration)
  (function_definition)
  (case_clause)
  (colon_argument)
  (ERROR
    ":")
  (ERROR
    "=")
  (ERROR
    "for")
  "match"
  ":"
  "="
] @indent.begin

(arguments
  ")" @indent.end)

"}" @indent.end

"end" @indent.end

[
  ")"
  "]"
  "}"
] @indent.branch

(block_comment) @indent.auto
