(option . _ @keyword)

(option
  ("no-" @parameter)?
  (name) @parameter)

(string (content) @string)

[
 (value)
 "clear"
] @string.special

(url) @text.uri

(key) @constant

[
 (number)
 (expire_time)
 (iso_time)
] @number

(format) @character.special

"sensitive:" @type.qualifier

(filter_name) @parameter

(filter_scope) @namespace

(filter_property) @property

(filter_value) @string

[
 (filter_op0)
 (filter_op1)
 (filter_lc)
 "="
] @operator

"!" @punctuation.special

[ "\"" "'" "," ] @punctuation.delimiter

(comment) @comment @spell
