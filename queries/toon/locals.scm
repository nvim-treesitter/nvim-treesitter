; locals.scm - Local scope and reference queries for TOON
; Used for features like go-to-definition, scope highlighting
; Each object creates a new scope
(object) @local.scope

; Keys define local names within their scope
(pair
  key: (key) @local.definition)

; Array declarations define names
(array_declaration
  key: (key) @local.definition)

; Field names in tabular arrays are definitions
(field_name) @local.definition
