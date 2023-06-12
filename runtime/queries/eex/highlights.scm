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
(ERROR) @error
