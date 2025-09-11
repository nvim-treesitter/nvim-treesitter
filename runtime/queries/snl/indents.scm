[
  (field_declaration_list)
  (state_set)
  (state)
  (block)
  (member_decl)
] @indent.begin

(block
  "}" @indent.end)

[
  "else"
  "}"
] @indent.branch

(call_expression) @indent.begin

(call_expression
  ")" @indent.end)

(if_statement
  condition: (_) @indent.begin)

(if_statement
  consequence: (_) @_consequence
  (#not-kind-eq? @_consequence block)) @indent.begin

(else_statement
  consequence: (_) @_consequence
  (#not-kind-eq? @_consequence block)) @indent.begin

(while_statement
  body: (statement
    (_) @_body)
  (#not-kind-eq? @_body block)) @indent.begin

(for_statement
  body: (statement
    (_) @_body)
  (#not-kind-eq? @_body block)) @indent.begin

(init_declarator) @indent.begin

(transition
  condition: (_) @indent.begin)

[
  "#define"
  "#ifdef"
  "#if"
  "#else"
  "#endif"
] @indent.zero

[
  (preproc_arg)
  (string_literal)
] @indent.ignore

(comment) @indent.auto
