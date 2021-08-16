(text) @text
(comment) @comment
(doctype) @constant

; HEEx attributes are highlighted as HTML attributes
(attribute_name) @tag.attribute
(quoted_attribute_value) @string

[
  "%>"
  "/>"
  "<!"
  "<"
  "<%"
  "<%#"
  "<%%="
  "<%="
  "</"
  ">"
  "{"
  "}"
] @tag.delimiter

[
  "="
] @operator

; HEEx tags are highlighted as HTML
(tag_name) @tag

; HEEx components are highlighted as types (Elixir modules)
(component_name) @type

