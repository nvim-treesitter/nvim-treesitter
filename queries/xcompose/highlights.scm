(keysym) @constant

((keysym) @constant.builtin
 (#eq? @constant.builtin "Multi_key"))

(text) @string

"include" @include

[ (octal) (hex) ] @number

[ (modifier) "None" ] @type.qualifier

[ "%L" "%H" "%S" ] @string.special

[ "!" "~" ] @operator

[ ":" "<" ">" "\"" ] @punctuation.delimiter

(comment) @comment @spell
