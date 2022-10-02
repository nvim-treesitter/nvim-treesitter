(comment) @comment

(call_expression
  function: (selector_expression
              field: (field_identifier) @_method)
  (#any-of? @_method "Printf" "Sprintf" "Fatalf")
  arguments: (argument_list . (interpreted_string_literal) @printf))

(call_expression
  function: (selector_expression
              field: (field_identifier) @_method)
  (#eq? @_method "Fprintf")
  arguments: (argument_list (_) . (interpreted_string_literal) @printf))
