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
  (#lua-match? @_field "^INP[0-9A-U]$")
  (#set! reference.kind "var"))

(field
  name: (_) @_field
  value: (string) @local.reference
  (#lua-match? @_field "^OUT[A-V]$")
  (#set! reference.kind "var"))

(field
  name: (_) @_field
  value: (string) @local.reference
  (#lua-match? @_field "^LNK[0-9A-F]$")
  (#set! reference.kind "var"))

(field
  name: (_) @_field
  value: (string) @local.reference
  (#eq? @_field "FLNK")
  (#set! reference.kind "var"))
