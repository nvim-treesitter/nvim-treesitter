; Priorities of the highlight queries are raised, so that they overrule the
; often surrounding and overlapping highlights from the non-gotmpl injections.
;
; Identifiers
([
  (field)
  (field_identifier)
] @variable.member
  (#set! priority 110))

((variable) @variable
  (#set! priority 110))

; Function calls
(function_call
  function: (identifier) @function
  (#set! priority 110))

(method_call
  method: (selector_expression
    field: (field_identifier) @function
    (#set! priority 110)))

; Builtin functions
(function_call
  function: (identifier) @function.builtin
  (#set! priority 110)
  (#any-of? @function.builtin
    "and" "call" "html" "index" "slice" "js" "len" "not" "or" "print" "printf" "println" "urlquery"
    "eq" "ne" "lt" "ge" "gt" "ge"))

; Operators
([
  "|"
  "="
  ":="
] @operator
  (#set! priority 110))

; Delimiters
([
  "."
  ","
] @punctuation.delimiter
  (#set! priority 110))

([
  "{{"
  "}}"
  "{{-"
  "-}}"
  ")"
  "("
] @punctuation.bracket
  (#set! priority 110))

; Actions
(if_action
  [
    "if"
    "else"
    "else if"
    "end"
  ] @keyword.conditional
  (#set! priority 110))

(range_action
  [
    "range"
    "else"
    "end"
  ] @keyword.repeat
  (#set! priority 110))

(template_action
  "template" @function.builtin
  (#set! priority 110))

(block_action
  [
    "block"
    "end"
  ] @keyword.directive
  (#set! priority 110))

(define_action
  [
    "define"
    "end"
  ] @keyword.directive.define
  (#set! priority 110))

(with_action
  [
    "with"
    "else"
    "end"
  ] @keyword.conditional
  (#set! priority 110))

; Literals
([
  (interpreted_string_literal)
  (raw_string_literal)
] @string
  (#set! priority 110))

((rune_literal) @string.special.symbol
  (#set! priority 110))

((escape_sequence) @string.escape
  (#set! priority 110))

([
  (int_literal)
  (imaginary_literal)
] @number
  (#set! priority 110))

((float_literal) @number.float
  (#set! priority 110))

([
  (true)
  (false)
] @boolean
  (#set! priority 110))

((nil) @constant.builtin
  (#set! priority 110))

((comment) @comment @spell
  (#set! priority 110))
