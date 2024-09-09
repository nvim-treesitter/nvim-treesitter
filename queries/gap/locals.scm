[
  (lambda)
  (function)
  (atomic_function)
] @local.scope

(parameters
  (identifier) @local.definition.parameter)

(qualified_parameters
  (identifier) @local.definition.parameter)

(qualified_parameters
  (qualified_identifier
    (identifier) @local.definition.parameter))

(lambda_parameters
  (identifier) @local.definition.parameter)

(locals
  (identifier) @local.definition.var)

(record_entry
  left: [
    (identifier)
    (integer)
  ] @local.definition.field)

(assignment_statement
  left: (identifier) @local.definition.var)

(for_statement
  identifier: (identifier) @local.definition.var)

(assignment_statement
  left: (identifier) @local.definition.function
  right: [
    (lambda)
    (function)
    (atomic_function)
  ])

(identifier) @local.reference
