;; Definitions

(module_def (module_declaration (module_fqn) @definition.namespace) (#set! "definition.namespace.scope" "global"))

((enum_declaration (enum) . (identifier) @definition.type))
(enum_declaration ((enum_member . (identifier) @definition.enum)))

((class_declaration (class) . (identifier) @definition.type))
((struct_declaration (struct) . (identifier) @definition.type))
(union_declaration (union) . (identifier) @definition.type)
(alias_declaration (alias_initializer . (identifier) @definition.type))

((constructor (this) @definition.method))
((destructor (this) @definition.method))
((postblit (this) @definition.method))

((manifest_declarator . (identifier) @definition.constant))
(anonymous_enum_declaration ((enum_member . (identifier) @definition.constant)))

((aggregate_body (variable_declaration (type) @definition.associated (declarator (identifier) @definition.field))))
((aggregate_body (function_declaration (identifier) @definition.method)))

(variable_declaration (type) @definition.associated (declarator (identifier) @definition.var))
(function_declaration (identifier) @definition.function)

;; Scope

[
  (source_file)
  (block_statement)
  (aggregate_body)
] @scope

;; References

(identifier) @reference
