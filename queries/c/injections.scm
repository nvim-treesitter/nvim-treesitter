(preproc_arg) @c

(comment) @comment

(call_expression
  function: (identifier) @_function
  (#any-of? @_function "printf" "scanf" "printf_s" "scanf_s")
  arguments: (argument_list . (string_literal) @printf))

(call_expression
  function: (identifier) @_function
  (#any-of? @_function "fprintf" "fscanf" "fprintf_s" "fscanf_s"
                       "sprintf" "sscanf" "sscanf_s")
  arguments: (argument_list (_) . (string_literal) @printf))

(call_expression
  function: (identifier) @_function
  (#any-of? @_function "snprintf" "sprintf_s" "snprintf_s")
  arguments: (argument_list (_) . (_) . (string_literal) @printf))
