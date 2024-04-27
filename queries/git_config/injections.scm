((comment) @injection.content
  (#set! injection.language "comment"))

((variable
  (name) @_name
  value: (string) @injection.content)
  (#any-of? @_name "cmd" "command" "textconv" "sendmailCmd")
  (#set! injection.language "bash"))

(section
  (variable
    (name) @_name
    value: (string) @injection.content)
  (#eq? @_name "tool")
  (#set! injection.language "bash"))

(section
  (section_header
    (section_name) @_pager)
  (variable
    value: (string) @injection.content)
  (#eq? @_pager "pager")
  (#set! injection.language "bash"))

(section
  (section_header
    (section_name) @_interactive)
  (variable
    (name) @_name
    value: (string) @injection.content)
  (#eq? @_interactive "interactive")
  (#eq? @_name "diffFilter")
  (#set! injection.language "bash"))

; https://github.com/git-lfs/git-lfs
; git lfs install
(section
  (section_header
    (section_name) @_filter
    (subsection_name) @_lfs)
  (variable
    (name) @_name
    value: (string) @injection.content)
  (#eq? @_filter "filter")
  (#eq? @_lfs "lfs")
  (#any-of? @_name "smudge" "process" "clean")
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
    value: (string
      "\""
      "\"") @injection.content)
  (#eq? @_alias "alias")
  (#lua-match? @injection.content "^\"!")
  (#offset! @injection.content 0 2 0 -1)
  (#set! injection.language "bash"))
