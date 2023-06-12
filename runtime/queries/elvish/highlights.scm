(comment) @comment @spell

[
  "if"
  "elif"
] @keyword.conditional

(if
  (else
    "else" @keyword.conditional))

[
  "while"
  "for"
] @keyword.repeat

(while
  (else
    "else" @keyword.repeat))

(for
  (else
    "else" @keyword.repeat))

[
  "try"
  "catch"
  "finally"
] @keyword.exception

(try
  (else
    "else" @keyword.exception))

"use" @keyword.import

(import
  (bareword) @string.special.path)

(wildcard
  [
    "*"
    "**"
    "?"
  ] @character.special)

(command
  argument: (bareword) @variable.parameter)

(command
  head: (identifier) @function.call)

((command
  head: (identifier) @keyword.return)
  (#eq? @keyword.return "return"))

((command
  (identifier) @keyword.operator)
  (#any-of? @keyword.operator "and" "or" "coalesce"))

[
  "+"
  "-"
  "*"
  "/"
  "%"
  "<"
  "<="
  "=="
  "!="
  ">"
  ">="
  "<s"
  "<=s"
  "==s"
  "!=s"
  ">s"
  ">=s"
] @function.builtin

[
  ">"
  "<"
  ">>"
  "<>"
  "|"
] @operator

(io_port) @number

(function_definition
  "fn" @keyword.function
  (identifier) @function)

(parameter_list) @variable.parameter

(parameter_list
  "|" @punctuation.bracket)

[
  "var"
  "set"
  "tmp"
  "del"
] @keyword

(variable_declaration
  (lhs
    (identifier) @variable))

(variable_assignment
  (lhs
    (identifier) @variable))

(temporary_assignment
  (lhs
    (identifier) @variable))

(variable_deletion
  (identifier) @variable)

(number) @number

(string) @string

(variable
  (identifier) @variable)

((variable
  (identifier) @function)
  (#lua-match? @function ".+[~]$"))

((variable
  (identifier) @boolean)
  (#any-of? @boolean "true" "false"))

((variable
  (identifier) @constant.builtin)
  (#any-of? @constant.builtin
    "_" "after-chdir" "args" "before-chdir" "buildinfo" "nil" "notify-bg-job-success" "num-bg-jobs"
    "ok" "paths" "pid" "pwd" "value-out-indicator" "version"))

[
  "$"
  "@"
] @punctuation.special

[
  "("
  ")"
  "["
  "]"
  "{"
  "}"
] @punctuation.bracket

";" @punctuation.delimiter
