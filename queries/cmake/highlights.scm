[
 (quoted_argument)
 (bracket_argument)
] @string

(variable_ref) @none
(variable) @variable

[
 (bracket_comment)
 (line_comment)
] @comment

(normal_command (identifier) @function)

["ENV" "CACHE"] @symbol
["$" "{" "}" "<" ">"] @punctuation.special
["(" ")"] @punctuation.bracket

[
 (function)
 (endfunction)
 (macro)
 (endmacro)
] @keyword.function

[
 (if)
 (elseif)
 (else)
 (endif)
] @conditional

[
 (foreach)
 (endforeach)
 (while)
 (endwhile)
] @repeat

(function_command
  (function)
  . (argument) @function
  (argument)* @parameter
)

(macro_command
  (macro)
  . (argument) @function.macro
  (argument)* @parameter
)

(normal_command
 (identifier) @function.builtin
 . (argument) @variable
 (#match? @function.builtin "\\c^(set)$"))

(normal_command
 (identifier) @function.builtin
 . (argument)
 . (argument)
 (argument) @constant
 (#any-of? @constant "PARENT_SCOPE" "CACHE" "FORCE")
 (#match? @function.builtin "\\c^(set)$")
)

