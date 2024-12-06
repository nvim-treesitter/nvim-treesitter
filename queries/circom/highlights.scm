; identifiers
; -----------
(identifier) @variable

; Pragma
; -----------
[
  "pragma"
  "circom"
] @keyword.directive

(circom_version) @string.special

; Include
; -----------
[
  "public"
  "signal"
  "var"
  "include"
] @keyword.import

; Literals
; --------
(string) @string

(int_literal) @number

; Definitions
; -----------
(function_definition
  name: (identifier) @function)

(template_definition
  name: (identifier) @function)

; Use constructor coloring for special functions
"main" @constructor

; Invocations
(call_expression
  .
  (identifier) @function.call)

; Function parameters
(parameter
  name: (identifier) @variable.parameter)

; Members
(member_expression
  property: (property_identifier) @property)

; Tokens
; -------
; Keywords
[
  "input"
  "output"
  "public"
  "component"
] @keyword

[
  "for"
  "while"
] @keyword.repeat

[
  "if"
  "else"
] @keyword.conditional

"return" @keyword.return

[
  "function"
  "template"
] @keyword.function

; Punctuation
[
  "("
  ")"
  "["
  "]"
  "{"
  "}"
] @punctuation.bracket

[
  "."
  ","
  ";"
] @punctuation.delimiter

; Operators
[
  "&&"
  "||"
  ">>"
  "<<"
  "&"
  "^"
  "|"
  "+"
  "-"
  "*"
  "/"
  "%"
  "**"
  "<"
  "<="
  "="
  "=="
  "!="
  "+="
  "-="
  ">="
  ">"
  "!"
  "~"
  "-"
  "+"
  "++"
  "--"
  "<=="
  "==>"
  "<--"
  "-->"
  "==="
] @operator

; Comments
(comment) @comment @spell

((comment) @comment.documentation
  (#lua-match? @comment.documentation "^/[*][*][^*].*[*]/$"))
