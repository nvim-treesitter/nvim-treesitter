; References
(identifier) @local.reference

((type_identifier) @local.reference
  (#set! reference.kind "type"))

((field_identifier) @local.reference
  (#set! reference.kind "field"))

; Scopes
[
  (program)
  (block)
  (function_definition)
  (loop_expression)
  (if_expression)
  (match_expression)
  (match_arm)
  (struct_item)
  (enum_item)
  (impl_item)
] @local.scope

(use_declaration
  argument:
    (scoped_identifier
      name: (identifier) @local.definition.import))

(use_as_clause
  alias: (identifier) @local.definition.import)

(use_list
  (identifier) @local.definition.import) ; use std::process::{Child, Command, Stdio};

; Functions
(function_definition
  (identifier) @local.definition.function)

(function_definition
  (identifier) @local.definition.method
  (parameter
    (self)))

; Function with parameters, defines parameters
(parameter
  [
    (identifier)
    (self)
  ] @local.definition.parameter)

; Types
(struct_item
  name: (type_identifier) @local.definition.type)

(constrained_type_parameter
  left: (type_identifier) @local.definition.type) ; the P in  remove_file<P: AsRef<Path>>(path: P)

(enum_item
  name: (type_identifier) @local.definition.type)

; Module
(mod_item
  name: (identifier) @local.definition.namespace)

; Variables
(assignment_expression
  left: (identifier) @local.definition.var)
