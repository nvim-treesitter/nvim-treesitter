((comment_content) @injection.content
  (#set! injection.language "comment"))

((rest) @injection.content
  (#lua-match? @injection.content "^diff")
  (#set! injection.language "diff"))
