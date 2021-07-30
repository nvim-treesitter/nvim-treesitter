; Surface text is highlighted as such
(text) @text

; Surface has two types of comments, both are highlighted as such
(comment) @comment

; Surface attributes are highlighted as HTML attributes
(attribute_name) @tag.attribute

; Attributes are highlighted as strings
(attribute_value) @string

; Surface blocks are highlighted as keywords
[
  (start_block) 
  (end_block)
  (subblock)
] @keyword

; Surface supports HTML tags and are highlighted as such
[
  (start_tag)
  (end_tag)
  (self_closing_tag)
  (start_component)
  (end_component)
  (self_closing_component)
] @tag.delimiter

; Expressions are similar to string interpolation, and are highloghted as such
(expression) @punctuation.special

; Expressions should be highlighted as Elixir, fallback to special strings
(expression_value) @string.special

; Surface tags are highlighted as HTML
(tag_name) @tag

; Surface components are highlighted as types (Elixir modules)
(component_name) @type

; Surface directives are highlighted as keywords
(directive_name) @keyword

; Surface operators
["="] @operator
