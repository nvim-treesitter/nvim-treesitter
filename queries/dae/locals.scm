; =============================================================================
; Tree-sitter Locals for DAE
; =============================================================================

; Parameter assignment defines a variable
(parameter_assignment key: (identifier) @definition.var)

; Function call name is treated as reference
(function_call name: (identifier) @reference.call)

; General identifier usage
(identifier) @reference
