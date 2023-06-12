[
  (script_file)
  (function_definition)
] @local.scope

(function_declaration
  name: (identifier) @local.definition.function)

(function_declaration
  parameters: (parameters
    (identifier) @local.definition.parameter))

(let_statement
  [
    (scoped_identifier)
    (identifier)
  ] @local.definition.var)

(identifier) @local.reference
