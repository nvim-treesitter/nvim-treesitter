(modifier) @keyword
(operator) @operator
(attribute) @attribute
(command_sync_prefix) @type
(punctuation) @punctuation.bracket
(delimiter) @punctuation.delimiter
(keysym) @variable
(comment) @comment @spell
(range) @number
"\\\n" @punctuation.special

(ERROR _ @error) ; up the specificity to nodes under error, instead of parent node
