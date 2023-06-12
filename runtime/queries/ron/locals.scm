(source_file) @local.scope

(source_file
  (array) @local.scope)

(source_file
  (map) @local.scope)

(source_file
  (struct) @local.scope)

(source_file
  (tuple) @local.scope)

(identifier) @local.reference

(struct_entry
  (identifier) @local.definition.field)

(struct_entry
  (identifier) @local.definition.enum
  (enum_variant))

(struct
  (struct_name) @local.definition.type)
