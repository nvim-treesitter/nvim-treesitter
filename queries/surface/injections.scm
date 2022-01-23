; Surface expressions and components are Elixir code
[
  (expression_value)
  (component_name)
] @elixir

; Surface Markdown component
((start_markdown) . ((text) @markdown) . (end_markdown))

; Surface comments are nvim-treesitter comments
(comment) @comment
