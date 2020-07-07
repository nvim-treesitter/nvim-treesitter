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
  (identifier) @definition)

(formal_parameters
  (object_pattern
    (identifier) @definition))

(formal_parameters
  (object_pattern
    (shorthand_property_identifier) @definition))

(formal_parameters
  (array_pattern
    (identifier) @definition))

(variable_declarator
  name: (identifier) @definition)

(import_specifier
  (identifier) @definition)

; References
;------------

(identifier) @reference

