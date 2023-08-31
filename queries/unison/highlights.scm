;; Primitives
(comment) @comment
(nat) @constant.numeric
(unit) @constant.builtin
(literal_char) @constant.character
(literal_text) @string
(literal_boolean) @constant.builtin.boolean

;; Keywords
[
  (kw_forall)
  (unique_kw)
  (type_kw)
  (kw_equals)
  (do)
] @keyword

(kw_let) @keyword.function
(structural_kw) @keyword.storage.type
(unique) @keyword.storage.modifier

[ 
  (type_constructor)
] @constructor

(doc_block) @comment


[
  (operator)
  (pipe) 
  (arrow_symbol) 
  (">")
  (or)
] @operator

[
  "if"
  "else"
  "then"
  (match)
  (with)
  (cases)
] @keyword.control.conditional

(blank_pattern) @variable.builtin

((pattern) @variable (constructor_or_variable_pattern) @type)

(use_clause) @keyword.control.import

;; Types
(record_field name: (wordy_id) @variable type: (wordy_id) @type)
[
  (type_name)
  (type_signature)
  (effect)
] @type

(term_definition) @variable

;; Punctuation
[
  (type_signature_colon)
  ":"
] @punctuation.delimiter

[
  "("
  ")"
  "{"
  "}"
  "["
  "]"
] @punctuation.bracket
