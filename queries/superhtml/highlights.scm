(doctype) @constant

(comment) @comment

(tag_name) @tag

((tag_name) @string.special
  (#any-of? @string.special "super" "extend"))

(attribute_name) @attribute

(attribute_value) @string

((element
  (start_tag
    (attribute
      (attribute_name) @_attribute
      [
        (attribute_value) @markup.link.url
        (quoted_attribute_value
          (attribute_value) @markup.link.url)
      ]))
  (element
    (start_tag
      (tag_name) @tag)))
  (#eq? @tag "super")
  (#eq? @_attribute "id"))

(element
  (start_tag
    (tag_name) @string.special)
  (#eq? @string.special "super"))

"\"" @string

[
  "<"
  ">"
  "</"
  "/>"
  "<!"
] @punctuation.bracket

"=" @punctuation.delimiter
