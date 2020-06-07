
;; Class / struct defintions
(class_specifier) @scope
(struct_specifier) @scope


(struct_specifier
  name: (type_identifier) @definition.type) 

(struct_specifier
  name: (scoped_type_identifier
          name: (type_identifier) @definition.type) ) 

(class_specifier
  name: (type_identifier) @definition.type) 

(class_specifier
  name: (scoped_type_identifier
          name: (type_identifier) @definition.type) ) 

;; Function defintions
(template_function
  name: (identifier) @definition.function) @scope

(template_method
  name: (field_identifier) @definition.method) @scope

(template_function
  name: (scoped_identifier
    name: (identifier) @definition.function)) @scope

(function_declarator
  declarator: (scoped_identifier
                name: (type_identifier) @definition.function)) @scope

(field_declaration
        declarator: (function_declarator
                       (field_identifier) @definition.method))

(lambda_expression) @scope

;; Control structures
(try_statement
  body: (_) @scope)

(catch_clause) @scope

(destructor_name
  name: (_) @constructor)
