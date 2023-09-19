; inherits: tsv

"|" @punctuation.delimiter

(ERROR _ @error) ; up the specificity to nodes under error, instead of parent node
