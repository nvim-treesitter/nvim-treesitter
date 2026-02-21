; highlights.scm
; See this for full list: https://github.com/nvim-treesitter/nvim-treesitter/blob/master/CONTRIBUTING.md
; Comments
(line_comment) @comment @spell

(block_comment) @comment @spell

; Argument definition
(argument
  name: (identifier) @variable.parameter)

"..." @variable.parameter ; variable argument

; For function calls
(named_argument
  name: (identifier) @variable.parameter)

; Variables
(local_var
  name: (identifier) @variable)

(environment_var
  name: (identifier) @variable.builtin)

(builtin_var) @constant.builtin

; Functions
(function_definition
  name: (variable) @function)

; Methods
(function_call
  name: (_) @function.method.call)

; Collections
(associative_item
  (identifier) @property)

; Classes
(class) @type

(parent_class) @type

(instance_method_name) @function.method

(class_method_name) @function.method

; Literals
(bool) @boolean

(number) @number

(float) @number.float

(string) @string

(escape_sequence) @string.escape

(symbol) @string.special.symbol

; Conditionals
[
  "?"
  "!?"
  "??"
] @keyword.conditional

((function_call
  name: (_) @keyword.conditional)
  (#any-of? @keyword.conditional "if" "while" "case" "switch" "try" "protect"))

((function_call
  name: (_) @keyword.repeat)
  (#any-of? @keyword.repeat "for" "forBy"))

; Duplication operator
"!" @keyword.repeat

; Operators
[
  "&&"
  "||"
  "&"
  "|"
  "^"
  "=="
  "!="
  "==="
  "!=="
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
  "@"
  "|@|"
  "@@"
  "@|@"
  "++"
  "+/+"
  ".."
] @operator

; Keywords
[
  "arg"
  "classvar"
  "const"
  "var"
] @keyword

((local_var
  name: (identifier) @variable.builtin)
  (#any-of? @variable.builtin "this" "super"))

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

; Delimeters
[
  ";"
  "."
  ","
] @punctuation.delimiter
