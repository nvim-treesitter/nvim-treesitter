; Scopes       @local.scope
; -------------------------
[
  (asm_function)
  (global_function)
  (init_function)
  (bounced_function)
  (receive_function)
  (external_function)
  (storage_function)
  (block_statement)
] @local.scope

; Definitions  @local.definition
; ------------------------------
; variables
(storage_variable
  name: (identifier) @local.definition.var)

(let_statement
  name: (identifier) @local.definition.var)

; constants
(global_constant
  name: (identifier) @local.definition.constant)

(storage_constant
  name: (identifier) @local.definition.constant)

; functions
(asm_function
  name: (identifier) @local.definition.function
  (#set! definition.var.scope parent))

(global_function
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

(storage_function
  name: (identifier) @local.definition.method
  (#set! definition.var.scope parent))

; parameters
(parameter
  name: (identifier) @local.definition.parameter)

; user-defined types (structs and messages)
(type_identifier) @local.definition.type

; fields (of messages and structs)
(field
  name: (identifier) @local.definition.field)

; imports
(import
  name: (string) @local.definition.import)

; References   @local.reference
; -----------------------------
(self) @local.reference

(value_expression
  (identifier) @local.reference)

(field_access_expression
  name: (identifier) @local.reference)
