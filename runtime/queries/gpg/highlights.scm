(option
  .
  _ @keyword)

(option
  ("no-" @variable.parameter)?
  (name) @variable.parameter)

(string
  (content) @string)

[
  (value)
  "clear"
] @string.special

(url) @string.special.url

(key) @constant

[
  (number)
  (expire_time)
  (iso_time)
] @number

(format) @character.special

"sensitive:" @type.qualifier

(filter_name) @variable.parameter

(filter_scope) @module

(filter_property) @property

(filter_value) @string

[
  (filter_op0)
  (filter_op1)
  (filter_lc)
  "="
] @operator

"!" @punctuation.special

[
  "\""
  "'"
  ","
] @punctuation.delimiter

(comment) @comment @spell
