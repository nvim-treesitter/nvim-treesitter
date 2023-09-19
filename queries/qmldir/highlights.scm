; Preproc

(command (identifier) @preproc)

; Keywords

(keyword) @keyword

; Literals

(number) @number

(float) @float

; Variables

[
  (identifier)
  (unit)
] @variable

; Comments

(comment) @comment @spell

(ERROR _ @error) ; up the specificity to nodes under error, instead of parent node
