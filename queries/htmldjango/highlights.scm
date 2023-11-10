; adapted from https://github.com/interdependence/tree-sitter-htmldjango

[
  (unpaired_comment)
  (paired_comment)
] @comment @spell

[
  "{{" "}}"
  "{%" "%}"
  (end_paired_statement)
] @punctuation.bracket

[
 "end"
 (tag_name)
] @function

(variable_name) @variable

(filter_name) @method
(filter_argument) @parameter

(keyword) @keyword

[
 "|"
 "="
 (operator)
] @operator
(keyword_operator) @keyword.operator

(string) @string
(filter [ "'" "\"" ] . (filter_argument) @string)

(number) @number
((filter (filter_argument) @number)
 (#lua-match? @number "^%d+$"))

(boolean) @boolean
((filter (filter_argument) @boolean)
 (#any-of? @boolean "True" "False"))

[
  ":"
  "'"
  "\""
] @punctuation.delimiter
