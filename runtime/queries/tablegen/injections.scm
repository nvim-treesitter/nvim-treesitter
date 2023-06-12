((code) @injection.content
  (#set! injection.language "cpp")
  (#offset! @injection.content 0 2 0 -2))

((tablegen_file
  (comment) @injection.content)
  (#lua-match? @injection.content "^.*RUN")
  (#set! injection.language "bash")
  (#offset! @injection.content 0 8))
