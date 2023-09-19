; inherits: html

[ "---" ] @punctuation.delimiter

[ "{" "}" ] @punctuation.special

(ERROR _ @error) ; up the specificity to nodes under error, instead of parent node
