; Scopes
;-------

(class_declaration) @scope
(while_statement) @scope
(foreach_statement) @scope
(if_statement) @scope
(try_statement) @scope
(method_declaration
  name: (name) @definition.method) @scope
(function_definition
  name: (name) @definition.function) @scope

; Definitions
;------------

(simple_parameter
  (variable_name
    (name) @definition.var))

(anonymous_function_use_clause
  (variable_name
    (name) @definition.var))

(assignment_expression
  left: (variable_name
    (name) @definition.var))

(property_declaration
  (variable_name
    (name) @definition.field))

(namespace_use_clause
  (qualified_name
    (name) @definition.class))

(class_declaration
  name: (name) @definition.class)

; References
;------------

(name) @reference
