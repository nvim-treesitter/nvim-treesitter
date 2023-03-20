[
  (list)
  (dictionary)
  (set)

  (for_statement)
  (if_statement)
  (while_statement)
  (with_statement)

  (parenthesized_expression)
  (dictionary_comprehension)
  (list_comprehension)
  (set_comprehension)

  (tuple_pattern)
  (list_pattern)
  (binary_operator)

  (lambda)
  (function_definition)
] @indent

(if_statement
  condition: (parenthesized_expression) @aligned_indent
  (#set! "open_delimiter" "(")
  (#set! "close_delimiter" ")")
)
((ERROR "(" . (_)) @aligned_indent
 (#set! "open_delimiter" "(")
 (#set! "close_delimiter" ")"))
((argument_list) @aligned_indent
 (#set! "open_delimiter" "(")
 (#set! "close_delimiter" ")"))
((argument_list) @aligned_indent
 (#set! "open_delimiter" "(")
 (#set! "close_delimiter" ")"))
((parameters) @aligned_indent
 (#set! "open_delimiter" "(")
 (#set! "close_delimiter" ")"))
((tuple) @aligned_indent
 (#set! "open_delimiter" "(")
 (#set! "close_delimiter" ")"))

[
  ")"
  "]"
  "}"
  (elif_clause)
  (else_clause)
] @branch

(string) @auto
