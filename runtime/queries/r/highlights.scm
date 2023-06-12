; Literals
(integer) @number

(float) @number.float

(complex) @number

(string) @string

(string
  (string_content
    (escape_sequence) @string.escape))

; Comments
(comment) @comment @spell

((program
  .
  (comment) @keyword.directive @nospell)
  (#lua-match? @keyword.directive "^#!/"))

; Operators
[
  "?"
  ":="
  "="
  "<-"
  "<<-"
  "->"
  "->>"
  "~"
  "|>"
  "||"
  "|"
  "&&"
  "&"
  "<"
  "<="
  ">"
  ">="
  "=="
  "!="
  "+"
  "-"
  "*"
  "/"
  "::"
  ":::"
  "**"
  "^"
  "$"
  "@"
  ":"
  "special"
] @operator

; Punctuation
[
  "("
  ")"
  "{"
  "}"
  "["
  "]"
  "[["
  "]]"
] @punctuation.bracket

(comma) @punctuation.delimiter

; Variables
(identifier) @variable

; Functions
(binary_operator
  lhs: (identifier) @function
  operator: "<-"
  rhs: (function_definition))

(binary_operator
  lhs: (identifier) @function
  operator: "="
  rhs: (function_definition))

; Calls
(call
  function: (identifier) @function.call)

; Parameters
(parameters
  (parameter
    name: (identifier) @variable.parameter))

(arguments
  (argument
    name: (identifier) @variable.parameter))

; Namespace
(namespace_operator
  lhs: (identifier) @module)

(call
  function: (namespace_operator
    rhs: (identifier) @function))

; Keywords
(function_definition
  name: "function" @keyword.function)

(function_definition
  name: "\\" @operator)

[
  "in"
  (return)
  (next)
  (break)
] @keyword

[
  "if"
  "else"
] @keyword.conditional

[
  "while"
  "repeat"
  "for"
] @keyword.repeat

[
  (true)
  (false)
] @boolean

[
  (null)
  (inf)
  (nan)
  (na)
  (dots)
  (dot_dot_i)
] @constant.builtin
