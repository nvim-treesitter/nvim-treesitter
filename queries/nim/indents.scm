; NOTE: we have to treat (elif_branch) and (else_branch) different depending
; on context, since they can also appear as part of (case)

((if
  alternative: (elif_branch)* @indent.branch
  alternative: (else_branch)? @indent.branch) @indent.begin
  (#set! indent.immediate 1))

((when
  alternative: (elif_branch)* @indent.branch
  alternative: (else_branch)? @indent.branch) @indent.begin
  (#set! indent.immediate 1))

(case
  (of_branch) @indent.begin
  (#set! indent.immediate 1))

(case
  (elif_branch) @indent.begin
  (#set! indent.immediate 1))

(case
  (else_branch) @indent.begin
  (#set! indent.immediate 1))

(try
  (except_branch)? @indent.branch
  (finally_branch)? @indent.branch
  (#set! indent.immediate 1)) @indent.begin

(variant_declaration
  (of_branch) @indent.begin
  (#set! indent.immediate 1))

(variant_declaration
  (else_branch) @indent.begin
  (#set! indent.immediate 1))

((conditional_declaration
  alternative: (elif_branch)* @indent.branch
  alternative: (else_branch)? @indent.branch) @indent.begin
  (#set! indent.immediate 1))

([
  (const_section)
  (let_section)
  (var_section)
  (type_section)
  (using_section)

  (object_declaration)
  (tuple_type)
  (enum_declaration)

  (for)
  (while)
  (block)
  (static_statement)

  (do_block)
  (call
    (argument_list
      (statement_list)))

] @indent.begin
(#set! indent.immediate 1))

((proc_declaration body: "=" @indent.begin body: (statement_list) @indent.begin)
(#set! indent.immediate 1))
((func_declaration body: "=" @indent.begin body: (statement_list) @indent.begin)
(#set! indent.immediate 1))
((method_declaration body: "=" @indent.begin body: (statement_list) @indent.begin)
(#set! indent.immediate 1))
((iterator_declaration body: "=" @indent.begin body: (statement_list) @indent.begin)
(#set! indent.immediate 1))
((converter_declaration body: "=" @indent.begin body: (statement_list) @indent.begin)
(#set! indent.immediate 1))
((template_declaration body: "=" @indent.begin body: (statement_list) @indent.begin)
(#set! indent.immediate 1))
((macro_declaration body: "=" @indent.begin body: (statement_list) @indent.begin)
(#set! indent.immediate 1))

(proc_expression "=" @indent.begin body: (statement_list) @indent.begin)
(func_expression "=" @indent.begin body: (statement_list) @indent.begin)
(iterator_expression "=" @indent.begin body: (statement_list) @indent.begin)

[
  (break_statement)
  (continue_statement)
] @indent.dedent

; NOTE: `var` keyword is parsed as (var_type) until identifier list follows
((var_type "var") @indent.begin
  (#set! indent.immediate 1))

; NOTE: `enum` keyword is parsed as (enum_type) until identifier list follows
((enum_type "enum") @indent.begin
  (#set! indent.immediate 1))

(array_construction "]" @indent.dedent @indent.branch) @indent.begin
(tuple_construction ")" @indent.dedent @indent.branch) @indent.begin
(curly_construction "}" @indent.dedent @indent.branch) @indent.begin

(tuple_type (field_declaration_list "]" @indent.dedent @indent.branch)) @indent.begin

(parenthesized ")" @indent.dedent @indent.branch) @indent.begin

(generic_parameter_list "]" @indent.dedent @indent.branch) @indent.begin
(parameter_declaration_list ")" @indent.dedent @indent.branch) @indent.begin

(bracket_expression "]" @indent.dedent @indent.branch) @indent.begin
(argument_list ")" @indent.dedent @indent.branch) @indent.begin

(tuple_deconstruct_declaration ")" @indent.dedent @indent.branch) @indent.begin

(pragma_list ["}" ".}"] @indent.dedent @indent.branch) @indent.begin

[
  (ERROR "(")
  (ERROR "[")
  (ERROR "{")
  (ERROR "{.")
] @indent.begin

[
  (interpreted_string_literal)
  (long_string_literal)
  (raw_string_literal)
  (generalized_string)
] @indent.auto
