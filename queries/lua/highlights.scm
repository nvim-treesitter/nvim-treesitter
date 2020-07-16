;;; Highlighting for lua

;;; Builtins
;; Keywords
(
  "if" @conditional
  "end" @conditional
)
[
  "else"
  "elseif"
  "then"
] @conditional


(
  [
  "do"
  "while"
  "repeat"
  "for"
  ] @repeat

  "end" @repeat
)

[
"in"
"local"
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
("function" @function "end" @function) ;; Any node that has both funtion and end in it

(table ["{" "}"] @constructor)
(comment) @comment
(string) @string
(number) @number
(label_statement) @label

;; Error
(ERROR) @Error
