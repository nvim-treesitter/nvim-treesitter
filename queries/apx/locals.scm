; ApX Tree-sitter locals queries for scope tracking

; Scopes
(function_definition) @local.scope
(macro_definition) @local.scope
(closure) @local.scope
(for_statement) @local.scope
(block) @local.scope

; Definitions
(assignment
  (identifier) @local.definition)

(variable_assignment
  (variable) @local.definition)

(parameter
  (identifier) @local.definition)

(function_definition
  (identifier) @local.definition)

(macro_definition
  (identifier) @local.definition)

(alias_definition
  (identifier) @local.definition)

(for_statement
  (identifier) @local.definition)

(closure_parameters
  (identifier) @local.definition)

; References
(regular_variable) @local.reference
(command_expression
  (command_name
    (identifier) @local.reference))
