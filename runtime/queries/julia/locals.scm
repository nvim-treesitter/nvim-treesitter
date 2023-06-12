; References
(identifier) @local.reference

; Variables
(assignment
  (identifier) @local.definition.var)

(assignment
  (tuple_expression
    (identifier) @local.definition.var))

; let/const bindings
(let_binding
  (identifier) @local.definition.var)

(let_binding
  (tuple_expression
    (identifier) @local.definition.var))

; For bindings
(for_binding
  (identifier) @local.definition.var)

(for_binding
  (tuple_expression
    (identifier) @local.definition.var))

; Types
(module_definition
  (identifier) @local.definition.type)

(struct_definition
  (identifier) @local.definition.type)

(type_head
  (identifier) @local.definition.type)

(type_head
  (binary_expression
    .
    (identifier) @local.definition.type))

; Module imports
(import_statement
  (identifier) @local.definition.import)

(using_statement
  (identifier) @local.definition.import)

(selected_import
  (identifier) @local.definition.import)

; Scopes
(function_definition
  (signature
    (call_expression
      .
      (identifier) @local.definition.function))) @local.scope

(macro_definition
  (signature
    (call_expression
      .
      (identifier) @local.definition.function))) @local.scope

[
  (quote_statement)
  (let_statement)
  (for_statement)
  (while_statement)
  (try_statement)
  (catch_clause)
  (finally_clause)
  (do_clause)
] @local.scope
