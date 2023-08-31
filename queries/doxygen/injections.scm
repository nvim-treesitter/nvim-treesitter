((type) @injection.content
  (#set! injection.parent))

([ (function_link) (code) ] @injection.content
  (#set! injection.parent))

((link) @injection.content
  (#set! injection.language "html"))

((code_block
  (code_block_language) @injection.language
  (code_block_content) @injection.content))
