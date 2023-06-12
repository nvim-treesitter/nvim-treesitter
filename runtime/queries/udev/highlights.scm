(match
  key: _ @keyword)

(assignment
  key: _ @property)

(value) @string

; NOTE: higher priorities override bash highlights
((fmt_sub
  .
  _ @character.special)
  (#set! priority 101))

((var_sub
  .
  _ @variable.builtin)
  (#set! priority 101))

[
  (system_const)
  (run_type)
  (import_type)
  (kernel_param)
  (seclabel)
] @attribute

((attribute) @attribute
  (#set! priority 101))

((env_var) @constant
  (#set! priority 101))

((pattern) @string.special
  (#set! priority 101))

([
  "\\\""
  (c_escape)
] @string.escape
  (#set! priority 101))

(octal) @number

((number) @number
  (#set! priority 101))

[
  (match_op)
  (assignment_op)
] @operator

("+" @punctuation.special
  (#set! priority 101))

([
  "{"
  "}"
] @punctuation.bracket
  (#set! priority 101))

[
  ","
  (linebreak)
] @punctuation.delimiter

(comment) @comment @spell
