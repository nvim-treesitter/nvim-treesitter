(tag_name) @tag
(attribute_name) @property
(attribute_value) @string
(quoted_attribute_value) @string
(comment) @comment

[
  (special_block_keyword)
  (then)
  (as)
] @keyword

[
  "{"
  "}"
] @punctuation.bracket

"=" @operator

[
  "<"
  ">"
  "</"
  "/>"
  "#"
  ":"
  "/"
  "@"
] @tag.delimiter
