(set_directive
  (option) @_option
  (string) @injection.content
  (#eq? @_option "synctex-editor-command")
  (#offset! @injection.content 0 1 0 -1)
  (#set! injection.language "bash"))

((comment) @injection.content
  (#set! injection.language "comment"))
