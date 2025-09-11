; Functions definitions
(function_declarator
  declarator: (identifier) @local.definition.function)

(preproc_function_def
  name: (identifier) @local.definition.macro) @local.scope

(preproc_def
  name: (identifier) @local.definition.macro)

((identifier) @local.definition.parameter
  (#has-ancestor? @local.definition.parameter param_decl))

(init_declarator
  (declarator
    (identifier)) @local.definition.var)

(array_declarator
  (identifier) @local.definition.var)

; Struct
(member_decl
  (declarator
    (identifier)) @local.definition.field)

(structdef
  name: (identifier) @local.definition.type)

; References
((field_expression
  field: (identifier) @local.reference)
  (#set! reference.kind "field"))

((call_expression
  function: (identifier) @local.reference)
  (#set! reference.kind "call"))

((basetype
  (identifier) @local.reference)
  (#set! reference.kind "type"))

; SNL specific
(state_set
  name: (identifier) @local.definition)

(state
  name: (identifier) @local.definition)

(state_statement
  name: (identifier) @local.reference)

(transition
  name: (identifier) @local.reference)

(identifier) @local.reference

[
  (for_statement)
  (if_statement)
  (while_statement)
  (source_file)
  (block)
  (state_set)
  (state_block)
] @local.scope
