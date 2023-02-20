; Tags

(list
  (symbol) @tag)

; Includes

((symbol) @include
  (#match? @include "include"))

; Keywords

((symbol) @keyword
  (#any-of? @keyword "defwindow" "defwidget" "defvar" "defpoll" "deflisten" "for" "geometry" "children" "struts"))

; Functions

(function_call
  name: (ident) @function.call)

; Variables

(array
  (symbol) @variable)

(binary_expression
	(simplexpr
    (ident) @variable))

(unary_expression
	(simplexpr
    (ident) @variable))

(ternary_expression
	(simplexpr
		(ident) @variable))

(array
  (symbol) @variable)

(json_access
	(simplexpr
		(ident) @variable))

(json_safe_access
	(simplexpr
		(ident) @variable))

(json_array
	(simplexpr
    (ident) @variable))

(json_dot_access
	(simplexpr
		(ident) @variable))

(json_safe_dot_access
	(simplexpr
		(ident) @variable))

(json_object
  (_)
  ":"
	(simplexpr
		(ident) @variable))

; Properties & Fields

(keyword) @property

(json_access
  (_)
  "["
	(simplexpr
		(ident) @property))

(json_safe_access
  (_)
  "?."
  "["
	(simplexpr
		(ident) @property))

(json_dot_access
  (index) @property)

(json_safe_dot_access
  (index) @property)

(json_object
	(simplexpr
		(ident) @field))

; Operators

[
  "+"
  "-"
  "*"
  "/"
  "%"
	"&&"
  "||"
  "=="
  "!="
  "=~"
	">="
	"<="
  ">"
  "<"
	"?:"
	"?."
  "!"
] @operator

(ternary_expression
  ["?" ":"] @conditional.ternary)

; Properties & Fields

(keyword) @property

(json_access
  (_)
  "["
	(simplexpr
		(ident) @property))

(json_safe_access
  (_)
  "?."
  "["
	(simplexpr
		(ident) @property))

(json_dot_access
  (index) @property)

(json_safe_dot_access
  (index) @property)

(json_object
	(simplexpr
		(ident) @field))

; Operators

[
  "+"
  "-"
  "*"
  "/"
  "%"
  "||"
  "&&"
  "=="
  "!="
  "=~"
  ">"
  "<"
  ">="
  "<="
  "!"
  "?."
] @operator

(ternary_expression
  ["?" ":"] @conditional.ternary)

; Punctuation

[
  ":"
  "."
  ","
] @punctuation.delimiter

["{" "}" "[" "]" "(" ")"] @punctuation.bracket

; Literals

(number) @number

(float) @float

(boolean) @boolean

; Strings

[ (string_fragment) "\"" "'" "`" ] @string

(string_interpolation
  "${" @punctuation.special
  "}" @punctuation.special)

(escape_sequence) @string.escape

; Comments

(comment) @comment @spell

; Other stuff that has not been catched by the previous queries yet

(ident) @variable
(index) @property

; Errors

(ERROR) @error
