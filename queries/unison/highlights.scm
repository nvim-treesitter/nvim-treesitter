;; Primitives
(comment) @comment
(nat) @number
(unit) @constant.builtin
(literal_char) @character
(literal_text) @string
(literal_boolean) @boolean

;; Keywords
[
  (kw_forall)
  (unique_kw)
  (type_kw)
  (kw_equals)
  (do)
] @keyword

(kw_let) @keyword.function
(structural_kw) @storageclass
(unique) @storageclass

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
] @conditional

(blank_pattern) @variable.builtin

((pattern) @variable (constructor_or_variable_pattern) @type)

(use_clause) @include

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
