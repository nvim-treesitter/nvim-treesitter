((comment) @injection.content
  (#set! injection.language "comment"))

((entry
  key: (identifier) @_exec
  value: (string) @injection.content)
  (#eq? @_exec "Exec")
  (#set! injection.language "bash"))
