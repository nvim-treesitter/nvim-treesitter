(comment) @comment

; identifiers eel

(eel_object_path
  (eel_path_identifier) @variable)

(eel_object_pair
  key: (eel_property_name) @property)

(eel_method_name) @function

(eel_parameter) @variable


; identifiers fusion
; -----------

(path_part) @property
(meta_property) @attribute
(prototype_signature
  "prototype" @keyword

)
(include_statement
  "include" @include
  ":" @punctuation.delimiter
  (source_file) @text.uri
)

(namespace_declaration
  "namespace" @keyword
  (alias_namespace) @namespace)

(identifier_type
  name: (type_name) @type)

; tokens
; ------

[
  (identifier_package)
  (alias_namespace)
] @namespace

[
  "="
  "<"
  "&&"
  "and"
  "||"
  "or"
  "*"
  "/"
  "%"
  "+"
  "-"
  "!"
  "not"
  (deletion)
] @operator

(string) @string
(number) @number
(boolean) @boolean
(null) @constant.builtin


; punctuation
; ----------

[
 "("
 ")"
 "{"
 "}"
 "["
 "]"
] @punctuation.bracket

[
 ":"
 "."
 "?"
] @punctuation.delimiter
