; Surface has two types of comments, both are highlighted as such
[
  (comment) 
] @comment

; Disable highlighting for injection sites and plain text
[
  (text) 
  (expression)
] @none

; Attributes are highlighted as strings
[
  (attribute_value)
] @string

; Surface blocks are highlighted as keywords
[
  (start_block) 
  (end_block)
] @keyword

; Surface supports HTML tags and are highlighted as such
[
  (start_tag)
  (end_tag)
  (self_closing_tag)
] @tag.delimiter


; Surface components are highlighted as Elixir modules
((tag_name) @tag)
((tag_name) @type (#match? @type "^[A-Z#]+.*"))

; Surface directives are highligted as keywords
((attribute_name) @tag.attribute)
((attribute_name) @keyword (#match? @keyword "^[:]+.*"))

; Surface operators
[
  "="
] @operator
