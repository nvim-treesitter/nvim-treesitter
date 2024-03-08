(code_block_lang
  (code_lang) @injection.language
  (code_content) @injection.content)

(code_inline_lang
  (code_inline_content) @injection.content
  (label) @injection.language)

; common aliases
(code_block_lang
  (code_lang) @_language
  (#any-of? @_language "js")
  (code_content) @injection.content
  (#set! injection.language "javascript"))

(code_block_lang
  (code_lang) @_language
  (#any-of? @_language "py")
  (code_content) @injection.content
  (#set! injection.language "python"))

(code_block_lang
  (code_lang) @_language
  (#any-of? @_language "sh" "zsh")
  (code_content) @injection.content
  (#set! injection.language "bash"))
