((comment) @injection.content
  (#set! injection.language "comment"))

((variable
  (name) @_name
  value: (string) @injection.content)
  (#any-of? @_name "cmd" "command" "textconv")
  (#set! injection.language "bash"))

(section
  (section_header
    (section_name) @_alias)
  (variable
    value: (string) @injection.content)
  (#eq? @_alias "alias")
  (#lua-match? @injection.content "^!")
  (#offset! @injection.content 0 1 0 0)
  (#set! injection.language "bash"))

(section
  (section_header
    (section_name) @_alias)
  (variable
    value:
      (string
        "\""
        "\"") @injection.content)
  (#eq? @_alias "alias")
  (#lua-match? @injection.content "^\"!")
  (#offset! @injection.content 0 2 0 -1)
  (#set! injection.language "bash"))
