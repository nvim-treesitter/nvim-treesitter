(keyword) @keyword

(dir_sep) @punctuation.delimiter

(glob) @punctuation.special

(linebreak) @character.special

(char_sequence) @string.special

(char_sequence
  [ "[" "]" ] @punctuation.bracket)

(char_sequence "!" @operator)

(char_range "-" @operator)

(escaped_char) @string.escape

(comment) @comment @spell

(ERROR _ @error) ; up the specificity to nodes under error, instead of parent node
