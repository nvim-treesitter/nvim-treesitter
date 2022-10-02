;;;; Simple tokens ;;;;
(terminal) @string.grammar

(special_sequence) @string.special.grammar

(integer) @number

(comment) @comment

;;;; Identifiers ;;;;

; Allow different highlighting for specific casings
((identifier) @type
 (#match? @type "^[A-Z]"))

((identifier) @symbol
 (#match? @symbol "^[a-z]"))

((identifier) @constant
 (#match? @constant "^[A-Z][A-Z0-9_]+$"))

;;; Punctuation ;;;;
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
