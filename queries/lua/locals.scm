;;; DECLARATIONS AND SCOPES

;; Variable and field declarations
((variable_declarator
   (identifier) @definition.var))

((variable_declarator
   (field_expression . (_) @definition.associated (property_identifier) @definition.var)))

;; Parameters
(parameters (identifier) @definition.parameter)

;; Loops
((loop_expression
   (identifier) @definition.var))

;; Function definitions
;; Functions definitions creates both a definition and a new scope
((function
   (function_name
     (function_name_field
       (identifier) @definition.associated
       (property_identifier) @definition.method))) @scope)

((function
   (function_name (identifier) @definition.function)) @scope)

((local_function
   (identifier) @definition.function) @scope)
[
(local_variable_declaration
  (variable_declarator
    (identifier) @definition.function)
  (function_definition) @scope)
(function_definition) @scope
]

[
  (program)
  (if_statement)
  (for_in_statement)
  (repeat_statement)
  (while_statement)
  (do_statement)
] @scope

;;; REFERENCES
[
  (identifier)
  (property_identifier)
] @reference
