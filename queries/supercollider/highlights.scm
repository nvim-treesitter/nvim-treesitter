; highlights.scm
; See this for full list: https://github.com/nvim-treesitter/nvim-treesitter/blob/master/CONTRIBUTING.md

; comments
(line_comment) @comment
(block_comment) @comment

; Argument definition

; Fixme: Should be attribute but nvim-treesitter doesn't supprt it at the moment
(argument name: (identifier) @parameter) 
;(argument name: (identifier) @parameter)  

; Variables
(local_var name: (identifier) @variable)
(environment_var name:(identifier) @variable.builtin)
(builtin_var) @constant.builtin

; (variable) @variable

; Functions
(function_definition
  name: (variable) @function)

; For function calls
(named_argument 
  name: (identifier) @property) 

; Methods
(instance_method_call 
        name: (method_name) @function)
(class_method_call 
        name: (class_method_name) @method)

; Classes
(class) @type

; Literals
(number) @number
(pi_statement) @constant.builtin
(float) @float

(string) @string
(symbol) @string.special

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
; "const"
; "super"
; "this"
"var"
] @type.builtin

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

; control structure
(control_structure) @conditional

(escape_sequence) @escape

; SinOsc.ar()!2
(duplicated_statement) @repeat

; Builtins
; ((identifier) @variable.builtin
;  (#match? @variable.builtin "^(inf|nil|thisFunction|thisFunctionDef|thisMethod|thisProcess|thisThread|currentEnvironment|topEnvironment)$")
;  (#is-not? local))
