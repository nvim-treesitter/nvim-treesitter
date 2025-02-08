; Let Binding Definition
(let
  pattern: (identifier) @local.definition)

; List Pattern Definitions
(list_pattern
  (identifier) @local.definition)

(list_pattern
  assign: (identifier) @local.definition)

; Tuple Pattern Definition
(tuple_pattern
  (identifier) @local.definition)

; Record Pattern Definition
(record_pattern_argument
  pattern: (identifier) @local.definition)

; Function Parameter Definition
(function_parameter
  name: (identifier) @local.definition)

; References
(identifier) @local.reference

; Block Scope
(block) @local.scope

; Case Scope
(case_clause) @local.scope
