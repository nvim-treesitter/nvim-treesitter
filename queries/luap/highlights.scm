[
  (anchor_begin)
  (anchor_end)
  "."
] @variable.builtin

((character "." @constant) @_
 (#has-parent? @_ set negated_set))

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

(class) @keyword

(negated_set
  "^" @operator
  (character) @constant)

(balanced_match
  (character) @parameter)
