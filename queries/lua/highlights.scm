;;; Highlighting for lua

;;; Builtins
;; Keywords
"local" @keyword
"if" @conditional
"then" @conditional
"else" @conditional
"elseif" @conditional
"end" @keyword
"return" @keyword
"do" @repeat
"while" @repeat
"repeat" @repeat
"for" @repeat
(break_statement) @keyword
"goto" @keyword

;; Operators
"~=" @operator
"==" @operator
"<=" @operator
">=" @operator
"not" @operator
"and" @operator
"or" @operator
"<" @operator
">" @operator

"+" @operator
"-" @operator
"%" @operator
"/" @operator
"//" @operator
"*" @operator
"^" @operator
"&" @operator
"~" @operator
"|" @operator
">>" @operator
"<<" @operator
".." @operator
"#" @operator

;; Constants
(false) @boolean
(true) @boolean
(nil) @constant.builtin
(spread) @constant ;; "..."

;; Nodes
(function "function" @function "end" @function)
(function_definition "function" @function "end" @function)
(local_function "function" @function "end" @function)
(table "{" @constructor "}" @constructor)
(comment) @comment
(string) @string
(number) @number
(label_statement) @label

;; Error
(ERROR) @Error
