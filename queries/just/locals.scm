; Source: https://github.com/IndianBoy42/tree-sitter-just/blob/main/queries/just/locals.scm
; Scope
(recipe) @local.scope

; Definitions
(alias
  left: (identifier) @local.definition.var)

(assignment
  left: (identifier) @local.definition.var)

(module
  name: (identifier) @local.definition.namespace)

(parameter
  name: (identifier) @local.definition.var)

(recipe_header
  name: (identifier) @local.definition.function)

; References
(alias
  right: (identifier) @local.reference)

(function_call
  name: (identifier) @local.reference)

(dependency
  name: (identifier) @local.reference)

(dependency_expression
  name: (identifier) @local.reference)

(value
  (identifier) @local.reference)
