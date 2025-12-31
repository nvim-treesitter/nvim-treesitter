[
  (if_statement)
  (for_statement)
  (while_statement)
  (case_statement)
  (function_definition)
  (compound_statement)
  (subshell)
  (command_substitution)
  (do_group)
  (case_item)
] @indent.begin

[
  "fi"
  "done"
  "esac"
  "}"
  ")"
  "then"
  "do"
  (elif_clause)
  (else_clause)
] @indent.branch

[
  "fi"
  "done"
  "esac"
  "}"
  ")"
] @indent.end
