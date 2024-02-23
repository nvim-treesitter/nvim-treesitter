; TODO: Add tests
; TODO: Improve queries
(program) @local.scope

((list
  .
  (symbol) @_call) @local.scope
  (#any-of? @_call
    "let" "fn" "lambda" "λ" "while" "each" "for" "if" "when" "do" "collect" "icollect" "accumulate"
    "case" "match"))

(symbol) @local.reference

(list
  .
  (symbol) @_fn
  (#any-of? @_fn "fn" "lambda" "λ")
  .
  [
    (symbol) @local.definition.function
    (multi_symbol
      member: (symbol_fragment) @local.definition.function .)
  ]
  (#set! definition.function.scope "parent")
  .
  (sequence
    (symbol)* @local.definition.parameter
    (#not-contains? @local.definition.parameter "&")))
