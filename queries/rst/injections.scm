((doctest_block) @injection.content
  (#set! injection.language "python"))

; Directives with nested content without arguments nor options
((directive
  name: (type) @_type
  body: (body) @injection.content)
  (#set! injection.language "rst")
  (#any-of? @_type "attention" "caution" "danger" "error" "hint" "important" "note" "tip" "warning" "admonition" "line-block" "parsed-literal" "epigraph" "highlights" "pull-quote" "compound" "header" "footer" "meta" "replace"))

; Directives with nested content without arguments, but with options
((directive
  name: (type) @_type
  body:
    (body
      (options)
      (content) @injection.content))
  (#set! injection.language "rst")
  (#any-of? @_type "attention" "caution" "danger" "error" "hint" "important" "note" "tip" "warning" "admonition" "line-block" "parsed-literal" "compound"))

; Directives with nested content with arguments and options
((directive
  name: (type) @_type
  body:
    (body
      (content) @injection.content))
  (#set! injection.language "rst")
  (#any-of? @_type "figure" "topic" "sidebar" "container" "table" "list-table" "class" "role" "restructuredtext-test-directive"))

; Special directives
((directive
  name: (type) @_type
  body:
    (body
      (arguments) @injection.language
      (content) @injection.content))
  (#any-of? @_type "code" "code-block" "sourcecode"))

((directive
  name: (type) @_type
  body:
    (body
      (arguments) @injection.language
      (content) @injection.content))
  (#eq? @_type "raw"))

((directive
  name: (type) @_type
  body:
    (body
      (content) @injection.content))
  (#set! injection.language "latex")
  (#eq? @_type "math"))

; TODO: re-add when a parser for csv is added.
((directive
  name: (type) @_type
  body:
    (body
      (content) @injection.content))
  (#set! injection.language "csv")
  (#eq? @_type "csv-table"))

; Special roles - prefix
((interpreted_text
  (role) @_role
  "interpreted_text" @injection.content)
  (#eq? @_role ":math:")
  (#set! injection.language "latex"))

; Special roles - suffix
((interpreted_text
  "interpreted_text" @injection.content
  (role) @_role)
  (#eq? @_role ":math:")
  (#set! injection.language "latex"))

((comment) @injection.content
  (#set! injection.language "comment"))
