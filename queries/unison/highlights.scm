; Primitives
(comment) @comment @spell

(nat) @number

(unit) @constant.builtin

(literal_char) @character

(literal_text) @string

(literal_boolean) @boolean

; Keywords
[
  (kw_forall)
  (unique)
  (type_kw)
  (do)
  (kw_let)
  (ability)
  (where)
] @keyword

(kw_equals) @keyword.operator

(structural) @type.qualifier

(unique) @type.qualifier

(type_constructor) @constructor

(doc_block) @comment.documentation

[
  (operator)
  (pipe)
  (arrow_symbol)
  ">"
  (or)
] @keyword.operator

[
  "if"
  "else"
  "then"
  (match)
  (with)
  (cases)
] @keyword.conditional

(blank_pattern) @variable.builtin

(pattern) @variable

(constructor_or_variable_pattern) @type

(use_clause) @keyword.import

; Types
(record_field
  name: (wordy_id) @variable
  type: (wordy_id) @type)

(type_name) @type

(ability_declaration
  type_name: (wordy_id) @type
  type_arg: (wordy_id) @variable.parameter)

(effect
  (wordy_id) @attribute) ; NOTE: an effect is a special type

; Namespaces
(path) @module

(namespace) @module

; Terms
(type_signature
  term_name: (path) @module
  term_name: (wordy_id) @variable)

(type_signature
  term_name: (wordy_id) @variable)

(term_type) @type

(function_application
  function_name: (path)
  function_name: (wordy_id) @function)

(term_definition
  name: (wordy_id) @variable)

(term_definition
  param: (wordy_id) @variable.parameter)

; Punctuation
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

(test_watch_expression
  (wordy_id) @keyword.directive)
