; adapted from https://github.com/vhyrro/tree-sitter-luap

(".") @character

[
  (anchor_begin)
  (anchor_end)
] @punctuation.special

[
  "[" "]"
  "(" ")"
] @punctuation.bracket

[
  (zero_or_more)
  (shortest_zero_or_more)
  (one_or_more)
  (zero_or_one)
] @character.special

(class) @keyword

(balanced_match
  (character) @parameter)
