; Constants
; Constants in Swift are more like readonly variables in other languages
; Functions
(function_declaration
  name: (simple_identifier) @local.definition.function)

; Methods
(function_declaration
  name: (simple_identifier) @local.definition.method)

; Variables
(statements
  (property_declaration
    name:
      (pattern
        bound_identifier: (simple_identifier) @local.definition.var)))

(for_statement
  (pattern
    bound_identifier: (simple_identifier) @local.definition.var))

; Parameters
(function_declaration
  (parameter
    name: (simple_identifier) @local.definition.parameter))

(lambda_function_type_parameters
  (lambda_parameter
    (simple_identifier) @local.definition.parameter))

; Types
name: (type_identifier) @local.definition.type

; Fields
(class_body
  (property_declaration
    name:
      (pattern
        bound_identifier: (simple_identifier) @local.definition.field)))

; Enums
(class_declaration
  name: (type_identifier) @local.definition.enum
  body: (enum_class_body))

; Namespaces
; In Swift there are no namespaces
; Imports
(import_declaration
  (identifier) @local.definition.import)

; Scopes
[
  (statements)
  (for_statement)
  (while_statement)
  (repeat_while_statement)
  (do_statement)
  (if_statement)
  (guard_statement)
  (switch_statement)
  (property_declaration)
  (function_declaration)
  (class_declaration)
  (protocol_declaration)
] @local.scope

; References
(statements
  (assignment
    (directly_assignable_expression
      (simple_identifier) @local.reference)))

(navigation_expression
  target: (self_expression)
  suffix:
    (navigation_suffix
      suffix: (simple_identifier) @local.reference))

(navigation_expression
  target: (simple_identifier) @local.reference)

(call_expression
  (simple_identifier) @local.reference)

(prefix_expression
  (simple_identifier) @local.reference)

(lambda_literal
  (capture_list
    (capture_list_item
      name: (simple_identifier) @local.reference)))

(switch_statement
  expr: (simple_identifier) @local.reference)

(self_expression) @local.reference

condition: (simple_identifier) @local.reference

collection: (simple_identifier) @local.reference

value: (simple_identifier) @local.reference
