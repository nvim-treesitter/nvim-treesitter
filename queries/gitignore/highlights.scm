(comment) @comment @spell

(pattern_char) @string.special.path

[
  (directory_separator)
  (directory_separator_escaped)
] @punctuation.delimiter

[
  (wildcard_char_single)
  (wildcard_chars)
  (wildcard_chars_allow_slash)
] @character.special

[
  (pattern_char_escaped)
  (bracket_char_escaped)
] @string.escape

(negation) @punctuation.special

(bracket_negation) @operator

; bracket expressions
[
  "["
  "]"
] @punctuation.bracket

(bracket_char) @constant

(bracket_range
  "-" @operator)

(bracket_char_class) @constant.builtin
