; locals.scm
(function_definition) @local.scope

(argument
  name: (identifier) @local.definition)

(parameter
  name: (identifier) @local.definition)

(binary_operator
  lhs: (identifier) @local.definition
  operator: "<-")

(binary_operator
  lhs: (identifier) @local.definition
  operator: "=")

(binary_operator
  operator: "->"
  rhs: (identifier) @local.definition)

(identifier) @local.reference
