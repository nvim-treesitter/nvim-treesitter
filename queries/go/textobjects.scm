;; function textobject
(function_declaration
  body: (block)? @function.inner) @function.outer

;; method as function textobject
(method_declaration
  body: (block)? @function.inner) @function.outer

;; struct and interface declaration as class textobject?
(type_declaration
    (type_spec (type_identifier) (struct_type (field_declaration_list (_)?) @class.inner))) @class.outer

(type_declaration
  (type_spec (type_identifier) (interface_type (method_spec_list (_)?) @class.inner))) @class.outer

;; struct literals as class textobject
(composite_literal 
  (type_identifier)? 
  (struct_type (_))?
  (literal_value (_)) @class.inner) @class.outer

;; conditionals
(if_statement
  alternative: (_ (_) @conditional.inner)?) @conditional.outer

(if_statement
  consequence: (block)? @conditional.inner)

(if_statement
  condition: (_) @conditional.inner)

;; blocks
(_ (block) @block.inner) @block.outer
;; statements
(block (_) @statement.outer)
;; comments
(comment) @comment.outer
