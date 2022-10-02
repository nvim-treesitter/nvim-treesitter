; inherits: c

(preproc_arg) @glsl

(call_expression
  function: (identifier) @_function
  (#eq? @_function "debugPrintfEXT")
  arguments: (argument_list . (string_literal) @printf))
