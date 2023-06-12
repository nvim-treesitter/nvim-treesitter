; Scopes
[
  (source_file)
  (block_statement)
  (aggregate_body)
] @local.scope

; References
(identifier) @local.reference

; Definitions
(module_def
  (module_declaration
    (module_fqn) @local.definition.namespace)
  (#set! definition.namespace.scope "global"))

(enum_declaration
  (enum_member
    .
    (identifier) @local.definition.enum))

(class_declaration
  (class)
  .
  (identifier) @local.definition.type)

(struct_declaration
  (struct)
  .
  (identifier) @local.definition.type)

(union_declaration
  (union)
  .
  (identifier) @local.definition.type)

(enum_declaration
  (enum)
  .
  (identifier) @local.definition.type)

(alias_declaration
  (alias_initializer
    .
    (identifier) @local.definition.type))

(constructor
  (this) @local.definition.method)

(destructor
  (this) @local.definition.method)

(postblit
  (this) @local.definition.method)

(aggregate_body
  (function_declaration
    (identifier) @local.definition.method))

(manifest_declarator
  .
  (identifier) @local.definition.constant)

(anonymous_enum_declaration
  (enum_member
    .
    (identifier) @local.definition.constant))

(variable_declaration
  (declarator
    (identifier) @local.definition.var))

(aggregate_body
  (variable_declaration
    (declarator
      (identifier) @local.definition.field)))

(function_declaration
  (identifier) @local.definition.function)
