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
(struct_definition
  name: (identifier) @local.definition.type)

(abstract_definition
  name: (identifier) @local.definition.type)

(abstract_definition
  name: (identifier) @local.definition.type)

(type_parameter_list
  (identifier) @local.definition.type)

; Module imports
(import_statement
  (identifier) @local.definition.import)

; Function/macro definitions
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

(identifier) @local.reference

[
  (for_statement)
  (while_statement)
  (try_statement)
  (catch_clause)
  (finally_clause)
  (let_statement)
  (quote_statement)
  (do_clause)
] @local.scope
