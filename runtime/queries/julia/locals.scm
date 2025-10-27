; References
(identifier) @local.reference

; Definitions
(assignment
  .
  (identifier) @local.definition)

(assignment
  .
  (tuple_expression
    (identifier) @local.definition))

(assignment
  .
  (open_tuple
    (identifier) @local.definition))

(for_binding
  .
  (identifier) @local.definition)

(for_binding
  .
  (tuple_expression
    (identifier) @local.definition))

(import_statement
  (identifier) @local.definition)

(using_statement
  (identifier) @local.definition)

(selected_import
  (identifier) @local.definition)

(module_definition
  .
  (identifier) @local.definition)

(type_head
  (identifier) @local.definition)

(type_head
  (binary_expression
    .
    (identifier) @local.definition))

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

; Scopes
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
