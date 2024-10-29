[
  (start_delimiter)
  (end_delimiter)
  "{"
  "}"
] @punctuation.bracket

(identifier) @constant

(partial_content) @constant.macro

"." @punctuation.delimiter

[
  "#"
  "/"
  "^"
  ">"
] @character

(comment_statement) @comment
