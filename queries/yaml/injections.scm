(comment) @comment

(block_mapping_pair
  key: (flow_node) @_run (#eq? @_run "run")
  value: (flow_node
           (plain_scalar) @bash))

(block_mapping_pair
  key: (flow_node) @_run (#eq? @_run "run")
  value: (block_node) @bash (#offset! @bash 0 0 0 0))
