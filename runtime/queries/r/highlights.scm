; highlights.scm
; Literals
(integer) @number

(float) @number.float

(complex) @number

(string) @string

(string
  (escape_sequence) @string.escape)

(comment) @comment @spell

((program
  .
  (comment) @keyword.directive @nospell)
  (#lua-match? @keyword.directive "^#!/"))

(identifier) @variable

((dollar
  (identifier) @variable.builtin)
  (#eq? @variable.builtin "self"))

(dollar
  _
  (identifier) @variable.member)

; Parameters
(formal_parameters
  (identifier) @variable.parameter)

(formal_parameters
  (default_parameter
    name: (identifier) @variable.parameter))

(default_argument
  name: (identifier) @variable.parameter)

; Namespace
(namespace_get
  namespace: (identifier) @module)

(namespace_get_internal
  namespace: (identifier) @module)

; Operators
[
  "="
  "<-"
  "<<-"
  "->"
] @operator

(unary
  operator: [
    "-"
    "+"
    "!"
    "~"
    "?"
  ] @operator)

(binary
  operator: [
    "-"
    "+"
    "*"
    "/"
    "^"
    "<"
    ">"
    "<="
    ">="
    "=="
    "!="
    "||"
    "|"
    "&&"
    "&"
    ":"
    "~"
  ] @operator)

[
  "|>"
  (special)
] @operator

(lambda_function
  "\\" @operator)

[
  "("
  ")"
  "["
  "]"
  "{"
  "}"
] @punctuation.bracket

"," @punctuation.delimiter

(dollar
  _
  "$" @operator)

(subset2
  "[[" @punctuation.bracket
  "]]" @punctuation.bracket)

[
  (dots)
  (break)
  (next)
] @keyword

[
  (nan)
  (na)
  (null)
  (inf)
] @constant.builtin

[
  "if"
  "else"
  "switch"
] @keyword.conditional

[
  "while"
  "repeat"
  "for"
  "in"
] @keyword.repeat

[
  (true)
  (false)
] @boolean

"function" @keyword.function

; Functions/Methods
(call
  function: (identifier) @function.call)

(call
  (namespace_get
    function: (identifier) @function.call))

(call
  (namespace_get_internal
    function: (identifier) @function.call))

(call
  function: (dollar
    _
    (identifier) @function.method.call))
