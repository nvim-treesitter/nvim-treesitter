; Scopes

[
  (template_body)
  (lambda_expression)
  (function_definition)
  (block)
  (for_expression)
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

(class_parameter
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

(for_expression
  enumerators: (enumerators
    (enumerator
      (tuple_pattern
        (identifier) @definition.var))))
