; HEEx directives can span multiple interpolated lines of Elixir
(directive [
  (expression_value) 
  (partial_expression_value)
] @injection.content
  (#set! injection.language "elixir")
  (#set! injection.combined))  

; HEEx Elixir expressions are always within a tag or component
(expression 
  (expression_value) @injection.content 
  (#set! injection.language "elixir"))

; HEEx comments
((comment) @injection.content
 (#set! injection.language "comment"))
