; declarations

(class_declaration) @scope
(method_declaration) @scope
(constructor_declaration) @scope
(enum_declaration) @scope
(enhanced_for_statement) @scope

; if/else

(if_statement) @scope
(if_statement
  consequence: (_) @scope) ; if body in case there are no braces
(if_statement
  alternative: (_) @scope) ; else body in case there are no braces

; try/catch

(try_statement) @scope ; covers try+catch, individual try and catch are covered by (block)
(catch_clause) @scope ; needed because `Exception` variable

; loops

(for_statement) @scope
(for_statement         ; "for" body in case there are no braces
  body: (_) @scope)
(do_statement
  body: (_) @scope)
(while_statement
  body: (_) @scope)

; Functions

(constructor_declaration) @scope
(method_declaration) @scope

;; definitions

(enum_declaration
  name: (identifier) @definition.enum)

(method_declaration
  name: (identifier) @definition.method)

(local_variable_declaration
  declarator: (variable_declarator
    name: (identifier) @definition.var))

(enhanced_for_statement 
  name: (identifier) @definition.var)

(formal_parameter
  name: (identifier) @definition.parameter)

(catch_formal_parameter
  name: (identifier) @definition.parameter)

(field_declaration
  declarator: (variable_declarator
    name: (identifier) @definition.field))

;; REFERENCES

(identifier) @reference

(type_identifier) @reference
