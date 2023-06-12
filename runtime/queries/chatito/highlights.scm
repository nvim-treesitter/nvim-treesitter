; Punctuation
[
  "%["
  "@["
  "~["
  "*["
  "]"
  "("
  ")"
] @punctuation.bracket

[
  ":"
  ","
] @punctuation.delimiter

([
  "\""
  "'"
] @punctuation.special
  (#set! conceal ""))

[
  "%"
  "?"
  "#"
] @character.special

; Entities
(intent) @module

(slot) @type

(variation) @type.qualifier

(alias) @keyword.directive

(number) @number

(argument
  key: (string) @property
  value: (string) @string)

(escape) @string.escape

; Import
"import" @keyword.import

(file) @string.special.path

; Text
(word) @spell

; Comment
(comment) @comment @spell
