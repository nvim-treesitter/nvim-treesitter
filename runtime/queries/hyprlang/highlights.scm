(comment) @comment @spell

[
  "source"
  "exec"
  "exec-once"
] @keyword

(keyword
  (name) @keyword)

(assignment
  (name) @property)

(section
  (name) @module)

(section
  device: (device_name) @string.special)

(variable) @variable

"$" @punctuation.special

(boolean) @boolean

[
  "deg"
  (string)
  (string_literal)
] @string

(mod) @constant.builtin

[
  "rgb"
  "rgba"
] @function.builtin

[
  (number)
  (legacy_hex)
  (angle)
  (hex)
] @number

[
  ","
  ":"
  "x"
  "@"
] @punctuation.delimiter

[
  "("
  ")"
  "{"
  "}"
] @punctuation.bracket

[
  "="
  "-"
  "+"
] @operator
