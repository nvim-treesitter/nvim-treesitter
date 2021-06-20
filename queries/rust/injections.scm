(macro_invocation
  (token_tree) @rust)

(macro_definition
  (macro_rule
    left: (token_tree_pattern) @rust
    right: (token_tree) @rust))

[
  (line_comment)
  (block_comment)
] @comment

(
  (macro_invocation
    macro: ((identifier) @_html_def)
    (token_tree) @html)

    (#eq? @_html_def "html")
)

