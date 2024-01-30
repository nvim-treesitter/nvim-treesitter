; Includes
((command_name) @keyword.import
  (#eq? @keyword.import "import"))

; Keywords
[
  "arguments"
  "classdef"
  "end"
  "enumeration"
  "events"
  "global"
  "methods"
  "persistent"
  "properties"
] @keyword

; Conditionals
(if_statement
  [
    "if"
    "end"
  ] @keyword.conditional)

(elseif_clause
  "elseif" @keyword.conditional)

(else_clause
  "else" @keyword.conditional)

(switch_statement
  [
    "switch"
    "end"
  ] @keyword.conditional)

(case_clause
  "case" @keyword.conditional)

(otherwise_clause
  "otherwise" @keyword.conditional)

(break_statement) @keyword.conditional

; Repeats
(for_statement
  [
    "for"
    "parfor"
    "end"
  ] @keyword.repeat)

(while_statement
  [
    "while"
    "end"
  ] @keyword.repeat)

(continue_statement) @keyword.repeat

; Exceptions
(try_statement
  [
    "try"
    "end"
  ] @keyword.exception)

(catch_clause
  "catch" @keyword.exception)

; Variables
(identifier) @variable

; Constants
(events
  (identifier) @constant)

(attribute
  (identifier) @constant)

"~" @constant.builtin

; Fields/Properties
(field_expression
  field: (identifier) @variable.member)

(superclass
  "."
  (identifier) @variable.member)

(property_name
  "."
  (identifier) @variable.member)

(property
  name: (identifier) @variable.member)

; Types
(class_definition
  name: (identifier) @type)

(attributes
  (identifier) @constant)

(enum
  .
  (identifier) @type)

((identifier) @type
  (#lua-match? @type "^_*[A-Z][a-zA-Z0-9_]+$"))

; Functions
(function_definition
  "function" @keyword.function
  name: (identifier) @function
  [
    "end"
    "endfunction"
  ]? @keyword.function)

(function_signature
  name: (identifier) @function)

(function_call
  name: (identifier) @function.call)

(handle_operator
  (identifier) @function)

(validation_functions
  (identifier) @function)

(command
  (command_name) @function.call)

(command_argument) @variable.parameter

(return_statement) @keyword.return

; Parameters
(function_arguments
  (identifier) @variable.parameter)

; Punctuation
[
  ";"
  ","
  "."
] @punctuation.delimiter

[
  "("
  ")"
  "["
  "]"
  "{"
  "}"
] @punctuation.bracket

; Operators
[
  "+"
  ".+"
  "-"
  ".*"
  "*"
  ".*"
  "/"
  "./"
  "\\"
  ".\\"
  "^"
  ".^"
  "'"
  ".'"
  "|"
  "&"
  "?"
  "@"
  "<"
  "<="
  ">"
  ">="
  "=="
  "~="
  "="
  "&&"
  "||"
  ":"
] @operator

; Literals
(string) @string

(escape_sequence) @string.escape

(formatting_sequence) @string.special

(number) @number

(boolean) @boolean

; Comments
[
  (comment)
  (line_continuation)
] @comment @spell
