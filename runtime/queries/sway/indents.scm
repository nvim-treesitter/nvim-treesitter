[
  (mod_item)
  (struct_item)
  (enum_item)
  (impl_item)
  (struct_expression)
  (struct_pattern)
  (tuple_struct_pattern)
  (tuple_expression)
  (tuple_type)
  (tuple_pattern)
  (match_block)
  (call_expression)
  (asm_block)
  (asm_parameters)
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
] @indent.begin

(trait_item
  body: (_) @indent.begin)

(string_literal
  (escape_sequence)) @indent.begin

(block
  "}" @indent.end)

(asm_block
  "}" @indent.end)

(enum_item
  body: (enum_variant_list
    "}" @indent.end))

(impl_item
  body: (declaration_list
    "}" @indent.end))

(match_expression
  body: (match_block
    "}" @indent.end))

(struct_item
  body: (field_declaration_list
    "}" @indent.end))

(struct_expression
  body: (field_initializer_list
    "}" @indent.end))

(struct_pattern
  "}" @indent.end)

(tuple_struct_pattern
  ")" @indent.end)

(tuple_type
  ")" @indent.end)

(tuple_pattern
  ")" @indent.end)

(trait_item
  body: (declaration_list
    "}" @indent.end))

(impl_item
  (where_clause) @indent.dedent)

[
  "where"
  ")"
  "]"
  "}"
] @indent.branch

(impl_item
  (declaration_list) @indent.branch)

[
  (line_comment)
  (string_literal)
] @indent.ignore

(raw_string_literal) @indent.auto
