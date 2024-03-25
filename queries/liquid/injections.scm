((template_content) @injection.content
  (#set! injection.language "html")
  (#set! injection.combined))

((schema_statement
  (template_content) @injection.content)
  (#set! injection.language "json")
  (#set! injection.combined))

((style_statement
  (template_content) @injection.content)
  (#set! injection.language "css")
  (#set! injection.combined))

((javascript_statement
  (template_content) @injection.content)
  (#set! injection.language "javascript")
  (#set! injection.combined))

((comment) @injection.content
  (#set! injection.language "comment"))
