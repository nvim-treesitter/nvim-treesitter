; Scopes
[
  (program)
  (macro)
  (memory_execution)
  (subroutine)
] @local.scope

; References
(identifier) @local.reference

; Definitions
(label
  "@"
  .
  (identifier) @local.definition.function)

(macro
  "%"
  .
  (identifier) @local.definition.macro)
