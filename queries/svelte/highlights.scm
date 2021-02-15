((element (start_tag (tag_name) @_tag) (text) @text.title)
 (#match? @_tag "^(h[0-9]|title)$"))

((element (start_tag (tag_name) @_tag) (text) @text.strong)
 (#match? @_tag "^(strong|b)$"))

((element (start_tag (tag_name) @_tag) (text) @text.emphasis)
 (#match? @_tag "^(em|i)$"))

((element (start_tag (tag_name) @_tag) (text) @text.strike)
 (#match? @_tag "^(s|del)$"))

((element (start_tag (tag_name) @_tag) (text) @text.underline)
 (#eq? @_tag "u"))

((element (start_tag (tag_name) @_tag) (text) @text.literal)
 (#match? @_tag "^(code|kbd)$"))

((element (start_tag (tag_name) @_tag) (text) @text.uri)
 (#eq? @_tag "a"))

((attribute
   (attribute_name) @_attr
   (quoted_attribute_value (attribute_value) @text.uri))
 (#eq? @_attr "href"))

(tag_name) @tag
(attribute_name) @property
(errorneous_end_tag_name) @error
(comment) @comment

[
  (attribute_value)
  (quoted_attribute_value)
] @string

[
  (text)
  (raw_text_expr)
] @none

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
