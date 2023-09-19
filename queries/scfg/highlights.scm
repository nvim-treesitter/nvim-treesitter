[
 "{"
 "}"
] @punctuation.bracket

(comment) @comment @spell
(directive_name) @type
(directive_params) @parameter

(ERROR _ @error) ; up the specificity to nodes under error, instead of parent node
