([
  (block_comment)
  (line_comment)
 ] @injection.content
 (#set! injection.language "comment"))

((block_comment) @injection.content
  (#lua-match? @injection.content "/[*][!<*][^a-zA-Z]")
  (#set! injection.language "doxygen"))
