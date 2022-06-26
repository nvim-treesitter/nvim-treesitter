(fenced_code_block
  (info_string
    (language) @language)
  (code_fence_content) @content (#exclude_children! @content))

((html_block) @html)

(document . (section . (thematic_break) (_) @yaml @combined (thematic_break)))
((inline) @markdown_inline (#exclude_children! @markdown_inline))
