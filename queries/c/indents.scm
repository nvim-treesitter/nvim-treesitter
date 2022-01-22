[
  (compound_statement)
  (preproc_arg)
  (field_declaration_list)
  (case_statement)
  (enumerator_list)
  (struct_specifier)
  (compound_literal_expression)
  (initializer_list)
  (concatenated_string)
  (while_statement)
  (for_statement)
  (switch_statement)
  (expression_statement)
] @indent
(if_statement condition: (_) @indent)
((if_statement
  consequence: (_) @_consequence
  (#not-has-type? @_consequence compound_statement)
  ) @indent)
(init_declarator 
  value: [
    (binary_expression)
    (conditional_expression)
  ] @indent)

(compound_statement "}" @indent_end)

[
  "else"
  ")"
  "}"
  (statement_identifier)
] @branch

[
  "#define"
  "#ifdef"
  "#if"
  "#else"
  "#endif"
] @zero_indent

[
  (preproc_arg)
  (string_literal)
] @ignore

((ERROR (parameter_declaration)) @aligned_indent
 (#set! "delimiter" "()"))
([(argument_list) (parameter_list)] @aligned_indent
  (#set! "delimiter" "()"))

((comment) @aligned_indent
 (#lua-match? @aligned_indent "^/\*"))
((comment) @ignore
 (#lua-match? @ignore "^//"))
