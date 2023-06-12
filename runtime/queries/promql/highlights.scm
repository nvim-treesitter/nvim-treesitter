; highlights.scm
[
  "*"
  "/"
  "%"
  "+"
  "-"
  ">"
  ">="
  "<"
  "<="
  "="
  "=~"
  "!="
  "!~"
] @operator

[
  "{"
  "}"
  "["
  "]"
  "("
  ")"
] @punctuation.bracket

(float_literal) @number.float

(string_literal) @string

(metric_name) @type

(range_selection) @type

(subquery_range_selection) @type

(label_name) @variable.member

(label_value) @string.regexp

(function_name) @function.call

(comment) @comment @spell
