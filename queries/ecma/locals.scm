; Scopes
;-------

(statement_block) @scope
(function) @scope
(arrow_function) @scope
(function_declaration) @scope
(method_definition) @scope
(for_statement) @scope
(for_in_statement) @scope
(catch_clause) @scope

; Definitions
;------------

;(formal_parameters
  ;(identifier) @definition.parameter)

;(formal_parameters
  ;(object_pattern
    ;(identifier) @definition.parameter))

;; function(arg = []) {
;(formal_parameters
  ;(assignment_pattern
    ;(shorthand_property_identifier) @definition.parameter))

;; x => x
;(arrow_function
  ;parameter: (identifier) @definition.parameter)

;(formal_parameters
  ;(object_pattern
    ;(shorthand_property_identifier) @definition.parameter))

;(formal_parameters
  ;(array_pattern
    ;(identifier) @definition.parameter))

;(formal_parameters
  ;(rest_parameter
    ;(identifier) @definition.parameter))

(variable_declarator
  name: (identifier) @definition.var)

(import_specifier
  (identifier) @definition.import)

(namespace_import
  (identifier) @definition.import)

(function_declaration
  ((identifier) @definition.var)
   (#set! definition.var.scope parent))

; References
;------------

(identifier) @reference
(shorthand_property_identifier) @reference
