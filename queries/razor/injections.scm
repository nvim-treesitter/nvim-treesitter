((html_comment) @injection.content
  (#set! injection.language "comment"))

((razor_comment) @injection.content
  (#set! injection.language "comment"))

((comment) @injection.content
  (#set! injection.language "comment"))

((element) @injection.content
  (#set! injection.language "html")
  (#set! injection.include-children)
  (#set! injection.combined))
