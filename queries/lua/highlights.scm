;;; Highlighting for lua

;;; Builtins
;; Keywords

[
"if"
"then"
"else"
"elseif"
 ] @conditional

[
"do"
"while"
"repeat"
"for"
"in"
] @repeat

[
"local"
"end"
"return"
(break_statement)
"goto"
] @keyword

;; Operators
[
"~="
"=="
"<="
">="
"not"
"and"
"or"
"<"
">"
"+"
"-"
"%"
"/"
"//"
"*"
"^"
"&"
"~"
"|"
">>"
"<<"
".."
"#"
 ] @operator


;; Constants
[
(false)
(true)
] @boolean
(nil) @constant.builtin
(spread) @constant ;; "..."

;; Nodes
(_ "function" @function "end" @function) ;; Any node that has both funtion and end in it

(table ["{" "}"] @constructor)
(comment) @comment
(string) @string
(number) @number
(label_statement) @label

;; Error
(ERROR) @Error
