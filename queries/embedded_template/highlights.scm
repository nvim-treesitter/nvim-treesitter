(comment_directive) @comment @spell

[
  "<%#"
  "<%"
  "<%="
  "<%_"
  "<%-"
  "%>"
  "-%>"
  "_%>"
] @keyword

(ERROR _ @error) ; up the specificity to nodes under error, instead of parent node
