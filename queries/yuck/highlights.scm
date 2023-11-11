; Tags
; TODO apply to every symbol in list? I think it should probably only be applied to the first child of the list
(list
  (symbol) @tag)

; Includes
(list
  .
  (symbol) @keyword.import
  (#eq? @keyword.import "include"))

; Keywords
(list
  .
  (symbol) @keyword
  (#any-of? @keyword "defwindow" "defwidget" "defvar" "defpoll" "deflisten" "geometry" "children" "struts"))

; Loop
(loop_widget
  .
  "for" @keyword.repeat
  .
  (symbol) @variable
  .
  "in" @keyword.operator)

(loop_widget
  .
  "for" @keyword.repeat
  .
  (symbol) @variable
  .
  "in" @keyword.operator
  .
  (symbol) @variable)

; Builtin widgets
(list
  .
  (symbol) @tag.builtin
  (#any-of? @tag.builtin "box" "button" "calendar" "centerbox" "checkbox" "circular-progress" "color-button" "color-chooser" "combo-box-text" "eventbox" "expander" "graph" "image" "input" "label" "literal" "overlay" "progress" "revealer" "scale" "scroll" "transform"))

; Variables
(ident) @variable

(array
  (symbol) @variable)

((ident) @variable.builtin
  (#any-of? @variable.builtin "EWW_TEMPS" "EWW_RAM" "EWW_DISK" "EWW_BATTERY" "EWW_CPU" "EWW_NET" "EWW_TIME" "EWW_CONFIG_DIR" "EWW_CMD" "EWW_EXECUTABLE"))

; Properties
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
    (ident) @property))

; Functions
(function_call
  name: (ident) @function.call)

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
  "?:"
] @operator

; Punctuation
[
  ":"
  "."
  ","
] @punctuation.delimiter

[
  "{"
  "}"
  "["
  "]"
  "("
  ")"
] @punctuation.bracket

; Ternary expression
(ternary_expression
  [
    "?"
    ":"
  ] @keyword.conditional.ternary)

; Literals
(number) @number

(float) @number.float

(boolean) @boolean

; Strings
[
  (string_fragment)
  "\""
  "'"
  "`"
] @string

(string_interpolation
  "${" @punctuation.special
  "}" @punctuation.special)

(escape_sequence) @string.escape

; Comments
(comment) @comment @spell
