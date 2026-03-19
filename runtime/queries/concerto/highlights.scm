; Concerto Language - Syntax Highlighting Queries
; =================================================
; Keywords
; --------
; Declaration keywords
[
  "concept"
  "asset"
  "participant"
  "transaction"
  "event"
  "enum"
  "scalar"
  "map"
] @keyword.type

[
  "namespace"
  "import"
  "from"
] @keyword.import

"extends" @keyword

"abstract" @keyword.modifier

[
  "identified"
  "by"
] @keyword

"optional" @keyword.modifier

[
  "concerto"
  "version"
] @keyword

"default" @keyword

[
  "regex"
  "range"
  "length"
] @keyword

"as" @keyword

; Primitive type keywords
[
  "String"
  "Boolean"
  "DateTime"
  "Integer"
  "Long"
  "Double"
] @type.builtin

(primitive_type) @type.builtin

; Boolean literals
(boolean_literal) @boolean

; Comments
; --------
(line_comment) @comment

(block_comment) @comment

; Strings
; -------
(string_literal) @string

(escape_sequence) @string.escape

; Numbers
; -------
(signed_integer) @number

(signed_real) @number

(signed_number) @number

; Regex
; -----
(regex_literal) @string.regexp

; Decorators
; ----------
(decorator
  "@" @attribute
  name: (identifier) @attribute)

; Namespace and imports
; --------------------
(namespace_path) @module

(import_path) @module

(uri) @string.special

; Version
; -------
(concerto_version
  (string_literal) @string.special)

; Type identifiers (in type position)
; -----------------------------------
(concept_declaration
  name: (type_identifier) @type)

(asset_declaration
  name: (type_identifier) @type)

(participant_declaration
  name: (type_identifier) @type)

(transaction_declaration
  name: (type_identifier) @type)

(event_declaration
  name: (type_identifier) @type)

(enum_declaration
  name: (type_identifier) @type)

(scalar_declaration
  name: (type_identifier) @type)

(map_declaration
  name: (type_identifier) @type)

(extends_clause
  (type_identifier) @type)

; Field type references
(object_field
  type: (type_identifier) @type)

(relationship_field
  type: (type_identifier) @type)

; Map type references
(map_key_type
  type: (type_identifier) @type)

(map_value_property
  type: (type_identifier) @type)

(map_value_relationship
  type: (type_identifier) @type)

; Decorator identifier references
(decorator_identifier_ref
  (type_identifier) @type)

; Import type name
(import_single
  type: (identifier) @type)

(type_list_item
  (identifier) @type)

(aliased_type
  original: (identifier) @type
  alias: (identifier) @type)

; Field/property names
; --------------------
(string_field
  name: (identifier) @property)

(boolean_field
  name: (identifier) @property)

(datetime_field
  name: (identifier) @property)

(integer_field
  name: (identifier) @property)

(long_field
  name: (identifier) @property)

(double_field
  name: (identifier) @property)

(object_field
  name: (identifier) @property)

(relationship_field
  name: (identifier) @property)

(enum_property
  name: (identifier) @property)

; Identified by field name
(identified_by
  field: (identifier) @property)

; Relationship arrow
"-->" @operator

; Property indicator
"o" @punctuation.special

; Array indicator
(array_indicator) @punctuation.bracket

; Wildcards in imports
"*" @operator

; Delimiters
; ----------
"{" @punctuation.bracket

"}" @punctuation.bracket

"(" @punctuation.bracket

")" @punctuation.bracket

"[" @punctuation.bracket

"]" @punctuation.bracket

"," @punctuation.delimiter

"." @punctuation.delimiter

"=" @operator
