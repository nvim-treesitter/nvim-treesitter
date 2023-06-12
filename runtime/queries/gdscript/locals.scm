; Scopes
[
  (if_statement)
  (elif_clause)
  (else_clause)
  (for_statement)
  (while_statement)
  (function_definition)
  (constructor_definition)
  (class_definition)
  (match_statement)
  (pattern_section)
  (lambda)
  (get_body)
  (set_body)
] @local.scope

; Parameters
(parameters
  (identifier) @local.definition.parameter)

(default_parameter
  (identifier) @local.definition.parameter)

(typed_parameter
  (identifier) @local.definition.parameter)

(typed_default_parameter
  (identifier) @local.definition.parameter)

; Signals
; Can gdscript 2 signals be considered fields?
(signal_statement
  (name) @local.definition.field)

; Variable Definitions
(const_statement
  (name) @local.definition.constant)

; onready and export variations are only properties.
(variable_statement
  (name) @local.definition.var)

(setter) @local.reference

(getter) @local.reference

; Function Definition
((function_definition
  (name) @local.definition.function)
  (#set! "definition.function.scope" "parent"))

; Lambda
; lambda names are not accessible and are only for debugging.
(lambda
  (name) @local.definition.function)

; Source
(class_name_statement
  (name) @local.definition.type)

(source
  (variable_statement
    (name) @local.definition.field))

(source
  (onready_variable_statement
    (name) @local.definition.field))

(source
  (export_variable_statement
    (name) @local.definition.field))

; Class
((class_definition
  (name) @local.definition.type)
  (#set! "definition.type.scope" "parent"))

(class_definition
  (body
    (variable_statement
      (name) @local.definition.field)))

(class_definition
  (body
    (onready_variable_statement
      (name) @local.definition.field)))

(class_definition
  (body
    (export_variable_statement
      (name) @local.definition.field)))

(class_definition
  (body
    (signal_statement
      (name) @local.definition.field)))

; Although a script is also a class, let's only define functions in an inner class as
; methods.
((class_definition
  (body
    (function_definition
      (name) @local.definition.method)))
  (#set! "definition.method.scope" "parent"))

; Enum
(enum_definition
  (name) @local.definition.enum)

; Repeat
(for_statement
  .
  (identifier) @local.definition.var)

; Match Statement
(pattern_binding
  (identifier) @local.definition.var)

; References
(identifier) @local.reference
