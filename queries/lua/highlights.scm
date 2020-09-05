;;; Highlighting for lua

;;; Builtins
;; Keywords

(if_statement
[
  "if" 
  "then"
  "end"
] @conditional)

[
  "else"
  "elseif"
] @contional

(for_statement
[
  "for"
  "do"
  "end"
] @repeat)

(for_in_statement
[
  "for"
  "do"
  "end"
] @repeat)

(while_statement
[
  "while"
  "do"
  "end"
] @repeat)

(repeat_statement
[
  "repeat"
  "until"
] @repeat)

[
 "in"
 "local"
 "return"
 (break_statement)
 "goto"
] @keyword

;; Operators
[
"="
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

;; Punctuation
[ "," "." ] @punctuation.delimiter

;; Brackets
[
 "("
 ")"
 "["
 "]"
 "{"
 "}"
] @punctuation.bracket

;; Constants
[
(false)
(true)
] @boolean
(nil) @constant.builtin
(spread) @constant ;; "..."

;; Functions
("function" @keyword.function
 [(function_name) (identifier)] @function
 "end" @keyword.function)

;; Nodes
(table ["{" "}"] @constructor)
(comment) @comment
(string) @string
(number) @number
(label_statement) @label

;; Error
(ERROR) @error
