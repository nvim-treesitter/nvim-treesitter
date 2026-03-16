(string) @string

(field_name) @variable.member

(comment) @comment @spell

(number) @number

"-" @operator

[
  ":"
  ";"
  ","
  "."
  "/"
] @punctuation.delimiter

(string_escape) @string.escape

; For stuff like "inf" and "-inf".
(scalar_value
  [
    (identifier)
    (signed_identifier)
  ]) @number

[
  (open_squiggly)
  (close_squiggly)
  (open_square)
  (close_square)
  (open_arrow)
  (close_arrow)
] @punctuation.bracket
