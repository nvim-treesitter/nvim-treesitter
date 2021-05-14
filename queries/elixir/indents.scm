[
  (arguments)
  (call)
  (do_block)
  (list)
  (map)
  (stab_expression)
] @indent

(stab_expression
 right: (_) @indent)

[
  "("
  ")"
  "{"
  "}"
  "["
  "]"
  (after_block)
  (catch_block)
  (else_block)
  (rescue_block)
  "do"
  "end"
] @branch

(comment) @ignore
