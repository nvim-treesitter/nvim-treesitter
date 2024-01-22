; inherits: html_tags
(identifier) @variable

(pipe_operator) @operator

(string) @string

(number) @number

(pipe_call
  name: (identifier) @function)

(pipe_call
  arguments:
    (pipe_arguments
      (identifier) @parameter))

(structural_directive
  "*" @keyword
  (identifier) @keyword)

(attribute
  (attribute_name) @variable.template
  (#lua-match? @variable.template "#.*"))

(binding_name
  (identifier) @keyword)

(event_binding
  (binding_name
    (identifier) @keyword.event))

(event_binding
  "\"" @punctuation.delimiter)

(property_binding
  "\"" @punctuation.delimiter)

(structural_assignment
  operator: (identifier) @keyword)

(member_expression
  property: (identifier) @property)

(call_expression
  function: (identifier) @function)

(call_expression
  function:
    ((identifier) @function.builtin
      (#eq? @function.builtin "$any")))

(pair
  key:
    ((identifier) @variable.builtin
      (#eq? @variable.builtin "$implicit")))

((control_keyword) @repeat
  (#any-of? @repeat "for" "empty"))

((control_keyword) @conditional
  (#any-of? @conditional "if" "else" "switch" "case" "default"))

((control_keyword) @keyword.coroutine
  (#any-of? @keyword.coroutine "defer" "placeholder" "loading"))

((control_keyword) @exception
  (#eq? @exception "error"))

(special_keyword) @keyword

((identifier) @boolean
  (#any-of? @boolean "true" "false"))

((identifier) @variable.builtin
  (#any-of? @variable.builtin "this" "$event" "null"))

[
  (ternary_operator)
  (conditional_operator)
] @conditional.ternary

[
  "("
  ")"
  "["
  "]"
  "{"
  "}"
  "{{"
  "}}"
  "@"
  "} @"
  (if_end_expression)
  (for_end_expression)
  (switch_end_expression)
  (case_end_expression)
  (default_end_expression)
  (defer_end_expression)
] @punctuation.bracket

[
  ";"
  "."
  ","
  "?."
] @punctuation.delimiter

(concatination_expression
  "+" @operator)

(binary_expression
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
  ] @operator)
