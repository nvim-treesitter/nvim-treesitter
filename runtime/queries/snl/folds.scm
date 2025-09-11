[
  (for_statement)
  (if_statement)
  (while_statement)
  (funcdef)
  (structdef)
  (comment)
  (preproc_if)
  (preproc_elif)
  (preproc_else)
  (preproc_ifdef)
  (preproc_function_def)
  (init_expr)
  (entry)
  (state_set)
  (state)
  (exit)
] @fold

(initial_defn
  (preproc_include))+ @fold
