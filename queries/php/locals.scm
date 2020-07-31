; Scopes
;-------

(class_declaration) @scope
(property_declaration) @scope
(method_declaration) @scope
(function_definition) @scope
(while_statement) @scope
(foreach_statement) @scope
(if_statement) @scope
(try_statement) @scope

; Definitions
;------------

(variable_name
  (name) @definition.var)

; References
;------------

(variable_name) @reference
