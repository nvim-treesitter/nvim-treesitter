(module
  (property
    field: (identifier) @local.definition.parameter))

(map_expression
  (property
    field: (identifier) @local.definition.field))

(assignment
  left: (identifier) @local.definition.var)

(pattern_binding
  binding: (identifier) @local.definition.var)

(identifier) @local.reference
