[
  (list)
  (named_node)
  (predicate)
  "["
] @indent.begin

((grouping) @indent.begin
  (#set! indent.immediate))

; ERROR node indents
(ERROR
  "(") @indent.begin

"]" @indent.branch @indent.end

")" @indent.end

; Captures always mark the end of a node
; Because of that, mark it as indent.end
(capture
  name: (identifier) @indent.end)
