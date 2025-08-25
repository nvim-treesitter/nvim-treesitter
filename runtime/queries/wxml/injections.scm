((comment) @injection.content
  (#set! injection.language "comment"))

((raw_text) @injection.content
  (#set! injection.language "javascript")
  (#set! injection.include-children))

((expression) @injection.content
  (#set! injection.language "javascript")
  (#set! injection.include-children))
