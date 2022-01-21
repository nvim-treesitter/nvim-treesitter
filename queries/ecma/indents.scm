[
  (object)
  (array)
  (arguments)
  (statement_block)
  (object_pattern)
  (class_body)
  (method_definition)
  (named_imports)
  (binary_expression)
  (return_statement)
  (template_substitution)
  (expression_statement (call_expression))
  (export_clause)
  (switch_statement)
  (switch_case)
] @indent


(statement_block "}" @indent_end)

[
  (arguments (object))
  "("
  ")"
  "{"
  "}"
  "["
  "]"
] @branch

[
  (comment)
  (template_string)
] @ignore
