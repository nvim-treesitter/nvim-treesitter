[
  (list)
  (dictionary)
  (set)

  (import_from_statement)

  (parenthesized_expression)
  (generator_expression)
  (list_comprehension)
  (set_comprehension)
  (dictionary_comprehension)

  (tuple_pattern)
  (list_pattern)
  (binary_operator)

  (lambda)

  (concatenated_string)
] @indent

((for_statement) @indent
 (#set! "immediate_indent" 1))
((if_statement) @indent
 (#set! "immediate_indent" 1))
((while_statement) @indent
 (#set! "immediate_indent" 1))
((try_statement) @indent
 (#set! "immediate_indent" 1))
((ERROR "try" ":") @indent
 (#set! "immediate_indent" 1))
((function_definition) @indent
 (#set! "immediate_indent" 1))
((class_definition) @indent
 (#set! "immediate_indent" 1))
((with_statement) @indent
 (#set! "immediate_indent" 1))

(if_statement
  condition: (parenthesized_expression) @aligned_indent
  (#set! "delimiter" "()")
  (#set! "final_line_indent" 1) ; parenthesized_expression already indented
)
(while_statement
  condition: (parenthesized_expression) @aligned_indent
  (#set! "delimiter" "()")
  (#set! "final_line_indent" 1) ; parenthesized_expression already indented
)

((ERROR "(" . (_)) @aligned_indent
 (#set! "delimiter" "()"))
((argument_list ")" @indent_end) @aligned_indent
 (#set! "delimiter" "()"))
((parameters) @aligned_indent
 (#set! "delimiter" "()")
 (#set! "final_line_indent" 1))
((tuple ")" @indent_end) @aligned_indent
 (#set! "delimiter" "()"))

(list "]" @indent_end)
(dictionary "}" @indent_end)
(set "}" @indent_end)

(parenthesized_expression ")" @indent_end)
(generator_expression ")" @indent_end)
(list_comprehension "]" @indent_end)
(set_comprehension "}" @indent_end)
(dictionary_comprehension "}" @indent_end)

(tuple_pattern ")" @indent_end)
(list_pattern "]" @indent_end)


(return_statement
  [
    (_) @indent_end 
    (_ (_) @indent_end .)
    (attribute 
      attribute: (_) @indent_end)
    "return" @indent_end
  ] .)

[
  ")"
  "]"
  "}"
  (elif_clause)
  (else_clause)
  (except_clause)
  (finally_clause)
] @branch

(string) @auto
