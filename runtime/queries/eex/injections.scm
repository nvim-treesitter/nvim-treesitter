; EEx expressions are Elixir
((expression) @injection.content 
 (#set! injection.language "elixir"))

; EEx expressions can span multiple interpolated lines
((partial_expression) @injection.content
 (#set! injection.language "elixir")
 (#set! injection.combined))
