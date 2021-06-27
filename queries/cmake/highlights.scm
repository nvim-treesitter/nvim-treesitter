[
 (quoted_argument)
 (bracket_argument)
] @string

(variable_ref) @variable

[
 (bracket_comment)
 (line_comment)
] @comment

[
 "$ENV"
 "$CACHE"
] @variable.builtin

(normal_command (identifier) @function)

[
 (function)
 (endfunction)
 (macro)
 (endmacro)
] @function

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

