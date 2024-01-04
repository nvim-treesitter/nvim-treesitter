(comment) @comment

(source "source" @keyword)

[ "exec" "exec-once" ] @keyword

(keyword
  (name) @keyword)

(assignment
  (name) @property)

(section
  (name) @namespace)

(section
  device: (name) @type)

(variable) @variable
(variable "$" @punctuation.special)

(number) @number

(boolean) @boolean

(mod) @constant

[
  "rgb"
  "rgba"
] @function.builtin

(color
  (legacy_hex) @number)

(angle) @number
(angle "deg" @type)

(hex) @number

[ "," ] @punctuation.delimiter

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
