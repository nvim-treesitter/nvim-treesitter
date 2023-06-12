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
  (address)
  (all_map_to)
  (assign)
  (case_arrow)
  (case_box)
  (def_eq)
  (exists)
  (forall)
  (gets)
  (label_as)
  (maps_to)
  (set_in)
  (temporal_exists)
  (temporal_forall)
] @keyword

;  Pluscal keywords
[
  (pcal_algorithm_start)
  "algorithm"
  "assert"
  "begin"
  "call"
  "define"
  "end"
  "fair"
  "goto"
  "macro"
  "or"
  "procedure"
  "process"
  "skip"
  "variable"
  "variables"
  "when"
  "with"
] @keyword

"await" @keyword.coroutine

(pcal_with
  "=" @keyword)

(pcal_process
  "=" @keyword)

[
  "if"
  "then"
  "else"
  "elsif"
  (pcal_end_if)
  "either"
  (pcal_end_either)
] @keyword.conditional

[
  "while"
  "do"
  (pcal_end_while)
  "with"
  (pcal_end_with)
] @keyword.repeat

"return" @keyword.return

"print" @function.macro

; Literals
(binary_number
  (format) @keyword)

(binary_number
  (value) @number)

(boolean) @boolean

(boolean_set) @type

(hex_number
  (format) @keyword)

(hex_number
  (value) @number)

(int_number_set) @type

(nat_number) @number

(nat_number_set) @type

(octal_number
  (format) @keyword)

(octal_number
  (value) @number)

(real_number) @number

(real_number_set) @type

(string) @string

(escape_char) @string.escape

(string_set) @type

; Namespaces
(extends
  (identifier_ref) @module)

(instance
  (identifier_ref) @module)

(module
  name: (identifier) @module)

(pcal_algorithm
  name: (identifier) @module)

; Operators, functions, and macros
(bound_infix_op
  symbol: (_) @operator)

(bound_nonfix_op
  symbol: (_) @operator)

(bound_postfix_op
  symbol: (_) @operator)

(bound_prefix_op
  symbol: (_) @operator)

(prefix_op_symbol) @operator

(infix_op_symbol) @operator

(postfix_op_symbol) @operator

(function_definition
  name: (identifier) @function)

(module_definition
  name: (_) @keyword.import)

(operator_definition
  name: (_) @function.macro)

(pcal_macro_decl
  name: (identifier) @function.macro)

(pcal_macro_call
  name: (identifier) @function.macro)

(pcal_proc_decl
  name: (identifier) @function.macro)

(pcal_process
  name: (identifier) @function)

(recursive_declaration
  (identifier) @function.macro)

(recursive_declaration
  (operator_declaration
    name: (_) @function.macro))

; Constants and variables
(constant_declaration
  (identifier) @constant)

(constant_declaration
  (operator_declaration
    name: (_) @constant))

(pcal_var_decl
  (identifier) @variable)

(pcal_with
  (identifier) @variable.parameter)

("."
  .
  (identifier) @attribute)

(record_literal
  (identifier) @attribute)

(set_of_records
  (identifier) @attribute)

(variable_declaration
  (identifier) @variable)

; Parameters
(choose
  (identifier) @variable.parameter)

(choose
  (tuple_of_identifiers
    (identifier) @variable.parameter))

(lambda
  (identifier) @variable.parameter)

(module_definition
  (operator_declaration
    name: (_) @variable.parameter))

(module_definition
  parameter: (identifier) @variable.parameter)

(operator_definition
  (operator_declaration
    name: (_) @variable.parameter))

(operator_definition
  parameter: (identifier) @variable.parameter)

(pcal_macro_decl
  parameter: (identifier) @variable.parameter)

(pcal_proc_var_decl
  (identifier) @variable.parameter)

(quantifier_bound
  (identifier) @variable.parameter)

(quantifier_bound
  (tuple_of_identifiers
    (identifier) @variable.parameter))

(unbounded_quantification
  (identifier) @variable.parameter)

; Delimiters
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
  "."
  "!"
  ";"
  (bullet_conj)
  (bullet_disj)
  (prev_func_val)
  (placeholder)
] @punctuation.delimiter

; Proofs
(assume_prove
  (new
    (identifier) @variable.parameter))

(assume_prove
  (new
    (operator_declaration
      name: (_) @variable.parameter)))

(assumption
  name: (identifier) @constant)

(pick_proof_step
  (identifier) @variable.parameter)

(proof_step_id
  "<" @punctuation.bracket)

(proof_step_id
  (level) @label)

(proof_step_id
  (name) @label)

(proof_step_id
  ">" @punctuation.bracket)

(proof_step_ref
  "<" @punctuation.bracket)

(proof_step_ref
  (level) @label)

(proof_step_ref
  (name) @label)

(proof_step_ref
  ">" @punctuation.bracket)

(take_proof_step
  (identifier) @variable.parameter)

(theorem
  name: (identifier) @constant)

; Comments and tags
(block_comment
  "(*" @comment)

(block_comment
  "*)" @comment)

(block_comment_text) @comment @spell

(comment) @comment @spell

(single_line) @comment

(_
  label: (identifier) @label)

(label
  name: (_) @label)

(pcal_goto
  statement: (identifier) @label)
