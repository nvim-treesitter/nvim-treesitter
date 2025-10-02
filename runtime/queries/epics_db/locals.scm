(source_file) @local.scope

((record_type) @local.reference
  (#set! reference.kind "type"))

((record_name) @local.reference
  (#set! reference.kind "var"))

((field_name) @local.reference
  (#set! reference.kind "field"))

(menu_definition
  name: (_) @local.definition.type)

(menu_choice
  name: (_) @local.definition.constant)

(record_type_definition
  name: (_) @local.definition.type)

(field_definition
  name: (_) @local.definition.field)

(field_definition
  type: (_) @local.reference
  (#set! reference.kind "type"))

(record_instance
  name: (_) @local.definition.var)

(alias_statement
  alias_name: (_) @local.definition.var)

(alias
  alias_name: (_) @local.definition.var)

(field
  name: (_) @_field
  value: (string) @local.reference
  (#match? @_field "LNK|INP|^OUT$")
  (#set! reference.kind "var"))
