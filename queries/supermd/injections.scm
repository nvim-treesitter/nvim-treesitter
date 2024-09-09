(fenced_code_block
  (info_string
    (language) @injection.language)
  (code_fence_content) @injection.content)

((html_block) @injection.content
  (#set! injection.language "html"))

(document
  .
  (section
    .
    (thematic_break)
    (_) @injection.content
    (thematic_break))
  (#set! injection.language "ziggy"))

((minus_metadata) @injection.content
  (#set! injection.language "ziggy"))

((inline) @injection.content
  (#set! injection.language "supermd_inline"))
