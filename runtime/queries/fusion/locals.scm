; Fusion base
(block) @local.scope

(namespace_declaration
  (alias_namespace) @local.definition.namespace)

(property
  (path
    (path_part) @local.definition.field))

(type
  namespace: (package_name)? @local.definition.namespace
  name: (type_name) @local.definition.type)

; Eel Expressions
(eel_arrow_function) @local.scope

(eel_object) @local.scope

(eel_parameter) @local.definition.parameter

(eel_object_pair
  key: (eel_property_name) @local.definition.field)
