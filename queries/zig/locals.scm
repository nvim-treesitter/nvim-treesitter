
(function_declaration
  name: (identifier) @definition.function
)

((type_identifier) @reference
                   (set! reference.kind "type"))

(assignment_statement
  name: (identifier) @definition.var
)

(identifier) @reference

; Scopes
[
  (block)
  (comptime_block)
  (defer_block)
  (suspend_block)
  (resume_block)
  (if_expression)
  (while_expression)
  (for_expression)
  (test_expression)
  (anonymous_array_expr)
] @scope
