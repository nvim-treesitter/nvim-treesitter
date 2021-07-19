
(comment) @comment

; Module / submodule
["module" "submodule"] @keyword

; Keywords
(statement_keyword) @keyword
(extension_keyword) @string.escape

; Arguments
(built_in_type) @type.builtin
(integer) @number
(boolean) @boolean
(date) @number
(range) @string.escape
(unquoted_range) @string.escape
(yang_version) @string.escape
(identifier) @variable
(node_identifier) @variable
(glob) @string
(string) @string
(unquoted_string) @string
(keypath) @string.escape

; Punctuation
(plus_symbol) @punctuation.delimiter
["{" "}"] @punctuation.bracket
[";"] @punctuation.delimiter
