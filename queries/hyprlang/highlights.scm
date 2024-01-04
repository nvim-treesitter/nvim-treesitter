(comment) @comment

(source "source" @keyword)

(exec "exec" @keyword)
(exec "exec-once" @keyword)

(keyword
  (name) @keyword
)

(assignment
  (name) @property
)

(section
  (name) @namespace
)

(section
  device: (name) @type
)

(variable) @variable
(variable "$" @punctuation.special)

(number) @number

(boolean) @boolean

(mod) @constant

(vec2
  (number) @number
  (number) @number
)

[
  "rgb"
  "rgba"
] @function

(color
  (legacy_hex) @number
)

(angle) @number
(angle "deg" @type)

(hex) @number

[ "," ] @punctuation

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
