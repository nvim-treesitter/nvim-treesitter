[(addition) (new_file)] @text.diff.add
[(deletion) (old_file)] @text.diff.delete

(commit) @constant
(location) @attribute
(command) @function

(ERROR _ @error) ; up the specificity to nodes under error, instead of parent node
