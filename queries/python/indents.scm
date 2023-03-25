[
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
 (#set! indent.dedent_hanging_closing 1)
)
((dictionary) @indent.align
 (#set! indent.open_delimiter "{")
 (#set! indent.close_delimiter "}")
 (#set! indent.dedent_hanging_closing 1)
)
((set) @indent.align
 (#set! indent.open_delimiter "{")
 (#set! indent.close_delimiter "}")
 (#set! indent.dedent_hanging_closing 1)
)

((match_statement) @indent.begin
 (#set! indent.immediate 1))
((case_clause) @indent.begin
 (#set! indent.immediate 1))
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
 (#set! indent.close_delimiter ")")
 (#set! indent.dedent_hanging_closing 1))
((parameters) @indent.align
 (#set! indent.open_delimiter "(")
 (#set! indent.close_delimiter ")")
 (#set! indent.avoid_last_matching_next 1))
((tuple) @indent.align
 (#set! indent.open_delimiter "(")
 (#set! indent.close_delimiter ")")
 (#set! indent.dedent_hanging_closing 1))
((import_from_statement "(" _ ")") @indent.align 
 (#set! indent.open_delimiter "(")
 (#set! indent.close_delimiter ")")
 (#set! indent.dedent_hanging_closing 1))

(ERROR "[" @indent.align (#set! indent.open_delimiter "[") (#set! indent.close_delimiter "]") . (_)) 

(ERROR "{" @indent.align (#set! indent.open_delimiter "{") (#set! indent.close_delimiter "}") . (_)) 

(parenthesized_expression ")" @indent.end)
(generator_expression ")" @indent.end)
(list_comprehension "]" @indent.end)
(set_comprehension "}" @indent.end)
(dictionary_comprehension "}" @indent.end)

(tuple_pattern ")" @indent.end)
(list_pattern "]" @indent.end)

((return_statement) @indent.end
 (#set! indent.after 1))
((raise_statement) @indent.end
 (#set! indent.after 1))
((break_statement) @indent.end
 (#set! indent.after 1))
((continue_statement) @indent.end
 (#set! indent.after 1))

(
 (except_clause
  "except" @indent.branch
  (_) @indent.begin)
)

(
 (finally_clause
  "finally" @indent.branch
  (_) @indent.begin)
)

(
 (elif_clause
  "elif" @indent.branch
  consequence: (_) @indent.begin)
)

(
 (else_clause
  "else" @indent.branch
  body: (_) @indent.begin
 )
)

(string) @indent.auto

