((function_call_expr) @_fn
  (#not-has-parent? @_fn parenthesized_expr)) @fold

[
  (case_of_branch)
  (case_of_expr)
  (value_declaration)
  (type_declaration)
  (type_alias_declaration)
  (list_expr)
  (record_expr)
  (parenthesized_expr)
  (import_clause)+
] @fold
