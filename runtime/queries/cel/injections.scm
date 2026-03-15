; Inject the "comment" language into comments to enable highlighting of
; TODO, FIXME, etc. markers within CEL comment text.
((comment) @injection.content
  (#set! injection.language "comment"))
