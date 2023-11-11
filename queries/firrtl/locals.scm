; Scopes
[
  (source_file)
  (circuit)
  (module)
  (else)
  (when)
] @local.scope

; References
(identifier) @local.reference

; Definitions
(port
  (identifier) @local.definition.field)

(wire
  (identifier) @local.definition.field)

(cmem
  (identifier) @local.definition.field)

(smem
  (identifier) @local.definition.field)

(memory
  (identifier) @local.definition.field)

(register
  (identifier) @local.definition.field)

(circuit
  (identifier) @local.definition.namespace)

(module
  (identifier) @local.definition.namespace)

(parameter
  (identifier) @local.definition.parameter)

(rdwr
  (identifier) @local.definition.var)

(node
  (identifier) @local.definition.var)
