(expr_body) @local.scope

(argument_patterns
  (identifier_pattern
    (identifier) @local.definition))

; (argument_patterns(long_identifier)@local.definition)
(exposes_list
  (ident) @local.reference)

(opaque_type_def
  (apply_type
    (concrete_type) @local.definition.type))

(alias_type_def
  (apply_type
    (concrete_type) @local.definition.type))

(value_declaration
  (decl_left
    (identifier_pattern
      (identifier) @local.definition.function))
  (expr_body
    (anon_fun_expr)))

(value_declaration
  (decl_left
    (identifier_pattern
      (identifier) @local.definition.var)))

(identifier_pattern
  (identifier) @local.definition)

(exposes
  (ident) @local.reference)

(identifier) @local.reference

(tag_expr
  (tag)) @local.reference
