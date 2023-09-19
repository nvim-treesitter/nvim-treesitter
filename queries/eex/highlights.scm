[
  "%>"
  "--%>"
  "<%!--"
  "<%"
  "<%#"
  "<%%="
  "<%="
] @tag.delimiter

; EEx comments are highlighted as such
(comment) @comment @spell

; Tree-sitter parser errors
(ERROR _ @error) ; up the specificity to nodes under error, instead of parent node
