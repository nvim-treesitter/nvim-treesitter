;;; Highlighting for lua

;;; Builtins
;; Keywords

(if_statement
[
  "if" 
  "then"
  (_end_keyword)
] @conditional)

[
  "else"
  "elseif"
] @conditional

(for_statement
[
  "for"
  "do"
  (_end_keyword)
] @repeat)

(for_in_statement
[
  "for"
  "do"
  (_end_keyword)
] @repeat)

(while_statement
[
  "while"
  "do"
  (_end_keyword)
] @repeat)

(repeat_statement
[
  "repeat"
  "until"
  (_end_keyword)
] @repeat)

[
 "in"
 "return"
 "goto"
 (_local_keyword)
 (break_statement)
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
[ "," "." ":"] @punctuation.delimiter

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

; (_function_keyword) @keyword.function

;; Functions
(function [(_function_keyword) (_end_keyword)] @keyword.function)
(function [(function_name) (identifier)] @function)

(local_function [(_function_keyword) (_end_keyword)] @keyword.function)
(local_function [(function_name) (identifier)] @function)

(function_definition [(_function_keyword) (_end_keyword)] @keyword.function)

(property_identifier) @property
(method) @method

(function_call (identifier) @function . (arguments))
(function_call (field_expression (property_identifier) @function) . (arguments))

;; Nodes
(table ["{" "}"] @constructor)
(comment) @comment
(string) @string
(number) @number
(label_statement) @label

;; Error
(ERROR) @error
