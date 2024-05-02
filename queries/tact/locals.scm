; Scopes       @local.scope
; -------------------------
[
  (static_function)
  (init_function)
  (bounced_function)
  (receive_function)
  (external_function)
  (function)
  (block_statement)
] @local.scope

; Definitions  @local.definition
; ------------------------------
; variables
(let_statement
  name: (identifier) @local.definition.var)

; constants
(constant
  name: (identifier) @local.definition.constant)

; functions
(static_function
  name: (identifier) @local.definition.function
  (#set! definition.var.scope parent))

; methods (functions off of contracts and traits)
(init_function
  "init" @local.definition.method
  (#set! definition.var.scope parent))

(bounced_function
  "bounced" @local.definition.method
  (#set! definition.var.scope parent))

(receive_function
  "receive" @local.definition.method
  (#set! definition.var.scope parent))

(external_function
  "external" @local.definition.method
  (#set! definition.var.scope parent))

(function
  name: (identifier) @local.definition.method
  (#set! definition.var.scope parent))

; parameters
(parameter
  name: (identifier) @local.definition.parameter)

; user-defined types (structs and messages)
(type_identifier) @local.definition.type

; fields (and properties)
(field
  name: (identifier) @local.definition.field)

; imports
(import_statement
  (string) @local.definition.import)

; References   @local.reference
; -----------------------------
(self) @local.reference

(value_expression
  (identifier) @local.reference)

(lvalue
  (identifier) @local.reference)
