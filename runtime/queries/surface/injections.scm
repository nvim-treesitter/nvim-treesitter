; Surface expressions and components are Elixir code
([
  (expression_value)
  (component_name)
] @injection.content
  (#set! injection.language "elixir"))

; Surface comments are nvim-treesitter comments
((comment) @injection.content
  (#set! injection.language "comment"))
