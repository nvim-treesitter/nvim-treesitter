(metadata) @comment

(comment) @comment @spell

[
  "{"
  "}"
] @punctuation.bracket

"%" @punctuation.special

(ingredient
  "@" @punctuation.delimiter
  (name)? @string.special.symbol
  (amount
    (quantity)? @number
    (units)? @constant)?)

(timer
  "~" @punctuation.delimiter
  (name)? @string.special.symbol
  (amount
    (quantity)? @number
    (units)? @constant)?)

(cookware
  "#" @punctuation.delimiter
  (name)? @string.special.symbol
  (amount
    (quantity)? @number
    (units)? @constant)?)
