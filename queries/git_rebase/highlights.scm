((command) @keyword
  (label)? @constant
  (message)? @text @spell)

(option) @operator

(comment) @comment


(ERROR _ @error) ; up the specificity to nodes under error, instead of parent node
