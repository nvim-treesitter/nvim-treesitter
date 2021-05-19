[
  (init_declarator)
  (compound_statement)
  (preproc_arg)
  (field_declaration_list)
  (case_statement)
  (conditional_expression)
  (enumerator_list)
  (struct_specifier)
] @indent


[
  "#define"
  "#ifdef"
  "#endif"
  "{"
  "}"
] @branch

[
  (comment)
  (preproc_function_def)
] @ignore
