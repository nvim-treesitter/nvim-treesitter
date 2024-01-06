[
  (program)
  (fn)
  (lambda)
  (let)
  (each)
  (for)
  (match)
] @local.scope

((list
  .
  (symbol) @_special) @local.scope
  (#any-of? @_special "while" "if" "when" "do" "collect" "icollect" "accumulate"))

(fn
  name: (symbol) @local.definition.function
  (#set! definition.function.scope "parent"))

(lambda
  name: (symbol) @local.definition.function
  (#set! definition.function.scope "parent"))

; TODO: use @local.definition.parameter for parameters
(binding
  (symbol) @local.definition.var)

(for_clause
  .
  (symbol) @local.definition.var)

(symbol) @local.reference
