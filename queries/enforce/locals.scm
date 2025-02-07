; Scopes
(compilation_unit) @local.scope

(decl_class
  body: (_) @local.scope)

(decl_enum
  body: (_) @local.scope)

(decl_method) @local.scope

(block) @local.scope

(if) @local.scope

(for) @local.scope

(foreach) @local.scope

(while) @local.scope

; Definitions
(decl_class
  typename: (identifier) @local.definition.type)

(decl_enum
  typename: (identifier) @local.definition.enum)

(decl_method
  name: (identifier) @local.definition.method)

(decl_variable
  (_)*
  (identifier) @local.definition.var)

; References
(identifier) @local.reference

(type_identifier
  (identifier) @local.reference)
