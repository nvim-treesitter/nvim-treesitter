;; Keywords

"return" @keyword.return

[
  (local_token)
  (break_statement)
  "in"
] @keyword

(do_statement
[
  (do_token)
  (end_token)
] @keyword)

(while_statement
[
  (while_token)
  (do_token)
  (end_token)
] @repeat)

(repeat_statement
[
  (repeat_token)
  (until_token)
] @repeat)

(if_statement
[
  (if_token)
  (then_token)
  (end_token)
] @conditional)

(else_if_statement
[
  (else_if_token)
  (then_token)
] @conditional)

(else_statement
[
  (else_token)
] @conditional)

(numeric_for_statement
[
  "for"
  "do"
  (end_token)
] @repeat)

(generic_for_statement
[
  "for"
  "do"
  (end_token)
] @repeat)

(local_function_declaration
[
  (function_token)
  (end_token)
] @keyword.function)

(function_declaration
[
  (function_token)
  (end_token)
] @keyword.function)

;; Operators

[
  "and"
  "not"
  "or"
] @keyword.operator

[
  "+"
  "-"
  "*"
  "/"
  "%"
  "^"
  "#"
  "=="
  "~="
  "<="
  ">="
  "<"
  ">"
  "="
  ".."
] @operator

;; Punctuations

[
  ";"
  ":"
  ","
  "."
] @punctuation.delimiter

;; Brackets

[
  (left_paren)
  (right_paren)
  "["
  "]"
  "{"
  "}"
] @punctuation.bracket

;; Variables

(identifier) @variable

((identifier) @variable.builtin
 (#eq? @variable.builtin "self"))

;; Constants

((identifier) @constant
 (#lua-match? @constant "^[A-Z][A-Z_0-9]*$"))

(ellipse) @constant

(nil) @constant.builtin

(boolean) @boolean

;; Tables

(field name: (identifier) @field)

(table_constructor
[
  "{"
  "}"
] @constructor)

;; Functions

(parameter) @parameter

(function_call . (identifier) @function.call)
(function_declaration name: (function_name) @function)

(function_call
  (identifier) @function.builtin
  (#any-of? @function.builtin
    ;; built-in functions in Lua 5.1
    "assert" "collectgarbage" "dofile" "error" "getfenv" "getmetatable" "ipairs"
    "load" "loadfile" "loadstring" "module" "next" "pairs" "pcall" "print"
    "rawequal" "rawget" "rawset" "require" "select" "setfenv" "setmetatable"
    "tonumber" "tostring" "type" "unpack" "xpcall"))

;; Type syntax

(type_declaration
  (type_token) @keyword
  name: (identifier) @type
)

(type_table (type_table_field) @property)

(type_union [ "|" ] @operator)
(type_intersection [ "&" ] @operator)
(type_intersection (identifier) @type.builtin)
(type_array (identifier) @type.builtin)
(type_union (identifier) @type.builtin)
(type_generic (identifier) @type.builtin)

;; Others

(comment) @comment


(number) @number

(string) @string

;; Error
(ERROR) @error
