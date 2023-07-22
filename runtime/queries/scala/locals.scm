; Scopes

[
  (template_body)
  (lambda_expression)
  (function_definition)
  (block)
] @local.scope

; References

(identifier) @local.reference

; Definitions

(function_declaration
  name: (identifier) @local.definition.function)

(function_definition
  name: (identifier) @local.definition.function)

(parameter
  name: (identifier) @local.definition.parameter)

(class_parameter
  name: (identifier) @local.definition.parameter)

(binding
  name: (identifier) @local.definition.var)

(val_definition
  pattern: (identifier) @local.definition.var)

(var_definition
  pattern: (identifier) @local.definition.var)

(val_declaration
  name: (identifier) @local.definition.var)

(var_declaration
  name: (identifier) @local.definition.var)

