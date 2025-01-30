((comment) @injection.content
  (#set! injection.language "comment"))

(math
  (content) @injection.content
  (#set! injection.language "latex"))

(code_block
  (language) @injection.language
  (code) @injection.content)

(raw_block
  (raw_block_info
    (language) @injection.language)
  (content) @injection.content)

(raw_inline
  (content) @injection.content
  (raw_inline_attribute
    (language) @injection.language))

(frontmatter
  (language) @injection.language
  (frontmatter_content) @injection.content)
