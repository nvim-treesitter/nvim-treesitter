(comment) @comment @spell

[
  ","
  ";"
] @punctuation.delimiter

[
  "="
  (condition_negation)
] @operator

; mark the string values for items interpreted as regex as string.regexp
(binary_condition_expression
  (binary_condition_identifier) @_keyword
  (identifier) @string.regexp
  (#any-of? @_keyword "match" "ext" "mime" "name" "path"))

(binary_condition_identifier) @keyword

(unary_condition_identifier) @keyword

(condition_expression
  (binary_condition_expression
    (binary_condition_identifier) @keyword
    (identifier) @number)
  (#eq? @keyword "number"))

(ask) @function.builtin

(string) @string
