(identifier) @variable

(section
  (identifier) @tag)

(section
  [
    "["
    "]"
  ] @tag.delimiter)

(attribute
  (identifier) @tag.attribute)

(property
  (path) @property)

(constructor
  (identifier) @constructor)

(string) @string

(integer) @number

(float) @number.float

[
  (true)
  (false)
] @boolean

(null) @constant.builtin

(array
  [
    "["
    "]"
  ] @punctuation.bracket)

[
  "("
  ")"
  "{"
  "}"
] @punctuation.bracket

"=" @operator

(comment) @comment @spell
