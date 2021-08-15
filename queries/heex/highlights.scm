; HEEx text is highlighted as such
(text) @text

; HEEx has two types of comments, both are highlighted as such
(comment) @comment

; HEEx attributes are highlighted as HTML attributes
(attribute_name) @tag.attribute

; Attributes are highlighted as strings
(quoted_attribute_value) @string

; HEEx supports HTML tags and are highlighted as such
[
  "<"
  ">"
  "</"
  "/>"
  "<%"
  "<%="
  "<%%="
  "<%#"
  "%>"
  "{"
  "}"
] @tag.delimiter

; HEEx tags are highlighted as HTML
(tag_name) @tag

; HEEx components are highlighted as types (Elixir modules)
(component_name) @type

; HEEx operators
["="] @operator
