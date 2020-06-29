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
(type_identifier) @type
(predefined_type) @type.builtin

(type_arguments
  "<" @punctuation.bracket
  ">" @punctuation.bracket)

; Variables

(required_parameter (identifier) @variable.parameter)
(optional_parameter (identifier) @variable.parameter)
