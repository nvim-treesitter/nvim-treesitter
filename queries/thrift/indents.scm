(definition) @indent

; (function (function_identifier) @aligned_indent)

((function_parameters (function_parameter)) @aligned_indent
  (#set! "delimiter" "()"))

((exception_parameters (exception_parameter)) @aligned_indent
  (#set! "delimiter" "()"))

"}" @indent_end

[ "{" "}" ] @branch

[ "(" ")" ] @branch

[
 (ERROR)
 (comment)
] @auto
