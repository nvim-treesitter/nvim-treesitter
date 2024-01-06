(comment) @comment @spell

(key) @property

(value) @string

(value
  (escape) @string.escape)

((value) @boolean
  (#any-of? @boolean "true" "false"))

((value) @number
  (#lua-match? @number "^%d+$"))

(index) @number

(property
  [
    "="
    ":"
  ] @operator)

[
  "${"
  "}"
] @punctuation.special

(substitution
  ":" @punctuation.special)

[
  "["
  "]"
] @punctuation.bracket

[
  "."
  "\\"
] @punctuation.delimiter

((substitution
  (key) @constant)
  (#lua-match? @constant "^[A-Z_][A-Z0-9_]*$"))
