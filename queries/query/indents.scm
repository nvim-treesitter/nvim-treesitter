[
  (list)
  (named_node)
  (grouping)
  "["
] @indent.begin

"]" @indent.branch

")" @indent.end

((list
  (capture) @indent.dedent) @_list
  (#not-has-parent? @_list grouping))

(program
  (named_node
    (capture) @indent.dedent .))
