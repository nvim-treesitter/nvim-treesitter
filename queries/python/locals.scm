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
  (identifier) @definition.parameter)

(default_parameter
  (identifier) @definition.parameter)

(typed_parameter
  (identifier) @definition.parameter)

(typed_default_parameter
  (identifier) @definition.parameter)

(with_statement
  (with_item
    alias: (identifier) @definition.var))

; *args parameter
(parameters
  (list_splat
    (identifier) @definition.parameter))

; **kwargs parameter
(parameters
  (dictionary_splat
    (identifier) @definition.parameter))

; Function defines function and scope
((function_definition
  name: (identifier) @definition.function) @scope
 (#set! definition.function.scope "parent"))


((class_definition
  name: (identifier) @definition.type) @scope
 (#set! definition.type.scope "parent"))

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

(left_hand_side
 (identifier) @definition.var)

(left_hand_side
 (attribute
  (identifier)
  (identifier) @definition.field))

; Walrus operator  x := 1
(named_expression
  (identifier) @definition.var)


;;; REFERENCES
(identifier) @reference
