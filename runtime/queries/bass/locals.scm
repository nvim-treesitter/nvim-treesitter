; Scopes
[
  (list)
  (scope)
  (cons)
] @local.scope

; References
(symbol) @local.reference

; Definitions
((list
  .
  (symbol) @_fnkw
  .
  (symbol) @local.definition.function
  (symbol)? @local.definition.parameter)
  (#any-of? @_fnkw "def" "defop" "defn" "fn"))

((cons
  .
  (symbol) @_fnkw
  .
  (symbol) @local.definition.function
  (symbol)? @local.definition.parameter)
  (#any-of? @_fnkw "def" "defop" "defn" "fn"))
