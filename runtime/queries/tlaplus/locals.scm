; TLA+ scopes and definitions
[
  (bounded_quantification)
  (choose)
  (function_definition)
  (function_literal)
  (lambda)
  (let_in)
  (module)
  (module_definition)
  (operator_definition)
  (set_filter)
  (set_map)
  (unbounded_quantification)
] @local.scope

(choose
  (identifier) @local.definition.parameter)

(choose
  (tuple_of_identifiers
    (identifier) @local.definition.parameter))

(constant_declaration
  (identifier) @local.definition.constant)

(constant_declaration
  (operator_declaration
    name: (_) @local.definition.constant))

(function_definition
  name: (identifier) @local.definition.function
  (#set! "definition.function.scope" "parent"))

(lambda
  (identifier) @local.definition.parameter)

(module_definition
  name: (_) @local.definition.import
  (#set! "definition.import.scope" "parent"))

(module_definition
  parameter: (identifier) @local.definition.parameter)

(module_definition
  parameter: (operator_declaration
    name: (_) @local.definition.parameter))

(operator_definition
  name: (_) @local.definition.macro
  (#set! "definition.macro.scope" "parent"))

(operator_definition
  parameter: (identifier) @local.definition.parameter)

(operator_definition
  parameter: (operator_declaration
    name: (_) @local.definition.parameter))

(quantifier_bound
  (identifier) @local.definition.parameter)

(quantifier_bound
  (tuple_of_identifiers
    (identifier) @local.definition.parameter))

(unbounded_quantification
  (identifier) @local.definition.parameter)

(variable_declaration
  (identifier) @local.definition.var)

; Proof scopes and definitions
[
  (non_terminal_proof)
  (suffices_proof_step)
  (theorem)
] @local.scope

(assume_prove
  (new
    (identifier) @local.definition.parameter))

(assume_prove
  (new
    (operator_declaration
      name: (_) @local.definition.parameter)))

(assumption
  name: (identifier) @local.definition.constant)

(pick_proof_step
  (identifier) @local.definition.parameter)

(take_proof_step
  (identifier) @local.definition.parameter)

(theorem
  name: (identifier) @local.definition.constant
  (#set! "definition.constant.scope" "parent"))

; PlusCal scopes and definitions
[
  (pcal_algorithm)
  (pcal_macro)
  (pcal_procedure)
  (pcal_with)
] @local.scope

(pcal_macro_decl
  parameter: (identifier) @local.definition.parameter)

(pcal_proc_var_decl
  (identifier) @local.definition.parameter)

(pcal_var_decl
  (identifier) @local.definition.var)

(pcal_with
  (identifier) @local.definition.parameter)

; Built-in PlusCal variables
(pcal_algorithm_body
  [
    (_
      (identifier_ref) @local.definition.var)
    (_
      (_
        (identifier_ref) @local.definition.var))
    (_
      (_
        (_
          (identifier_ref) @local.definition.var)))
    (_
      (_
        (_
          (_
            (identifier_ref) @local.definition.var))))
    (_
      (_
        (_
          (_
            (_
              (identifier_ref) @local.definition.var)))))
  ]
  (#any-of? @local.definition.var "self" "pc" "stack"))

; References
(identifier_ref) @local.reference

(prefix_op_symbol) @local.reference

(bound_prefix_op
  symbol: (_) @local.reference)

(infix_op_symbol) @local.reference

(bound_infix_op
  symbol: (_) @local.reference)

(postfix_op_symbol) @local.reference

(bound_postfix_op
  symbol: (_) @local.reference)

(bound_nonfix_op
  symbol: (_) @local.reference)
