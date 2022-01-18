[
  (mod_item)
  (struct_item)
  (enum_item)
  (impl_item)
  (for_expression)
  (struct_expression)
  (match_expression)
  (tuple_expression)
  (match_arm)
  (match_block)
  (if_let_expression)
  (call_expression)
  (assignment_expression)
  (arguments)
  (block)
  (where_clause)
  (use_list)
  (array_expression)
  (ordered_field_declaration_list)
  (field_declaration_list)
  (enum_variant_list)
  (parameters)
  (token_tree)
  (macro_definition)
] @indent
(trait_item body: (_) @indent)
(string_literal (escape_sequence)) @indent

(impl_item (where_clause) @dedent)

[
  "where"
  ")"
  "]"
  "}"
] @branch
(impl_item (declaration_list) @branch)

[
  (line_comment)
  (string_literal)
] @ignore


(raw_string_literal) @auto
