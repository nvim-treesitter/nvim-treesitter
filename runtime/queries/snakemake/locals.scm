; inherits: python

(rule_definition
  name: (identifier) @local.definition.type) @local.scope

(rule_inheritance
  alias: (as_pattern_target) @local.definition.type) @local.scope

(checkpoint_definition
  name: (identifier) @local.definition.type) @local.scope

(module_definition
  name: (identifier) @local.definition.type) @local.scope

; use rule A from X
(rule_import
  (rule_import_list
    (identifier) @local.definition.import)
  .
  module_name: (identifier) .) @local.scope

; use rule A from X as A_fromX
; use rule A from X as *_fromX
; use rule * from X as *_fromX
(rule_import
  alias: (as_pattern_target) @local.definition.import .) @local.scope

; use rule A from X with:
(rule_import
  (rule_import_list
    (identifier) @local.definition.type)
  .
  module_name: (identifier)
  .
  "with") @local.scope

; use rule A from X as Y with:
(rule_import
  alias: (as_pattern_target) @local.definition.type
  "with") @local.scope
