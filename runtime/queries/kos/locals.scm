; Scopes
;-------
(compound_statement) @local.scope

(for_statement) @local.scope

(function_decl) @local.scope

(constructor_literal) @local.scope

(function_literal) @local.scope

(with_statement) @local.scope

(catch_clause) @local.scope

; Definitions
;------------
(variable_decl
  variable: (identifier) @local.definition.var)

(parameter
  parameter: (identifier) @local.definition.parameter)

(import
  module: (identifier) @local.definition.import)

(import
  symbol: (identifier) @local.definition.import)

(function_decl
  name: (identifier) @local.definition.function
  (#set! definition.var.scope parent))

(class_decl
  name: (identifier) @local.definition.type
  (#set! definition.var.scope parent))

; References
;------------
(identifier) @local.reference
