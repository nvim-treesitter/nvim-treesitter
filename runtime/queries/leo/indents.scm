[
  (array_expression)
  (assert_statement)
  (assignment_statement)
  (block)
  (constant_declaration)
  (expression_statement)
  (items_block)
  (loop_statement)
  (mapping_declaration)
  (parenthesized_expression)
  (record_declaration)
  (return_statement)
  (struct_declaration)
  (struct_expression)
  (tuple_expression)
  (variable_declaration)
] @indent.begin

((function_parameters) @indent.align
  (#set! indent.open_delimiter "(")
  (#set! indent.close_delimiter ")"))

((function_arguments) @indent.align
  (#set! indent.open_delimiter "(")
  (#set! indent.close_delimiter ")"))

(parenthesized_expression
  ")" @indent.branch)

(function_parameters
  ")" @indent.branch)

(function_arguments
  ")" @indent.branch)

(record_declaration
  "}" @indent.branch)

(struct_declaration
  "}" @indent.branch)

(struct_expression
  "}" @indent.branch)

(array_expression
  "]" @indent.branch)

(tuple_expression
  ")" @indent.branch)

(items_block
  "}" @indent.branch)

(block
  "}" @indent.branch)

[
  (comment)
  (ERROR)
] @indent.auto
