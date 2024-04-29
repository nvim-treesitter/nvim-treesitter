; adapted from https://github.com/Beaglefoot/tree-sitter-awk
[
  (identifier)
  (field_ref)
] @variable

(field_ref
  (_) @variable)

; https://www.gnu.org/software/gawk/manual/html_node/Auto_002dset.html
((identifier) @constant.builtin
  (#any-of? @constant.builtin
    "ARGC" "ARGV" "ARGIND" "ENVIRON" "ERRNO" "FILENAME" "FNR" "NF" "FUNCTAB" "NR" "PROCINFO"
    "RLENGTH" "RSTART" "RT" "SYMTAB"))

; https://www.gnu.org/software/gawk/manual/html_node/User_002dmodified.html
((identifier) @variable.builtin
  (#any-of? @variable.builtin
    "BINMODE" "CONVFMT" "FIELDWIDTHS" "FPAT" "FS" "IGNORECASE" "LINT" "OFMT" "OFS" "ORS" "PREC"
    "ROUNDMODE" "RS" "SUBSEP" "TEXTDOMAIN"))

(number) @number

(string) @string

(regex) @string.regexp

(escape_sequence) @string.escape

(comment) @comment @spell

((program
  .
  (comment) @keyword.directive @nospell)
  (#lua-match? @keyword.directive "^#!/"))

(ns_qualified_name
  (namespace) @module)

(ns_qualified_name
  "::" @punctuation.delimiter)

(func_def
  name: (_
    (identifier) @function) @function)

(func_call
  name: (_
    (identifier) @function) @function)

(func_def
  (param_list
    (identifier) @variable.parameter))

[
  "print"
  "printf"
  "getline"
] @function.builtin

[
  (delete_statement)
  (break_statement)
  (continue_statement)
  (next_statement)
  (nextfile_statement)
] @keyword

[
  "func"
  "function"
] @keyword.function

[
  "return"
  "exit"
] @keyword.return

[
  "do"
  "while"
  "for"
  "in"
] @keyword.repeat

[
  "if"
  "else"
  "switch"
  "case"
  "default"
] @keyword.conditional

[
  "@include"
  "@load"
] @keyword.import

"@namespace" @keyword.directive

[
  "BEGIN"
  "END"
  "BEGINFILE"
  "ENDFILE"
] @label

(binary_exp
  [
    "^"
    "**"
    "*"
    "/"
    "%"
    "+"
    "-"
    "<"
    ">"
    "<="
    ">="
    "=="
    "!="
    "~"
    "!~"
    "in"
    "&&"
    "||"
  ] @operator)

(unary_exp
  [
    "!"
    "+"
    "-"
  ] @operator)

(assignment_exp
  [
    "="
    "+="
    "-="
    "*="
    "/="
    "%="
    "^="
  ] @operator)

(ternary_exp
  [
    "?"
    ":"
  ] @keyword.conditional.ternary)

(update_exp
  [
    "++"
    "--"
  ] @operator)

(redirected_io_statement
  [
    ">"
    ">>"
  ] @operator)

(piped_io_statement
  [
    "|"
    "|&"
  ] @operator)

(piped_io_exp
  [
    "|"
    "|&"
  ] @operator)

(field_ref
  "$" @punctuation.delimiter)

(regex
  "/" @punctuation.delimiter)

(regex_constant
  "@" @punctuation.delimiter)

[
  ";"
  ","
] @punctuation.delimiter

[
  "("
  ")"
  "["
  "]"
  "{"
  "}"
] @punctuation.bracket
