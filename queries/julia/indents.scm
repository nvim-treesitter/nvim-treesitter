[
  (struct_definition)
  (macro_definition)
  (function_definition)
  (compound_statement)
  (if_statement)
  (try_statement)
  (for_statement)
  (while_statement)
  (let_statement)
  (quote_statement)
  (do_clause)
  (assignment)
  (for_binding)
  (call_expression)
  (parenthesized_expression)
  (tuple_expression)
  (comprehension_expression)
  (matrix_expression)
  (vector_expression)
] @indent.begin

[
  "end"
  ")"
  "]"
  "}"
] @indent.end

[
  "end"
  ")"
  "]"
  "}"
  (else_clause)
  (elseif_clause)
  (catch_clause)
  (finally_clause)
] @indent.branch

[
  (line_comment)
  (block_comment)
] @indent.ignore

((argument_list) @indent.align
  (#set! indent.open_delimiter "(")
  (#set! indent.close_delimiter ")"))

((curly_expression) @indent.align
  (#set! indent.open_delimiter "{")
  (#set! indent.close_delimiter "}"))
