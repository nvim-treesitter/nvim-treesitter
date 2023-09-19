"let" @keyword
"in" @keyword

[
  "{"
  "}"
  "["
  "]"
] @punctuation.bracket

"." @punctuation.delimiter

(input) @constant
(comment) @comment @spell

(string) @string
(integer) @number
(float) @float
(boolean) @boolean
(null) @keyword

(ERROR _ @error) ; up the specificity to nodes under error, instead of parent node
