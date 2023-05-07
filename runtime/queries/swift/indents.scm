[
  (protocol_body)
  (class_body)
  (function_declaration)
  (computed_property)
  (subscript_declaration)

  (computed_getter)
  (computed_setter)

  (assignment)

  (control_transfer_statement) ; return ...
  (for_statement)
  (while_statement)
  (repeat_while_statement)
  (do_statement)
  (if_statement)
  (switch_statement)
  (guard_statement)

  (type_parameters) ; x<Foo>
  (tuple_type) ; (...)
  (array_type) ; [String]
  (dictionary_type); [Foo: Bar]

  (call_expression)
  (tuple_expression)
  (array_literal)
  (dictionary_literal)
  (lambda_literal) 
] @indent.begin

; @something(...)
((modifiers
  (attribute) @indent.begin))

(function_declaration
  (modifiers
    .
    (attribute)
    (_)* @indent.branch)
  .
  _ @indent.branch
  (#not-has-type? @indent.branch type_parameters parameter))


(ERROR
  [
    "<" 
    "{" 
    "(" 
    "["
  ]
) @indent.begin


; if-elseif
(if_statement
  (if_statement) @indent.dedent)

(switch_entry . _ @indent.branch)

(function_declaration ")" @indent.branch)

(type_parameters ">" @indent.branch @indent.end .)
(tuple_expression ")" @indent.branch @indent.end)
(value_arguments ")" @indent.branch @indent.end)
(tuple_type ")" @indent.branch @indent.end)
(modifiers
  (attribute ")" @indent.branch @indent.end))

[
  "}"
  "]"
] @indent.branch @indent.end


[
  ; (ERROR)
  (comment)
  (multiline_comment)
  (raw_str_part)
  (multi_line_string_literal)
] @indent.auto

(directive) @indent.ignore
