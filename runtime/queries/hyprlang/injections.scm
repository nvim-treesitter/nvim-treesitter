((comment) @injection.content
  (#set! injection.language "comment"))

(exec
  (string) @injection.content
  (#set! injection.language "bash"))
