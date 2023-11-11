; inherits: html_tags
(raw_text_expr) @none

[
  (special_block_keyword)
  (then)
  (as)
] @keyword

((special_block_keyword) @keyword.coroutine
  (#eq? @keyword.coroutine "await"))

((special_block_keyword) @keyword.exception
  (#eq? @keyword.exception "catch"))

((special_block_keyword) @keyword.conditional
  (#any-of? @keyword.conditional "if" "else"))

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
