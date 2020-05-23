;;; Programm structure
(module) @scope

(class_definition
  body: (block
          (expression_statement
            (assignment
              left: (expression_list
                      (identifier) @definition.associated))))) @scope

; Function with parameters, defines parameters
(function_definition
  name: (identifier)
  parameters: (parameters
                (identifier) @definition.var))

; Function defines function and scope
(function_definition
  name: (identifier) @definition.function) @scope

;; Should be extended to when syntax supported
;(function_definition
  ;name: (identifier) @definition.function
  ;body: (block (expression_statement (string) @definition.function.doc)?)) @scope


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
