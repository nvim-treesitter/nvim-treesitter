[
  (symbol)
  (prompt)
] @local.reference

[
  (config)
  (menuconfig)
  (choice)
  (comment_entry)
  (menu)
  (if)
] @local.scope

(type_definition
  (prompt) @local.definition.var)

(type_definition
  (input_prompt
    (prompt) @local.definition.var))

(type_definition_default
  (expression
    (prompt) @local.definition.var))
