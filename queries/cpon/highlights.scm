; Literals

(string) @string
(escape_sequence) @string.escape

(hex_blob
  "x" @character.special
  (_) @string)

(esc_blob
  "b" @character.special
  (_) @string)

(datetime
  "d" @character.special
  (_) @string.special)

(number) @number

(float) @float

(boolean) @boolean

(null) @constant.builtin

; Punctuation

[
  ","
  ":"
] @punctuation.delimiter

[ "{" "}" ] @punctuation.bracket

[ "[" "]" ] @punctuation.bracket

[ "<" ">" ] @punctuation.bracket

; Comments

(comment) @comment @spell

; Errors

(ERROR) @error
