(identifier) @variable

; Functions
(assignment_statement
  left: (identifier) @function
  right: (function))

(assignment_statement
  left: (identifier) @function
  right: (atomic_function))

(assignment_statement
  left: (identifier) @function
  right: (lambda))

(call
  function: (identifier) @function.call)

((call
  function: (identifier) @function.builtin)
  (#any-of? @function.builtin "Assert" "Info" "IsBound" "Unbind" "TryNextMethod"))

(parameters
  (identifier) @variable.parameter)

(qualified_parameters
  (identifier) @variable.parameter)

(qualified_parameters
  (qualified_identifier
    (identifier) @variable.parameter))

(lambda_parameters
  (identifier) @variable.parameter)

; arg is treated specially when it is the only parameter of a function
((parameters
  .
  (identifier) @variable.parameter.builtin .)
  (#eq? @variable.parameter.builtin "arg"))

((qualified_parameters
  .
  (identifier) @variable.parameter.builtin .)
  (#eq? @variable.parameter.builtin "arg"))

((qualified_parameters
  .
  (qualified_identifier
    (identifier) @variable.parameter.builtin) .)
  (#eq? @variable.parameter.builtin "arg"))

((lambda_parameters
  .
  (identifier) @variable.parameter.builtin .)
  (#eq? @variable.parameter.builtin "arg"))

; Literals
(bool) @constant.builtin

(integer) @number

(float) @number.float

(string) @string

(char) @character

(escape_sequence) @string.escape

[
  (help_topic)
  (help_book)
] @string.special

(tilde) @variable.builtin

; Record selectors
(record_entry
  left: [
    (identifier)
    (integer)
  ] @variable.member)

(record_selector
  selector: [
    (identifier)
    (integer)
  ] @variable.member)

(component_selector
  selector: [
    (identifier)
    (integer)
  ] @variable.member)

(function_call_option
  [
    (identifier)
    (record_entry ;Record entries specify global properties in function calls
      left: [
        (identifier)
        (integer)
      ])
  ] @property)

(help_statement
  (help_selector) @property)

; Operators
[
  "+"
  "-"
  "*"
  "/"
  "^"
  "->"
  ":="
  "<"
  "<="
  "<>"
  "="
  ">"
  ">="
  ".."
  (ellipsis)
] @operator

(help_statement
  (help_operator) @operator)

; Keywords
[
  (break_statement)
  (continue_statement)
  "atomic"
  (quit_statement)
] @keyword

[
  "function"
  "local"
  "end"
] @keyword.function

[
  "and"
  "in"
  "mod"
  "not"
  "or"
] @keyword.operator

"rec" @keyword.type

[
  "readonly"
  "readwrite"
] @keyword.modifier

(atomic_function
  "atomic" @keyword.modifier)

[
  "for"
  "while"
  "do"
  "od"
  "repeat"
  "until"
] @keyword.repeat

[
  "if"
  "then"
  "elif"
  "else"
  "fi"
] @keyword.conditional

"return" @keyword.return

(pragma) @keyword.directive

;Punctuation
[
  ","
  ";"
  "."
  "!."
  ":"
] @punctuation.delimiter

[
  "("
  ")"
  "["
  "!["
  "]"
  "{"
  "}"
] @punctuation.bracket

(help_statement
  "?" @punctuation.special)

;Comments
(comment) @comment @spell
