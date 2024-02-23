; Scopes
[
  (block)
  (defined_resource_type)
  (parameter_list)
  (attribute_type_entry)
  (class_definition)
  (node_definition)
  (resource_declaration)
  (selector)
  (iterator_statement)
  (case_statement)
  (hash)
  (array)
] @local.scope

; References
[
  (identifier)
  (class_identifier)
  (variable)
] @local.reference

; Definitions
(attribute
  [
    (identifier)
    (variable)
  ] @local.definition.field)

(function_declaration
  [
    (identifier)
    (class_identifier)
  ] @local.definition.function)

(include_statement
  [
    (identifier)
    (class_identifier)
  ] @local.definition.import)

(parameter
  (variable) @local.definition.parameter)

(class_definition
  [
    (identifier)
    (class_identifier)
  ] @local.definition.type)

(node_definition
  (node_name
    (identifier) @local.definition.type))

(resource_declaration
  [
    (identifier)
    (class_identifier)
  ] @local.definition.type)

(assignment
  .
  (variable) @local.definition.var)
