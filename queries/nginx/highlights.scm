(comment) @comment @spell

(value) @variable

(attribute
  (keyword) @attribute)

[
  (location_modifier)
  "="
] @operator

[
  (keyword)
  "location"
] @keyword

[
  "if"
  "map"
] @keyword.conditional

(boolean) @boolean

[
  (auto)
  (constant)
  (level)
  (connection_method)
  (var)
  condition: (condition)
] @variable.builtin

[
  (string_literal)
  (file)
  (mask)
] @string

(directive
  (variable) @variable.parameter)

(directive
  (variable
    (keyword) @variable.parameter))

(location_route) @string.special

";" @punctuation.delimiter

[
  (numeric_literal)
  (time)
  (size)
  (cpumask)
] @number

[
  "{"
  "}"
] @punctuation.bracket
