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

;; Operators
"~=" @operator
"==" @operator
"not" @operator
"and" @operator
"or" @operator

;; Constants
(false) @constant
(true) @constant
(nil) @constant

;; Nodes
(function "function" @function "end" @function)
(comment) @comment
(string) @string
(number) @constant

;; Error
(ERROR) @Error
