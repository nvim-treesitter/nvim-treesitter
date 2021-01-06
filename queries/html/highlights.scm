(tag_name) @tag
(erroneous_end_tag_name) @error
(doctype) @constant
(attribute_name) @property
(attribute_value) @string
(quoted_attribute_value) @string
(comment) @comment

"=" @operator

[
 "<"
 "<!"
 ">"
 "</"
 "/>"
 ] @tag.delimiter
