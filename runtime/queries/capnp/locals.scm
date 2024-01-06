[
  (message)
  (annotation_targets)
  (const_list)
  (enum)
  (interface)
  (implicit_generics)
  (generics)
  (group)
  (method_parameters)
  (named_return_types)
  (struct)
  (struct_shorthand)
  (union)
] @local.scope

[
  (extend_type)
  (field_type)
] @local.reference

(custom_type
  (type_identifier) @local.reference)

(custom_type
  (generics
    (generic_parameters
      (generic_identifier) @local.reference)))

(annotation_definition_identifier) @local.definition

(const_identifier) @local.definition.constant

(enum
  (enum_identifier) @local.definition.enum)

[
  (enum_member)
  (field_identifier)
] @local.definition.field

(method_identifier) @local.definition.method

(namespace) @local.definition.namespace

[
  (param_identifier)
  (return_identifier)
] @local.definition.parameter

(group
  (type_identifier) @local.definition.type)

(struct
  (type_identifier) @local.definition.type)

(union
  (type_identifier) @local.definition.type)

(interface
  (type_identifier) @local.definition.type)

; Generics Related (don't know how to combine these)
(struct
  (generics
    (generic_parameters
      (generic_identifier) @local.definition.parameter)))

(interface
  (generics
    (generic_parameters
      (generic_identifier) @local.definition.parameter)))

(method
  (implicit_generics
    (implicit_generic_parameters
      (generic_identifier) @local.definition.parameter)))

(method
  (generics
    (generic_parameters
      (generic_identifier) @local.definition.parameter)))

(annotation
  (generics
    (generic_parameters
      (generic_identifier) @local.definition.type)))

(replace_using
  (generics
    (generic_parameters
      (generic_identifier) @local.definition.type)))

(return_type
  (generics
    (generic_parameters
      (generic_identifier) @local.definition.type)))
