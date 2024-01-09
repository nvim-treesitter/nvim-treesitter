((comment) @injection.content
  (#set! injection.language "comment"))

((variable
  (name) @_name
  value: (string) @injection.content)
  (#any-of? @_name "cmd" "command" "textconv")
  (#set! injection.language "bash"))
