; Scopes
[
  (script)
  (class_declaration)
  (enum_declaration)
  (function_declaration)
  (attribute_declaration)
  (array)
  (block)
  (table)
  (anonymous_function)
  (parenthesized_expression)
  (if_statement)
  (else_statement)
  (while_statement)
  (do_while_statement)
  (switch_statement)
  (for_statement)
  (foreach_statement)
  (try_statement)
  (catch_statement)
] @local.scope

; References
[
  (identifier)
  (global_variable)
] @local.reference

; Definitions
(const_declaration
  .
  (identifier) @local.definition.constant)

(enum_declaration
  .
  (identifier) @local.definition.enum)

(member_declaration
  (identifier) @local.definition.field
  .
  "=")

(table_slot
  .
  (identifier) @local.definition.field
  .
  [
    "="
    ":"
  ])

((function_declaration
  .
  (identifier) @local.definition.function)
  (#not-has-ancestor? @local.definition.function member_declaration))

(member_declaration
  (function_declaration
    .
    (identifier) @local.definition.method))

(class_declaration
  .
  (identifier) @local.definition.type)

(var_statement
  "var"
  .
  (identifier) @local.definition.variable)

(local_declaration
  (identifier) @local.definition.variable
  .
  "=")
