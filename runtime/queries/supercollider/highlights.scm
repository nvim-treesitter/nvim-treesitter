; highlights.scm
; See this for full list: https://github.com/nvim-treesitter/nvim-treesitter/blob/master/CONTRIBUTING.md
; comments
(line_comment) @comment @spell

(block_comment) @comment @spell

; Argument definition
(argument
  name: (identifier) @variable.parameter)

; Variables
(local_var
  name: (identifier) @variable)

(environment_var
  name: (identifier) @variable.builtin)

(builtin_var) @constant.builtin

; (variable) @variable
; Functions
(function_definition
  name: (variable) @function)

; For function calls
(named_argument
  name: (identifier) @function.call)

; Methods
(method_call
  name: (method_name) @function.method.call)

; Classes
(class) @type

; Literals
(number) @number

(float) @number.float

(string) @string

(symbol) @string.special.symbol

; Operators
[
  "&&"
  "||"
  "&"
  "|"
  "^"
  "=="
  "!="
  "<"
  "<="
  ">"
  ">="
  "<<"
  ">>"
  "+"
  "-"
  "*"
  "/"
  "%"
  "="
] @operator

; Keywords
[
  "arg"
  "classvar"
  "const"
  ; "super"
  ; "this"
  "var"
] @keyword

; Brackets
[
  "("
  ")"
  "["
  "]"
  "{"
  "}"
  "|"
] @punctuation.bracket

; Delimiters
[
  ";"
  "."
  ","
] @punctuation.delimiter

; control structure
(control_structure) @keyword.conditional

(escape_sequence) @string.escape

; SinOsc.ar()!2
(duplicated_statement) @keyword.repeat
