[
  "Show"
  "Hide"
  "Minimal"
] @module

[
  "Import"
  "Optional"
] @keyword.import

(condition
  (name) @keyword.conditional)

(action
  (name) @keyword)

(continue) @label

(operator) @operator

(string) @string

(file) @string.special.path

[
  (quality)
  (rarity)
  (influence)
  (colour)
  (shape)
] @constant.builtin

(sockets) @variable.builtin

(number) @number

(boolean) @boolean

[
  (disable)
  "Temp"
] @constant

(comment) @comment @spell

"\"" @punctuation.delimiter

; conceal unnecessary quotes
("\"" @conceal
  (#not-has-parent? @conceal string file)
  (#set! conceal ""))
