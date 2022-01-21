[
  (init_declarator)
  (compound_statement)
  (preproc_arg)
  (field_declaration_list)
  (case_statement)
  (enumerator_list)
  (struct_specifier)
  (compound_literal_expression)
  (parameter_list)
  (initializer_list)
  (concatenated_string)
  (while_statement)
  (for_statement)
  (switch_statement)
] @indent
(if_statement condition: (_) @indent)
((if_statement
  consequence: (_) @_consequence
  (#not-has-type? @_consequence compound_statement)
  ) @indent)
(init_declarator 
  value: [
    (binary_expression)
  ] @indent)

(compound_statement "}" @indent_end)

[
  "#define"
  "#ifdef"
  "#if"
  "#else"
  "else"
  "#endif"
  ")"
  "}"
] @branch

[
  (comment)
  (preproc_arg)
  (string_literal)
] @ignore

(binary_expression) @auto
