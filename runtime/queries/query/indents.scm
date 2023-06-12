[
  (list)
  (named_node)
  (grouping)
  (predicate)
  "["
] @indent.begin

; ERROR node indents
(ERROR
  "(") @indent.begin

"]" @indent.branch @indent.end

[
  ")"
  "?"
  "*"
  "+"
] @indent.end

; Captures always mark the end of a node
; Because of that, mark it as indent.end
(capture
  name: (identifier) @indent.end)
