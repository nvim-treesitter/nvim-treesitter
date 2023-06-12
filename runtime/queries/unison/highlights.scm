; Primitives
(comment) @comment @spell

(nat) @number

(unit) @constant.builtin

(literal_char) @character

(literal_text) @string

(literal_boolean) @boolean

; Keywords
(type_kw) @keyword.type

[
  (kw_forall)
  (do)
  (kw_let)
  (ability)
  (where)
] @keyword

(structural) @keyword.modifier

(unique) @keyword.modifier

(type_constructor) @constructor

((doc_block) @comment.documentation @spell
  (#set! priority 90))

[
  (operator)
  (pipe)
  (arrow_symbol)
  (or)
  (kw_equals)
] @operator

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

(use_clause) @keyword.import

; Types
(record_field
  (field_name) @variable.member
  type: (regular_identifier) @type)

(type_name) @type

(type_declaration
  (regular_identifier) @type)

(ability_name
  (path)? @module
  (regular_identifier) @type)

(ability_declaration
  (ability_name) @type
  (type_argument) @variable.parameter)

(constructor
  (constructor_name) @constructor)

(constructor
  type: (regular_identifier) @type)

(effect
  (regular_identifier) @attribute) ; NOTE: an effect is a special type

; Namespaces
(path) @module

(namespace) @module

; Terms
(type_signature
  term_name: (path) @module
  term_name: (regular_identifier) @variable)

(type_signature
  term_name: (regular_identifier) @variable)

(term_type) @type

(term_definition
  name: (path) @module)

(term_definition
  name: (regular_identifier) @variable)

(term_definition
  param: (regular_identifier) @variable.parameter)

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

(watch_expression) @keyword.directive

(test_watch_expression) @keyword.directive
