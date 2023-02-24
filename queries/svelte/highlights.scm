; inherits: html_tags

(raw_text_expr) @none

[
  (special_block_keyword)
  (then)
  (as)
] @keyword

((special_block_keyword) @keyword.coroutine
  (#eq? @keyword.coroutine "await"))

[
  "{"
  "}"
] @punctuation.bracket

[
  "#"
  ":"
  "/"
  "@"
] @tag.delimiter
