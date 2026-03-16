(comment) @comment @spell

(property) @property

(string) @string

(header
  (glob) @string.special.path)

(character) @character

(character_escape) @string.escape

(wildcard) @character.special

(integer) @number

[
  "["
  "]"
  "{"
  "}"
] @punctuation.bracket

[
  ","
  ".."
  "/"
  "-"
] @punctuation.delimiter

[
  "="
  "!"
] @operator
