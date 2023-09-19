; Keywords

[
  "eval"
  "let"
] @keyword

; Function

(function) @function

; Method

(method) @method

; Parameter

(parameter) @parameter

; Variables

(identifier) @variable

; Operators

[
  "\\"
  "->"
  "="
  (step)
] @operator

; Punctuation

["(" ")"] @punctuation.bracket

":" @punctuation.delimiter

; Comments

(comment) @comment @spell

(ERROR _ @error) ; up the specificity to nodes under error, instead of parent node
