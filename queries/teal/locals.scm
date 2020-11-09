
(var_declaration
   (var (identifier)) @definition.var)

(var_assignment
   (var (identifier)) @definition.associated @definition.var)

(arg_name) @definition.parameter

(functiondef) @scope
((function_statement
  (function_name) @definition.function) @scope
  (#set! definition.function.scope "parent"))

(program) @scope
(if_statement) @scope
(for_statement (for_body) @scope)
(repeat_statement) @scope
(while_statement (while_body) @scope)
(do_statement) @scope

(identifier) @reference
