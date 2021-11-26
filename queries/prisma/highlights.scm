[
 "datasource"
 "enum"
 "generator"
 "model"
] @keyword

[
  (comment)
  (developer_comment)
] @comment

[
  (attribute)
  (call_expression)
] @function

(arguments) @property
(column_type) @type
(enumeral) @constant
(identifier) @variable
(string) @string

[
  "("
  ")"
  "["
  "]"
  "{"
  "}"
] @punctuation.bracket

[
  "="
  "@"
] @operator
