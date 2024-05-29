; Scopes
(function
  body: (_) @local.scope)

; Definitions
(arg
  (variable) @local.definition.parameter)

(assign
  (identifier) @local.definition.var)

(for_args
  (variable) @local.definition.var)

(match_patterns
  (variable) @local.definition.var)

(import_item
  (identifier) @local.definition.import)

(entry_block
  (identifier) @local.definition.field)

(entry_inline
  (identifier) @local.definition.field)

; References
(identifier) @local.reference
