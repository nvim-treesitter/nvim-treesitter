; Simple tokens ;;;;
(terminal) @string

(special_sequence) @string.special

(integer) @number

(comment) @comment @spell

; Identifiers ;;;;
; Allow different highlighting for specific casings
((identifier) @type
  (#lua-match? @type "^%u"))

((identifier) @string.special.symbol
  (#lua-match? @string.special.symbol "^%l"))

((identifier) @constant
  (#lua-match? @constant "^%u[%u%d_]+$"))

; Punctuation ;;;;
[
  ";"
  ","
] @punctuation.delimiter

[
  "|"
  "*"
  "-"
] @operator

"=" @keyword.operator

[
  "("
  ")"
  "["
  "]"
  "{"
  "}"
] @punctuation.bracket
