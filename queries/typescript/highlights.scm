; inherits: javascript
[
"abstract"
"declare"
"enum"
"export"
"implements"
"interface"
"keyof"
"namespace"
"private"
"protected"
"public"
"type"
] @keyword

(readonly) @keyword

; types

(type_identifier) @type
(predefined_type) @type.builtin

; punctuation

(type_arguments
  "<" @punctuation.bracket
  ">" @punctuation.bracket)

(union_type 
  "|" @punctuation.delimiter)

(intersection_type 
  "&" @punctuation.delimiter)

(type_annotation
  ":" @punctuation.delimiter)

(pair
  ":" @punctuation.delimiter)

(property_signature "?" @punctuation.special)
(optional_parameter "?" @punctuation.special)

; Variables

(undefined) @variable.builtin

(required_parameter (identifier) @parameter)
(optional_parameter (identifier) @parameter)
