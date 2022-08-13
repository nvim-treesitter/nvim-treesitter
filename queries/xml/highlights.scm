[
 "<"
 ">"
 "</"
 "/>"
] @tag.delimiter

"=" @operator
[(start_tag) (end_tag) (xml_decl)] @tag

["\"" "encoding" "1."] @string

(attribute_name) @tag.attribute
(comment) @comment
