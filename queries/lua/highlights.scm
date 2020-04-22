;;; Highlighting for lua

;;; Builtins
;; Keywords
"local" @keyword
"if" @keyword
"then" @keyword
"else" @keyword
"elseif" @keyword
"end" @keyword
"return" @keyword
"do" @keyword
"while" @keyword
"repeat" @keyword
"for" @keyword
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
(false) @constant
(true) @constant
(nil) @constant
(spread) @constant ;; "..."

;; Nodes
(function "function" @function "end" @function)
(table "{" @operator "}" @operator)
(comment) @comment
(string) @string
(number) @number
(label_statement) @label

;; Error
(ERROR) @Error
