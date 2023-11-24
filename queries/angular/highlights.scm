(identifier) @variable
(pipe_sequence "|" @operator)
(string) @string
(number) @number
(pipe_call
  name: (identifier) @function)
(pipe_call
  arguments: (pipe_arguments
               (identifier) @parameter))

(structural_assignment
  operator: (identifier) @keyword)

(member_expression
  property: (identifier) @property)

(call_expression
  function: (identifier) @function)

(call_expression
  function: ((identifier) @function.builtin
    (#eq? @function.builtin "$any")))

[
"let"
"as"
] @keyword

[
"("
")"
"["
"]"
"{"
"}"
] @punctuation.bracket

[
";"
"."
","
"?."
] @punctuation.delimiter

((identifier) @boolean
  (#vim-match? @boolean "^(true|false)$"))
((identifier) @variable.builtin
  (#vim-match? @variable.builtin "^(this|\$event|null)$"))

[
  "-"
  "&&"
  "+"
  "<"
  "<="
  "="
  "=="
  "==="
  "!="
  "!=="
  ">"
  ">="
  "*"
  "/"
  "||"
  "%"
] @operator
