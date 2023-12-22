[
  (anchor_begin)
  (anchor_end)
  "."
] @variable.builtin

(set
  (character "." @constant))
(negated_set
  (character "." @constant)) 
(range
  (character "." @constant))

[
  "[" "]"
  "(" ")"
] @punctuation.bracket

[
  (zero_or_more)
  (shortest_zero_or_more)
  (one_or_more)
  (zero_or_one)
] @operator

(range
  from: (character) @constant
  "-" @operator
  to: (character) @constant)

(set
  (character) @constant)
(negated_set
  (character) @constant)

(class) @keyword

(negated_set "^" @operator)

(balanced_match
  (character) @parameter)
