; HEEx directives can span multiple interpolated lines
(directive [
  (expression_value) 
  (partial_expression_value)
] @elixir @combined)  

; HEEx expressions are always within a tag or component
(expression (expression_value) @elixir)

(comment) @comment
