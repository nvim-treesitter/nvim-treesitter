(doctype) @constant

(comment) @comment

((tag_name) @string.special
  (#any-of? @string.special "super" "extend"))

(tag_name) @tag

((element
  (start_tag
    (attribute
      (attribute_name) @attribute
      [
        (attribute_value) @markup.link.url
        (quoted_attribute_value
          (attribute_value) @markup.link.url)
      ]))
  (element
    (start_tag
      (tag_name) @tag)))
  (#eq? @tag "super")
  (#eq? @attribute "id"))

((element
  (start_tag
    (tag_name) @string.special
    (attribute
      (attribute_name) @attribute)+))
  (#eq? @string.special "super"))

(attribute_name) @attribute

[
  "\""
  (attribute_value)
] @string

[
  "<"
  ">"
  "</"
  "/>"
  "<!"
] @punctuation.bracket

"=" @punctuation.delimiter
