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
  "then"
] @conditional

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

(do_statement
[
  "do"
  "end"
] @keyword)

[
 "in"
 "local"
 "return"
 (break_statement)
 "goto"
] @keyword

;; Operators

[
 "not"
 "and"
 "or"
] @keyword.operator

[
"="
"~="
"=="
"<="
">="
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

;; Variables
(identifier) @variable

;; Constants
[
(false)
(true)
] @boolean
(nil) @constant.builtin
(spread) @constant ;; "..."

;; Functions
(function [(function_name) (identifier)] @function)
(function ["function" "end"] @keyword.function)

(local_function (identifier) @function)
(local_function ["function" "end"] @keyword.function)

(function_definition ["function" "end"] @keyword.function)

(property_identifier) @property
(method) @method

(function_call (identifier) @function . (arguments))
(function_call (field_expression (property_identifier) @function) . (arguments))

;; Parameters
(parameters
  (identifier) @parameter)

;; Nodes
(table ["{" "}"] @constructor)
(comment) @comment
(string) @string
(number) @number
(label_statement) @label
(shebang) @comment

;; Error
(ERROR) @error
