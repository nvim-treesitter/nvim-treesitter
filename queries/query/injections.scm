((predicate
  name: (identifier) @_name
  parameters: (parameters (string) @regex))
 (#match? @_name "^#(not-)?(match|vim-match)$"))

((predicate
  name: (identifier) @_name
  parameters: (parameters (string) @luap))
 (#match? @_name "^#(not-)?lua-match$"))

(comment) @comment
