(core) @function

(operator) @operator

(word) @variable

((word) @constant
  (#lua-match? @constant "^[A-Z_]+$"))

(number) @number

(string) @string

[
  (start_definition)
  (end_definition)
] @punctuation.delimiter

(comment) @comment @spell

(ERROR _ @error) ; up the specificity to nodes under error, instead of parent node
