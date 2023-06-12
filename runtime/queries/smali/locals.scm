[
  (class_directive)
  (expression)
  (annotation_directive)
  (array_data_directive)
  (method_definition)
  (packed_switch_directive)
  (sparse_switch_directive)
  (subannotation_directive)
] @local.scope

[
  (identifier)
  (class_identifier)
  (label)
  (jmp_label)
] @local.reference

(enum_reference
  (field_identifier) @local.definition.enum)

((field_definition
  (access_modifiers) @_mod
  (field_identifier) @local.definition.enum)
  (#eq? @_mod "enum"))

(field_definition
  (field_identifier) @local.definition.field
  (field_type) @local.definition.associated)

(annotation_key) @local.definition.field

(method_definition
  (method_signature
    (method_identifier) @local.definition.method))

(param_identifier) @local.definition.parameter

(annotation_directive
  (class_identifier) @local.definition.type)

(class_directive
  (class_identifier) @local.definition.type)
