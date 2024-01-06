; Scopes
[
  (module)
  (function_declaration)
  (if_statement)
  (for_statement)
  (match_expression)
  (switch_expression)
] @local.scope

; References
[
  (identifier)
  (scoped_type_identifier)
] @local.reference

; Definitions
(global_binding
  (identifier) @local.definition.constant
  .
  ":"
  (_))

(const_declaration
  "const"
  (identifier) @local.definition.constant
  .
  "=")

(field
  .
  (identifier) @local.definition.field)

(field_assignment
  .
  (identifier) @local.definition.field)

(function_declaration
  "fn"
  .
  (identifier) @local.definition.function)

(parameter
  (_) @local.definition.parameter
  .
  ":")

(type_declaration
  "type"
  (identifier) @local.definition.type
  .
  "=")

(type_declaration
  "type"
  (identifier) @local.definition.enum
  .
  "="
  (enum_type))

(let_declaration
  "let"
  .
  (identifier) @local.definition.variable
  ","?)
