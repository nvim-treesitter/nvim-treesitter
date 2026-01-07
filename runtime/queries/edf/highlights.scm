; Highlighting queries for EDF (Ecolog Dotenv File Format)

; Comments
(comment) @comment
(comment_content) @comment
(inline_comment) @comment

; Export keyword
(export_keyword) @keyword

; Keys (variable names)
(key) @property

; String values
(single_quoted_string) @string
(single_quoted_content) @string
(double_quoted_string) @string
(double_quoted_content) @string
(unquoted_content) @string

; Escape sequences in double-quoted strings
(escape_sequence) @string.escape

; Variable expansion ${VAR} and ${VAR:-default}
(variable_expansion) @variable

; Simple variable $VAR
(simple_variable) @variable

; Command substitution $(command) and `command`
(command_substitution) @function.macro
(backtick_substitution) @function.macro

; Operators and punctuation
"=" @operator
"'" @punctuation.delimiter
"\"" @punctuation.delimiter
