[
 "!"
 "="
] @operator

[
 ","
 "."
 ";"
 "/"
] @punctuation.delimiter

[
 "("
 ")"
] @punctuation.bracket

(property
  key: (identifier) @field)
(value) @string
(string_literal) @string
(cap
  .
  (identifier) @string
  .
  (identifier) @string)
(simple_element
  type: (_) @type)
(bin
  type: (_) @type)
