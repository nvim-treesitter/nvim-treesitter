; Scope
[
 (program)
 (function_definition)
 (lambda_definition)
 (let_definition)
] @scope

; Functions
(function_definition
  name: (identifier) @definition.function)
(lambda_definition
  name: (identifier) @definition.function)

; Variable Definitions
(local_definition 
  (assignment
    (identifier) @definition.var))
(var_definition 
  (assignment
    (identifier) @definition.var))
(global_definition
  (assignment
    (identifier) @definition.var))
(assignment
  (identifier) @definition.var)
(multi_value_assignment
  (value_list
    (identifier) @definition.var))
(parameters
    ((identifier) @definition.var))
; iterators/loops
((each 
  (each_clause
    (identifier) @definition.var)) @scope)
((for 
  (for_clause
    (identifier) @definition.var)) @scope)

; references
(set 
  (assignment (identifier) @reference))
(function_call 
  name: (identifier) @reference)
(identifier) @reference
