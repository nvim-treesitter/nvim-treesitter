; Scopes
[
  (block)
  (declaration)
  (statement)
] @local.scope

; References
(identifier) @local.reference

; Definitions
(package_declaration
  (identifier) @local.definition.namespace)

(import_declaration
  alias: (identifier) @local.definition.namespace)

(procedure_declaration
  (identifier) @local.definition.function)

(struct_declaration
  (identifier) @local.definition.type
  "::")

(enum_declaration
  (identifier) @local.definition.enum
  "::")

(union_declaration
  (identifier) @local.definition.type
  "::")

(variable_declaration
  (identifier) @local.definition.var
  ":=")

(const_declaration
  (identifier) @local.definition.constant
  "::")

(const_type_declaration
  (identifier) @local.definition.type
  ":")

(parameter
  (identifier) @local.definition.parameter
  ":"?)

(default_parameter
  (identifier) @local.definition.parameter
  ":=")

(field
  (identifier) @local.definition.field
  ":")

(label_statement
  (identifier) @local.definition
  ":")
