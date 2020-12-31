(doctest_block) @python

;; Directives with nested content

((directive
   name: (type) @_type
   body: (body) @rst)
 (#match?
  @_type
  "^(attention|caution|danger|error|hint|important|note|tip|warning|admonition)|(image|figure)|(topic|sidebar|line-block|parsed-literal|rubric|epigraph|highlights|pull-quote|compound|container)|(table|list-table)|(contents|sectnum|section-numbering|header|footer)|(target-notes)|(meta)|(replace|unicode|date)|(include|class|role|default-role|title|restructuredtext-test-directive)$"))

;; Special directives

;; TODO: using @language and @content on the same capture raises an error.
;; ((directive
;;    name: (type) @_type
;;    body: (body) @language @content)
;;  (#eq? @_type "code"))

;; ((directive
;;    name: (type) @_type
;;    body: (body) @language @content)
;;  (#eq? @_type "raw"))

((directive
   name: (type) @_type
   body: (body) @latex)
 (#eq? @_type "math"))

((directive
   name: (type) @_type
   body: (body) @csv)
 (#eq? @_type "csv-table"))

;; Special roles - prefix

((interpreted_text
  (role) @_role
  "interpreted_text" @latex)
 (#eq? @_role ":math:"))

;; Special roles - suffix

((interpreted_text
  "interpreted_text" @latex
  (role) @_role)
 (#eq? @_role ":math:"))
