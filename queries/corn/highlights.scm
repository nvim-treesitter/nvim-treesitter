[
  "let"
  "in"
] @keyword

[
  "{"
  "}"
  "["
  "]"
] @punctuation.bracket

"." @punctuation.delimiter

[
  ".."
  "="
] @operator

(input) @constant

(null) @constant.builtin

(comment) @comment @spell

(string) @string

(integer) @number

(float) @number.float

(float
  "." @number.float)

(boolean) @boolean

(path_seg) @property
