((regex) @injection.content
  (#set! injection.language "regex")
  (#offset! @injection.content 0 1 0 -1))

((comment) @injection.content
  (#set! injection.language "comment"))
