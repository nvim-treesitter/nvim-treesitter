((comment) @injection.content
  (#set! injection.language "comment"))

((verbatim_string) @injection.content
  (#lua-match? @injection.content "^@\"<html")
  (#set! injection.language "html")
  (#offset! @injection.content 0 2 0 -1))

((verbatim_string) @injection.content
  (#lua-match? @injection.content "@\"<!DOCTYPE html>")
  (#set! injection.language "html")
  (#offset! @injection.content 0 2 0 -1))
