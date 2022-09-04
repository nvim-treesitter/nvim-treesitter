(fenced_code_block
  (info_string
    (language) @language)
  (#not-match? @language "elm")
  (code_fence_content) @content (#exclude-children! @content))

((html_block) @html)

((minus_metadata) @yaml (#offset! @yaml 1 0 -1 0))
((plus_metadata) @toml (#offset! @toml 1 0 -1 0))

((inline) @markdown_inline (#exclude-children! @markdown_inline))
