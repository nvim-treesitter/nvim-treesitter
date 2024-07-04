[
  (arguments)
  (array)
  (binary_expression)
  (class_body)
  (export_clause)
  (formal_parameters)
  (named_imports)
  (object)
  (object_pattern)
  (parenthesized_expression)
  (return_statement)
  (statement_block)
  (switch_case)
  (switch_default)
  (switch_statement)
  (template_substitution)
  (ternary_expression)
] @indent.begin

(arguments
  (call_expression) @indent.begin)

(binary_expression
  (call_expression) @indent.begin)

(expression_statement
  (call_expression) @indent.begin)

(arrow_function
  body: (_) @_body
  (#not-kind-eq? @_body "statement_block")) @indent.begin

(assignment_expression
  right: (_) @_right
  (#not-kind-eq? @_right "arrow_function" "function")) @indent.begin

(variable_declarator
  value: (_) @_value
  (#not-kind-eq? @_value "arrow_function" "call_expression" "function")) @indent.begin

(arguments
  ")" @indent.end)

(object
  "}" @indent.end)

(statement_block
  "}" @indent.end)

[
  (arguments
    (object))
  ")"
  "}"
  "]"
] @indent.branch

(statement_block
  "{" @indent.branch)

((parenthesized_expression
  "("
  (_)
  ")" @indent.end) @_outer
  (#not-has-parent? @_outer if_statement))

[
  "}"
  "]"
] @indent.end

(template_string) @indent.ignore

[
  (comment)
  (ERROR)
] @indent.auto

(if_statement
  consequence: (_) @indent.dedent
  (#not-kind-eq? @indent.dedent statement_block)) @indent.begin
