((comment) @injection.content
  (#set! injection.language "comment"))

(heredoc_body
  (heredoc_content) @injection.content
  (heredoc_end) @injection.language
  (#downcase! @injection.language))

; For regex injection see:
; https://github.com/crystal-lang-tools/tree-sitter-crystal/issues/49
