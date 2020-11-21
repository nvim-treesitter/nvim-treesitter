;;; DECLARATIONS AND SCOPES

;; Variable and field declarations
((variable_declarator
   (identifier) @definition.var))

((variable_declarator
   (field_expression object:(*) @definition.associated (property_identifier) @definition.var)))

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
(function_definition) @scope

(program) @scope
((if_statement) @scope)
((for_in_statement) @scope)
((repeat_statement) @scope)
((while_statement) @scope)

;;; REFERENCES
((identifier) @reference)
((property_identifier) @reference)
