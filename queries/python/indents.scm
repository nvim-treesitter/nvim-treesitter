[
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
] @indent.begin

((list) @indent.align
 (#set! indent.open_delimiter "[")
 (#set! indent.close_delimiter "]")
)
((dictionary) @indent.align
 (#set! indent.open_delimiter "{")
 (#set! indent.close_delimiter "}")
)
((set) @indent.align
 (#set! indent.open_delimiter "{")
 (#set! indent.close_delimiter "}")
)

((for_statement) @indent.begin
 (#set! indent.immediate 1))
((if_statement) @indent.begin
 (#set! indent.immediate 1))
((while_statement) @indent.begin
 (#set! indent.immediate 1))
((try_statement) @indent.begin
 (#set! indent.immediate 1))
(ERROR "try" ":" @indent.begin (#set! indent.immediate 1))
((function_definition) @indent.begin
 (#set! indent.immediate 1))
((class_definition) @indent.begin
 (#set! indent.immediate 1))
((with_statement) @indent.begin
 (#set! indent.immediate 1))
((match_statement) @indent.begin
 (#set! indent.immediate 1))
((case_clause) @indent.begin
 (#set! indent.immediate 1))

(if_statement
  condition: (parenthesized_expression) @indent.align
  (#set! indent.open_delimiter "(")
  (#set! indent.close_delimiter ")")
  (#set! indent.avoid_last_matching_next 1)
)
(while_statement
  condition: (parenthesized_expression) @indent.align
  (#set! indent.open_delimiter "(")
  (#set! indent.close_delimiter ")")
  (#set! indent.avoid_last_matching_next 1)
)

(ERROR "(" @indent.align (#set! indent.open_delimiter "(") (#set! indent.close_delimiter ")") . (_)) 
((argument_list) @indent.align
 (#set! indent.open_delimiter "(")
 (#set! indent.close_delimiter ")"))
((parameters) @indent.align
 (#set! indent.open_delimiter "(")
 (#set! indent.close_delimiter ")")
 (#set! indent.avoid_last_matching_next 1))
((tuple) @indent.align
 (#set! indent.open_delimiter "(")
 (#set! indent.close_delimiter ")"))

(ERROR "[" @indent.align (#set! indent.open_delimiter "[") (#set! indent.close_delimiter "]") . (_)) 

(ERROR "{" @indent.align (#set! indent.open_delimiter "{") (#set! indent.close_delimiter "}") . (_)) 

[
  (break_statement)
  (continue_statement)
  (raise_statement)
  (return_statement)
] @indent.dedent

(return_statement 
  [
    ; indent.align
    (list "]" @indent.dedent)
    (dictionary "}" @indent.dedent)
    (set "}" @indent.dedent)
    (tuple ")" @indent.dedent)
    (call
      arguments: (argument_list ")" @indent.dedent))
    (await
      (call
        arguments: (argument_list ")" @indent.dedent)))
  ] 
)

(return_statement
  [
    ; indent.begin -> dedent twice 
    (parenthesized_expression ")" @indent.dedent)
    (generator_expression ")" @indent.dedent)
    (list_comprehension "]" @indent.dedent)
    (set_comprehension "}" @indent.dedent)
    (dictionary_comprehension "}" @indent.dedent)
    ; (tuple_pattern "(" @indent.begin ")" @indent.dedent)
    ; (list_pattern "]" @indent.dedent)

    ; functions
    ; (call)
    ; (await)
  ]
)

(raise_statement
  (call
    arguments: (argument_list ")" @indent.dedent)))

(parenthesized_expression 
  ")" @indent.end
  (#not-has-parent? @indent.end return_statement raise_statement))
(generator_expression 
  ")" @indent.end
  (#not-has-parent? @indent.end return_statement raise_statement))
(list_comprehension 
  "]" @indent.end
  (#not-has-parent? @indent.end return_statement raise_statement))
(set_comprehension 
  "}" @indent.end
  (#not-has-parent? @indent.end return_statement raise_statement))
(dictionary_comprehension 
  "}" @indent.end
  (#not-has-parent? @indent.end return_statement raise_statement))

(tuple_pattern ")" @indent.end)
(list_pattern "]" @indent.end)


[
  ")"
  "]"
  "}"
  (elif_clause)
  (else_clause)
  (except_clause)
  (finally_clause)
] @indent.branch

(string) @indent.auto

