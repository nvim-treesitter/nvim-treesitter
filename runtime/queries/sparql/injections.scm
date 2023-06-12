((comment) @injection.content
  (#set! injection.language "comment"))

(regex_expression
  pattern: (rdf_literal
    value: (string) @injection.content)
  (#offset! @injection.content 0 1 0 -1)
  (#set! injection.language "regex"))
