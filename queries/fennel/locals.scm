[
 (program)
 (fn)
 (lambda)
 (let)
 (each)
 (for)
 (match)
] @scope

((symbol) @scope
 (#any-of? @scope
  "while" "if" "when" "do"))

(fn name: (symbol) @definition.function)
(lambda name: (symbol) @definition.function)

(parameters
 (symbol) @definition.var)

(for_clause . (symbol) @definition.var)

; FIXME: how to distinguish between symbols-as-bindings and
; symbols-as-expressions
; (each_clause (symbol) @definition.var)
; (let_clause ((symbol) @definition.var (_))*)

(global . (symbol) @definition.var)
(local . (symbol) @definition.var)
(var . (symbol) @definition.var)

(multi_value_binding (symbol) @definition.var)
(sequential_table_binding (symbol) @definition.var)
(table_binding ([(_) ":"] (symbol) @definition.var)*)

(symbol) @reference
