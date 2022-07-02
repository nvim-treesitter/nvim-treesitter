(fenced_code_block
  (info_string
    (language) @language)
  (code_fence_content) @content (#exclude_children! @content))

((html_block) @html)

([
  (minus_metadata)
  (plus_metadata)
] @yaml (#offset! @yaml 1 0 -1 0))

((inline) @markdown_inline (#exclude_children! @markdown_inline))
