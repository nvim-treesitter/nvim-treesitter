; Scopes
[
  (use_statement)
  (actor_definition)
  (class_definition)
  (primitive_definition)
  (interface_definition)
  (trait_definition)
  (struct_definition)
  (constructor)
  (method)
  (behavior)
  (if_statement)
  (iftype_statement)
  (elseif_block)
  (elseiftype_block)
  (else_block)
  (for_statement)
  (while_statement)
  (try_statement)
  (with_statement)
  (repeat_statement)
  (recover_statement)
  (match_statement)
  (case_statement)
  (parenthesized_expression)
  (tuple_expression)
  (array_literal)
  (object_literal)
] @local.scope

; References
(identifier) @local.reference

; Definitions
(field
  name: (identifier) @local.definition.field)

(use_statement
  (identifier) @local.definition.import)

(constructor
  (identifier) @local.definition.method)

(method
  (identifier) @local.definition.method)

(behavior
  (identifier) @local.definition.method)

(actor_definition
  (identifier) @local.definition.type)

(type_alias
  (identifier) @local.definition.type)

(class_definition
  (identifier) @local.definition.type)

(primitive_definition
  (identifier) @local.definition.type)

(interface_definition
  (identifier) @local.definition.type)

(trait_definition
  (identifier) @local.definition.type)

(struct_definition
  (identifier) @local.definition.type)

(parameter
  name: (identifier) @local.definition.parameter)

(variable_declaration
  (identifier) @local.definition.var)

(for_statement
  [
    (identifier) @local.definition.var
    (tuple_expression
      (identifier) @local.definition.var)
  ])

(with_elem
  (identifier) @local.definition.var)
