; Scopes

[
  (template_body)
  (lambda_expression)
  (function_declaration)
] @scope

; References

(identifier) @reference

; Definitions

(function_declaration
  name: (identifier) @definition.function)

(function_definition
  name: (identifier) @definition.function)

(parameter
  name: (identifier) @definition.parameter)

(binding
  name: (identifier) @definition.var)

(val_definition
  pattern: (identifier) @definition.var)

(var_definition
  pattern: (identifier) @definition.var)

(val_declaration
  name: (identifier) @definition.var)

(var_declaration
  name: (identifier) @definition.var)

