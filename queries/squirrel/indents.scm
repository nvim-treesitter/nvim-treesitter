[
  (class_declaration)
  (function_declaration)
  (enum_declaration)

  (array)
  (block)
  (table)
  (anonymous_function)
  (parenthesized_expression)

  (while_statement)
  (switch_statement)
  (for_statement)
  (foreach_statement)
  ; (try_statement)
  (catch_statement)
] @indent

(
  (if_statement)
  (ERROR "else") @indent
)

(if_statement
  condition: (_) @indent)

(if_statement
  consequence: (_)
  (else_statement) @indent)

(do_while_statement
  "do"
  (_) @indent)

(try_statement
  (_) @indent
  (catch_statement) @indent)

[ "{" "}" ] @branch

[ "(" ")" ] @branch

[ "[" "]" ] @branch

[
  "}"
  ")"
  "]"
] @indent_end

[
  (ERROR)
  (comment)

  (string)
  (verbatim_string)
] @auto
