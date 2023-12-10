[
 (record_declaration) 
 (struct_declaration)
 (mapping_declaration)
 (constant_declaration)
 (return_statement)
 (expression_statement)
 (variable_declaration)
 (loop_statement)
 (assignment_statement)
 (assert_statement)
 (struct_expression)
 (array_expression)
 (tuple_expression)
 (parenthesized_expression)
 (items_block)
 (block)
] @indent.begin

; if "if" statement and conditional statement are in separate lines 
; conditional should be indented and when the conditional block 
; starts dedented
(branch
  (block "{" @indent.end)) @indent.begin

((function_parameters) @indent.align
  (#set! indent.open_delimiter "(")
  (#set! indent.close_delimiter ")"))

[
 (comment)
 (ERROR)
] @indent.auto
