; Scopes
[
  (source_file)
  (field)
  (for_clause)
] @local.scope

; References
(identifier) @local.reference

; Definitions
(import_spec
  path: (string) @local.definition.import)

(field
  (label
    (identifier) @local.definition.field))

(package_identifier) @local.definition.namespace

(for_clause
  (identifier) @local.definition.variable
  (expression))

(for_clause
  (identifier)
  (identifier) @local.definition.variable
  (expression))

(let_clause
  (identifier) @local.definition.variable)
