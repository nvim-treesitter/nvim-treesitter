; inherits: c

((foreach_statement
  body: (_) @_body) @indent.begin
  (#not-kind-eq? @_body "compound_statement"))

((foreach_instance_statement
  body: (_) @_body) @indent.begin
  (#not-kind-eq? @_body "compound_statement"))
