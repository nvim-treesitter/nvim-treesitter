(string) @string

(field_name) @variable.member

(comment) @comment

(number) @number

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
