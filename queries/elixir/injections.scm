((sigil
   (sigil_start) @_start
   (sigil_content) @regex)
 (#match? @_start "~(r|R)[/</\\\"[({|]"))

((sigil
   (sigil_start) @_start
   (sigil_content) @surface)
 (#eq? @_start "~F\"\"\""))
