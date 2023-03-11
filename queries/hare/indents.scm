[
  (enum_type)
  (struct_type)
  (tuple_type)
  (union_type)

  (block)
  (for_statement)
  (call_expression)
  (case)

  (array_literal)
  (struct_literal)
  (tuple_literal)
] @indent

(if_statement
   ("(" condition: (_) ")") @indent)

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
  (concatenated_string)
] @auto
