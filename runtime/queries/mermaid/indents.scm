([
  (diagram_sequence)
  (diagram_class)
  (diagram_state)
  (diagram_gantt)
  (diagram_pie)
  (diagram_er)
  (diagram_flow)
  (flow_stmt_subgraph)
] @indent.begin
  (#set! indent.immediate 1))

"end" @indent.branch

[
  (ERROR)
  (comment)
] @indent.auto
