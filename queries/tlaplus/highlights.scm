; highlights.scm

; Keywords
[
  "ACTION"
  "ASSUME"
  "ASSUMPTION"
  "AXIOM"
  "BY"
  "CASE"
  "CHOOSE"
  "CONSTANT"
  "CONSTANTS"
  "COROLLARY"
  "DEF"
  "DEFINE"
  "DEFS"
  "DOMAIN"
  "ELSE"
  "ENABLED"
  "EXCEPT"
  "EXTENDS"
  "HAVE"
  "HIDE"
  "IF"
  "IN"
  "INSTANCE"
  "LAMBDA"
  "LEMMA"
  "LET"
  "LOCAL"
  "MODULE"
  "NEW"
  "OBVIOUS"
  "OMITTED"
  "ONLY"
  "OTHER"
  "PICK"
  "PROOF"
  "PROPOSITION"
  "PROVE"
  "QED"
  "RECURSIVE"
  "SF_"
  "STATE"
  "SUBSET"
  "SUFFICES"
  "TAKE"
  "TEMPORAL"
  "THEN"
  "THEOREM"
  "UNCHANGED"
  "UNION"
  "USE"
  "VARIABLE"
  "VARIABLES"
  "WF_"
  "WITH"
  "WITNESS"
  (forall)
  (exists)
  (temporal_forall)
  (temporal_exists)
  (set_in)
  (gets)
  (case_box)
  (case_arrow)
  (label_as)
] @keyword
[
  (def_eq)
  (maps_to)
  (all_map_to)
] @keyword.function

; Literals
(number) @number
(string) @string
(boolean) @boolean
(primitive_value_set) @type

; Comments
(comment) @comment
(block_comment) @comment
(unit (single_line) @comment)
(extramodular_text) @text

; Namespaces
(module name: (identifier) @namespace)
(extends (identifier_ref) @namespace)
(instance (identifier_ref) @namespace)
(module_definition name: (identifier) @namespace)

; Constants, Variables, and Operators
(variable_declaration (identifier) @variable)
(constant_declaration (identifier) @constant)
(operator_definition name: (_) @function.macro)
(function_definition name: (identifier) @function)
(bound_prefix_op symbol: (_) @operator)
(bound_infix_op symbol: (_) @operator)
(bound_postfix_op symbol: (_) @operator)

; Parameters
(operator_definition parameter: (identifier) @parameter)
(operator_definition (operator_declaration name: (_) @parameter))
(module_definition parameter: (identifier) @parameter)
(module_definition (operator_declaration name: (_) @parameter))
(function_definition (quantifier_bound (identifier) @parameter))
(function_definition (quantifier_bound (tuple_of_identifiers (identifier) @parameter)))
(lambda (identifier) @parameter)

; Punctuation and Delimiters
[
  (langle_bracket)
  (rangle_bracket)
  (rangle_bracket_sub)
  "{"
  "}"
  "["
  "]"
  "]_"
  "("
  ")"
] @punctuation.bracket
[
  ","
  ":"
  "<"
  ">"
  "!"
] @punctuation.delimiter
(bullet_conj) @punctuation.special
(bullet_disj) @punctuation.special
(prev_func_val) @punctuation.special

; Proofs
(proof_step_id (level) @number)
(proof_step_id (name) @symbol)
(proof_step_ref (level) @number)
(proof_step_ref (name) @symbol)
