["BEGIN" "END"] @keyword

(dashes) @punctuation.delimiter

(label) @label

(data) @none

(comment) @comment @spell

(ERROR _ @error) ; up the specificity to nodes under error, instead of parent node
