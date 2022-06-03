(character) @character
(".") @punctuation.delimiter

[
    (anchor_end)
    "^"
] @punctuation.special

[
    "["
    "]"
    "("
    ")"
] @punctuation.bracket

[
    (zero_or_more)
    (shortest_zero_or_more)
    (one_or_more)
    (zero_or_one)
] @operator

(class) @keyword

(balanced_match
    first: (character) @parameter
    last: (character) @parameter
)
