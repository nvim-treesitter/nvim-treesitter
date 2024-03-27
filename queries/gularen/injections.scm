(code_block_labeled
  (code_block_label) @injection.language
  (code_block_content) @injection.content)

; common aliases
(code_block_labeled
  (code_block_label) @_language
  (#any-of? @_language "js")
  (code_block_content) @injection.content
  (#set! injection.language "javascript"))

(code_block_labeled
  (code_block_label) @_language
  (#any-of? @_language "py")
  (code_block_content) @injection.content
  (#set! injection.language "python"))

(code_block_labeled
  (code_block_label) @_language
  (#any-of? @_language "sh" "zsh")
  (code_block_content) @injection.content
  (#set! injection.language "bash"))

(code_block_labeled
  (code_block_label) @_language
  (#any-of? @_language "math")
  (code_block_content) @injection.content
  (#set! injection.language "latex"))
