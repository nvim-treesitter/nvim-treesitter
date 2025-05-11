((comment) @injection.content
  (#set! injection.language "comment"))

((comment) @injection.content
  (#lua-match? @injection.content "^///[^/]")
  (#set! injection.language "doxygen"))

((comment) @injection.content
  (#lua-match? @injection.content "^///$")
  (#set! injection.language "doxygen"))

((comment) @injection.content
  (#lua-match? @injection.content "^/[*][*][^*].*[*]/$")
  (#set! injection.language "doxygen"))
