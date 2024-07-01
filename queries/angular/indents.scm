; inherits: html_tags

[
  (if_statement)
  (defer_statement)
  (for_statement)
  (switch_statement)
  (case_statement)
  (default_statement)
] @indent.begin

[
  (if_end_expression)
  (defer_end_expression)
  (for_end_expression)
  (switch_end_expression)
  (case_end_expression)
  (default_end_expression)
  (else_if_statement)
  (else_statement)
  (placeholder_statement)
  (loading_statement)
  (error_statement)
  (empty_statement)
] @indent.branch

[
  (if_end_expression)
  (defer_end_expression)
  (for_end_expression)
  (switch_end_expression)
  (case_end_expression)
  (default_end_expression)
] @indent.end
