; inherits: c
(reference_declarator
  (identifier) @local.definition.var)

(type_parameter_declaration
  (type_identifier) @local.definition.type)

(template_declaration) @local.scope

(template_function
  name: (identifier) @local.definition.function) @local.scope

[
  (foreach_statement)
  (foreach_instance_statement)
  (unmasked_statement)
] @local.scope
