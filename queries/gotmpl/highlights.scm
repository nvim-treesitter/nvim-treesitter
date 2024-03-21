; Identifiers
[
  (field)
  (field_identifier)
] @variable.member

(variable) @variable

; Function calls
(function_call
  function: (identifier) @function)

(method_call
  method: (selector_expression
    field: (field_identifier) @function))

; Builtin functions
(function_call
  function: (identifier) @function.builtin
  (#any-of? @function.builtin
    "and" "call" "html" "index" "slice" "js" "len" "not" "or" "print" "printf" "println" "urlquery"
    "eq" "ne" "lt" "ge" "gt" "ge"))

; Operators
[
  "|"
  ":="
] @operator

; Delimiters
[
  "."
  ","
] @punctuation.delimiter

[
  "{{"
  "}}"
  "{{-"
  "-}}"
  ")"
  "("
] @punctuation.bracket

; Actions
(if_action
  [
    "if"
    "else"
    "else if"
    "end"
  ] @keyword.conditional)

(range_action
  [
    "range"
    "else"
    "end"
  ] @keyword.repeat)

(template_action
  "template" @function.builtin)

(block_action
  [
    "block"
    "end"
  ] @keyword.directive)

(define_action
  [
    "define"
    "end"
  ] @keyword.directive.define)

(with_action
  [
    "with"
    "else"
    "end"
  ] @keyword.conditional)

; Literals
[
  (interpreted_string_literal)
  (raw_string_literal)
] @string

(rune_literal) @string.special.symbol

(escape_sequence) @string.escape

[
  (int_literal)
  (imaginary_literal)
] @number

(float_literal) @number.float

[
  (true)
  (false)
] @boolean

(nil) @constant.builtin

(comment) @comment @spell
