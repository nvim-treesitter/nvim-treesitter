(source_file) @local.scope

; The content of a function is a scope, not the whole function block.
; Else, the function is defined inside itself
(function
  .
  (function_name)
  .
  (_) @local.scope)

(function
  .
  (function_name) @local.definition.function)

(assignment
  (variable_name) @local.definition.var)

(variable_name) @local.reference

((handler
  (function_name) @local.reference)
  (#set! reference.kind "call"))
