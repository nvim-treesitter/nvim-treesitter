[
  (function_definition)
  (statement_block)
  (if_statement)
  (while_statement)
  (for_statement)
  (foreach_statement)
  (catch_clause)
] @local.scope

(init_declarator
  name: (identifier) @local.definition.var)

(array_declarator
  name: (identifier) @local.definition.var)

(function_definition
  name: (identifier) @local.definition.function)

(parameter
  name: (identifier) @local.definition.parameter)

(tuple_capture
  (identifier) @local.definition.var)

(catch_clause
  parameter: (identifier) @local.definition.var)

(assignment_expression
  left: (identifier) @local.definition.var)

(call_expression
  function: (identifier) @local.reference)

(identifier) @local.reference
