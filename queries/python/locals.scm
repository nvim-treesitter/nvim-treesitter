;;; Programm structure
(module) @scope

(class_definition
  body: (block
          (expression_statement
            (assignment
              left: (expression_list
                      (identifier) @definition.associated))))) @scope

; Imports
(aliased_import
	alias: (identifier) @definition.import)
(import_statement
	name: (dotted_name ((identifier) @definition.import)))
(import_from_statement
	name: (dotted_name ((identifier) @definition.import)))

; Function with parameters, defines parameters
(parameters
  (identifier) @definition.var)

(default_parameter
  (identifier) @definition.var)

(typed_parameter
  (identifier) @definition.var)

(typed_default_parameter
  (identifier) @definition.var)

; *args parameter
(parameters
  (list_splat
    (identifier) @definition.var))

; **kwargs parameter
(parameters
  (dictionary_splat
    (identifier) @definition.var))

; Function defines function and scope
(function_definition
  name: (identifier) @definition.function
  body: (block (expression_statement (string) @definition.doc)?)) @scope


(class_definition
  name: (identifier) @definition.type) @scope

(class_definition 
  body: (block
          (function_definition
            name: (identifier) @definition.method))) 

;;; Loops
; not a scope!
(for_statement
  left: (variables
    (identifier) @definition.var))

; not a scope!
;(while_statement) @scope

; for in list comprehension
(for_in_clause
  left: (variables
          (identifier) @definition.var))

(dictionary_comprehension) @scope
(list_comprehension) @scope
(set_comprehension) @scope

;;; Assignments

(assignment
  left: (expression_list
     (identifier) @definition.var))

(assignment
  left: (expression_list
          (attribute
            (identifier)
            (identifier) @definition.field)))

; Walrus operator  x := 1
(named_expression
  (identifier) @definition.var)


;;; REFERENCES
(identifier) @reference
