(document) @scope
(definition) @scope

[
  (identifier)
  (field_type)
  (custom_type)
] @reference
(const_value (const_identifier) @reference)

(annotation_identifier) @definition

(const (const_identifier) @definition.constant)
(enum_member) @definition.constant

(enum_identifier) @definition.enum

(field_identifier) @definition.field

(function_identifier) @definition.function

(namespace_definition) @definition.namespace

[
  (param_identifier)
  (exception_param_identifier)
] @definition.parameter

[
  (type_identifier)
  (exception_identifier)
] @definition.type
