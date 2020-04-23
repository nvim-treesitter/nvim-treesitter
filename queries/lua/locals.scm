;;; DECLARATIONS AND SCOPES

;; Variable and field declarations
((variable_declarator
   (identifier) @definition)
  (set! definition.kind "v"))

((variable_declarator
   (field_expression object:(*) @definition.associated (property_identifier) @definition))
  (set! difinition.kind "v"))

;; Parameters
((local_function
   (parameters (identifier) @definition))
  (set! definition.kind "v"))
((function
   (parameters (identifier) @definition))
  (set! definition.kind "v"))

;; Loops
((loop_expression
   (identifier) @definition)
  (set! definition.kind "v"))

;; Function definitions
;; Functions definitions creates both a definition and a new scope
((function
   (function_name
     (function_name_field
       (identifier) @definition.associated
       (property_identifier) @definition))) @scope
 (set! definition.kind "m"))

((function
   (function_name (identifier) @definition)) @scope
  (set! definition.kind "f"))

((local_function
   (identifier) @definition) @scope
  (set! definition.kind "f"))

((if_statement) @scope)
((for_in_statement) @scope)
((repeat_statement) @scope)
((while_statement) @scope)

;;; REFERENCES
((identifier) @reference)
