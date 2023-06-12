[
  (list)
  (dictionaries)
  (normal_command)
  (if_condition)
  (foreach_command)
  (ternaryoperator)
  (ERROR
    "?") ; support partial ternary
] @indent.begin

[
  ")"
  "]"
  "}"
  (elseif_command)
  (else_command)
  "endif"
  "endforeach"
] @indent.branch @indent.end

(expression_statement
  object: (_)) @indent.begin

(comment) @indent.auto
