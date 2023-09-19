[
  "replace"
  "go"
  "use"
] @keyword

"=>" @operator

(comment) @comment @spell

[
(version)
(go_version)
] @string

(ERROR _ @error) ; up the specificity to nodes under error, instead of parent node
