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

;; Functions
("function" @keyword.function
 [(function_name) (identifier)] @function
 "end" @keyword.function)

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
