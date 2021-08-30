(identifier) @identifier
(keyword) @keyword
(string_literal) @string
(number_literal) @number
(html_string) @tag

[
  (edgeop)
  (operator)
] @operator

[
  ","
  ";"
] @punctuation.delimiter

[
  "{"
  "}"
  "["
  "]"
] @punctuation.bracket

(attribute
  name: (id
    (identifier) @type)
)

(attribute
  value: (id
    (identifier) @constant)
)

[
(comment)
(preproc)
] @comment

(ERROR) @error
