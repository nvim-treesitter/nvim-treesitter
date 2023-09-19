(identifier) @type

[
  "strict"
  "graph"
  "digraph"
  "subgraph"
  "node"
  "edge"
] @keyword

(string_literal) @string
(number_literal) @number

[
  (edgeop)
  (operator)
] @operator

[
  ","
  ";"
] @punctuation.delimiter

[
  "{"
  "}"
  "["
  "]"
  "<"
  ">"
] @punctuation.bracket

(subgraph
  id: (id
    (identifier) @namespace)
)

(attribute
  name: (id
    (identifier) @field)
)

(attribute
  value: (id
    (identifier) @constant)
)

(comment) @comment

(preproc) @preproc

(comment) @spell

(ERROR _ @error) ; up the specificity to nodes under error, instead of parent node
