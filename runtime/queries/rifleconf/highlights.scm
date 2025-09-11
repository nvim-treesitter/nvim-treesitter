(comment) @comment @spell

[
  ","
  ";"
] @punctuation.delimiter

"=" @operator

(binary_condition_identifier) @keyword

(unary_condition_identifier) @keyword

(condition_expression
  (binary_condition_expression
    (binary_condition_identifier) @kw_name
    (identifier) @number)
  (#eq? @kw_name "number"))

(ask) @function.builtin

(string) @string
