; Scopes
;-------

(statement_block) @scope
(function) @scope
(arrow_function) @scope
(function_declaration) @scope
(method_definition) @scope

; Definitions
;------------

(formal_parameters
  (identifier) @definition.var)

(formal_parameters
  (object_pattern
    (identifier) @definition.var))

(formal_parameters
  (object_pattern
    (shorthand_property_identifier) @definition.var))

(formal_parameters
  (array_pattern
    (identifier) @definition.var))

(formal_parameters
  (rest_parameter
    (identifier) @definition.var))

(variable_declarator
  name: (identifier) @definition.var)

(import_specifier
  (identifier) @definition.import)

; References
;------------

(identifier) @reference

