;;; DECLARATIONS AND SCOPES

;; Variable and field declarations
((variable_declarator
   (identifier) @definition)
  (set! kind "v"))

((variable_declarator
   (field_expression object:(*) @definition.associated (property_identifier) @definition))
  (set! kind "v"))

;; Parameters
((local_function
   (parameters (identifier) @definition))
  (set! kind "v"))
((function
   (parameters (identifier) @definition))
  (set! kind "v"))

;; Function definitions
;; Functions definitions creates both a definition and a new scope
((function
   (function_name_field
     object: (identifier) @definition.associated
     (property_identifier) @definition)) @scope
  (set! kind "m"))

((function
   (function_name (identifier) @definition)) @scope
  (set! kind "f"))

((local_function
   (identifier) @definition) @scope
  (set! kind "f"))

((if_statement) @scope)
((for_in_statement) @scope)
((repeat_statement) @scope)
;; Loops
((loop_expression
   (identifier) @definition)
  (set! kind "v"))

;;; REFERENCES
((identifier) @reference)
