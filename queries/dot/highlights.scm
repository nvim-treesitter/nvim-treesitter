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
    (identifier) @module))

(attribute
  name: (id
    (identifier) @variable.member))

(attribute
  value: (id
    (identifier) @constant))

(comment) @comment @spell

(preproc) @keyword.directive
