((comment) @injection.content
  (#set! injection.language "comment"))

(exec
  (string) @injection.content
  (#set! injection.language "bash"))

((keyword
  (name) @_bind
  (params
    .
    (_)
    .
    (_)
    .
    (string) @_exec
    .
    (string) @injection.content))
  (#lua-match? @_bind "^bind")
  (#lua-match? @_exec "^%s*exec%s*$")
  (#set! injection.language "bash"))
