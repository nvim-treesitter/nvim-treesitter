(comment) @comment
(afx_comment) @comment

; identifiers afx
(afx_opening_element
  (afx_identifier) @tag)
(afx_closing_element
  (afx_identifier) @tag)
(afx_element_self_closing
  (afx_identifier) @tag)

(afx_attribute
  (afx_property_identifier) @attribute)

; identifiers eel

(eel_object_path
  (eel_path_identifier) @variable.builtin
  (#match? @variable.builtin "^(this|props)$")
)

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
  [
   "include"
  ] @include
  (source_file) @text.uri
)

(namespace_declaration
  "namespace" @keyword
  (alias_namespace) @namespace)

(type
  name: (type_name) @type)

; tokens
; ------
(afx_opening_element
  [
   "<"
   ">"
   ] @punctuation.bracket)

 (afx_closing_element
  [
   "<"
   ">"
   "/"
   ] @punctuation.bracket)

(afx_element_self_closing
  [
   "<"
   ">"
   "/"
   ] @punctuation.bracket)

[
  (package_name)
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
