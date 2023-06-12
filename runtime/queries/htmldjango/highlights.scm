; adapted from https://github.com/interdependence/tree-sitter-htmldjango
[
  (unpaired_comment)
  (paired_comment)
] @comment @spell

[
  "{{"
  "}}"
  "{%"
  "%}"
  (end_paired_statement)
] @punctuation.special

(tag_name) @function

((tag_name) @keyword.conditional
  (#any-of? @keyword.conditional "if" "elif" "else" "endif"))

((tag_name) @keyword.repeat
  (#any-of? @keyword.repeat "for" "endfor"))

(variable_name) @variable

(unpaired_statement
  (tag_name)
  (variable
    (variable_name) @variable.parameter)
  .
  "="
  .
  (_))

(filter_name) @function.method

(filter_argument) @variable.parameter

(keyword) @keyword

[
  "|"
  "="
  (operator)
] @operator

(keyword_operator) @keyword.operator

(string) @string

(filter
  [
    "'"
    "\""
  ]
  .
  (filter_argument) @string)

(number) @number

((filter
  (filter_argument) @number)
  (#lua-match? @number "^%d+$"))

(boolean) @boolean

((filter
  (filter_argument) @boolean)
  (#any-of? @boolean "True" "False"))

[
  ":"
  ","
] @punctuation.delimiter
