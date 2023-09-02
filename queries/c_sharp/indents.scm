[
 (property_declaration)
 ; (field_declaration)
 (variable_declaration)
 (accessor_declaration)

 ; (declaration_list)

 (parameter_list)
 (type_parameter_list)
 (accessor_list)
 (attribute_argument_list)
 (base_list)
 (argument_list)

 (binary_expression)
 (expression_statement)
 (return_statement)
 (local_declaration_statement)
 (local_function_statement)
 (yield_statement)
 (fixed_statement)
 (unsafe_statement)
 (labeled_statement)
 (for_each_statement)
 (for_statement)
 (if_statement)
 (switch_expression)
 (switch_section)
 (switch_statement)
 (while_statement)
 (lambda_expression)
 (do_statement)
 (checked_statement)
 (try_statement)
 (using_statement)
 (local_function_statement)
 (object_creation_expression)
 (array_creation_expression)
 (implicit_object_creation_expression)

 ] @indent.begin

(method_declaration body: _ @indent.begin)
(namespace_declaration body: _ @indent.begin)
(record_declaration body: _ @indent.begin)
(class_declaration body: _ @indent.begin)
(struct_declaration body: _ @indent.begin)
(constructor_declaration body: _ @indent.begin)
(interface_declaration body: _ @indent.begin)
(enum_declaration body: _ @indent.begin)

(property_declaration (accessor_list "{" @indent.branch) @indent.dedent)

(switch_section
  (case_switch_label) (case_switch_label) @indent.branch)


(if_statement (block "{" @indent.branch))
(if_statement alternative: (if_statement) @indent.dedent)

(while_statement
  (block "{" @indent.branch))

(array_creation_expression
  (initializer_expression "{" @indent.branch))
(object_creation_expression
  (initializer_expression "{" @indent.branch))
(implicit_object_creation_expression
  (initializer_expression "{" @indent.branch))

(for_each_statement 
  body: (block "{" @indent.branch))

(lambda_expression 
  body: (block "{" @indent.branch))

(for_statement 
  body: (block "{" @indent.branch))

(switch_expression "{" @indent.branch)

(switch_statement
  (switch_body "{" @indent.branch))

(try_statement
  body: (block "{" @indent.branch))
(catch_clause
  body: (block "{" @indent.branch))
(finally_clause
  (block "{" @indent.branch))

(fixed_statement 
  (block "{" @indent.branch))

(using_statement 
  body: (block "{" @indent.branch))

["catch" "finally" "else" "}" "]" ")" ] @indent.branch

["}" ")" "]" ] @indent.end

(expression_statement ";" @indent.end)

(local_function_statement ";" @indent.end)
(local_declaration_statement ";" @indent.end)

; this is fucked up, because grammer doesn't match # as part of the token
[
 (if_directive)
 (else_directive)
 (elif_directive)
 (endif_directive)
 (nullable_directive)
 (pragma_directive)
 (undef_directive)
 ] @indent.zero
