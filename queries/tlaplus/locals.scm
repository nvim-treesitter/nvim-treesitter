; Scopes
[
  (bounded_quantification)
  (function_definition) 
  (lambda) 
  (module) 
  (module_definition) 
  (pcal_algorithm)
  (pcal_macro)
  (pcal_procedure)
  (pcal_with)
  (unbounded_quantification)
] @scope

; Definitions
(constant_declaration (identifier) @definition.constant)
(function_definition name: (identifier) @definition.operator)
(lambda (identifier) @definition.parameter)
(operator_definition name: (identifier) @definition.operator)
(operator_definition parameter: (identifier) @definition.parameter)
(pcal_macro_decl parameter: (identifier) @definition.parameter)
(pcal_proc_var_decl (identifier) @definition.parameter)
(pcal_var_decl (identifier) @definition.variable)
(pcal_with (identifier) @definition.parameter)
(quantifier_bound (identifier) @definition.parameter)
(quantifier_bound (tuple_of_identifiers (identifier) @definition.parameter))
(variable_declaration (identifier) @definition.variable)

; Builtin variables
(pcal_algorithm_body
  [
    (_ (identifier_ref) @definition.builtin_variable)
    (_ (_ (identifier_ref) @definition.builtin_variable))
    (_ (_ (_ (identifier_ref) @definition.builtin_variable))) 
    (_ (_ (_ (_ (identifier_ref) @definition.builtin_variable))))
    (_ (_ (_ (_ (_ (identifier_ref) @definition.builtin_variable)))))
  ]
  (#vim-match? @definition.builtin_variable "^(self|pc|stack)$")
)
