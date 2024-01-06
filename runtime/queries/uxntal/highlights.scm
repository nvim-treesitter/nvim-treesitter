; Includes
(include
  "~" @keyword.import
  _ @string.special.url)

; Variables
(identifier) @variable

; Macros
(macro
  "%"
  (identifier) @function.macro)

((identifier) @function.macro
  (#lua-match? @function.macro "^[a-z]?[0-9]*[A-Z-_]+$"))

(rune
  .
  rune_start:
    (rune_char
      ",")
  .
  (identifier) @function.call)

(rune
  .
  rune_start:
    (rune_char
      ";")
  .
  (identifier) @function.call)

((identifier) @function.call
  (#lua-match? @function.call "^:"))

; Keywords
(opcode) @keyword

; Labels
(label
  "@" @string.special.symbol
  (identifier) @function)

(sublabel_reference
  (identifier) @module
  "/" @punctuation.delimiter
  (identifier) @label)

; Repeats
((identifier) @keyword.repeat
  (#eq? @keyword.repeat "while"))

; Literals
(raw_ascii) @string

(hex_literal
  "#" @string.special.symbol
  (hex_lit_value) @string.special)

(number) @number

; Punctuation
[
  "{"
  "}"
] @punctuation.bracket

[
  "["
  "]"
] @punctuation.bracket

[
  "%"
  "|"
  "$"
  ","
  "_"
  "."
  "-"
  ";"
  "="
  "!"
  "?"
  "&"
] @punctuation.special

; Comments
(comment) @comment @spell
