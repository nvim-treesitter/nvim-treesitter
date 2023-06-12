; Scopes
[
  (function_call)
  (code_block)
  (function_block)
  (control_structure)
] @local.scope

; Definitions
(argument
  name: (identifier) @local.definition.parameter
  (#set! "definition.var.scope" "local"))

(variable_definition
  name:
    (variable
      (local_var
        (identifier) @local.definition.var)))

(variable_definition
  name:
    (variable
      (environment_var
        (identifier) @local.definition.var))
  (#set! "definition.var.scope" "global"))

(function_definition
  name: (variable) @local.definition.var
  (#set! "definition.var.scope" "parent"))

(identifier) @local.reference
