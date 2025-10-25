(comment) @comment @spell

[
  "source"
  "exec"
  "execr"
  "exec-once"
  "execr-once"
  "exec-shutdown"
] @keyword

(keyword
  (name) @keyword)

(assignment
  (name) @property)

(section
  (name) @module)

(window_rule
  (name) @function.call)

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
  ";"
  ":"
  "x"
  "@"
] @punctuation.delimiter

[
  "("
  ")"
  "{"
  "}"
  "["
  "]"
] @punctuation.bracket

[
  "="
  "-"
  "+"
] @operator
