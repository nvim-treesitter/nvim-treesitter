(group_graph_pattern
  (triples_block) @local.scope)

((sub_select
  (select_clause
    (var) @local.definition.var))
  (#set! "definition.var.scope" "parent"))

((select_query
  (select_clause
    (var) @local.definition.var))
  (#set! "definition.var.scope" "parent"))

(var) @local.reference
