(comment) @comment

; TODO: re-add when markdown is added
; (heredoc
;   (heredoc_content) @markdown)

((sigil
   (sigil_start) @_start
   (sigil_content) @regex)
 (#match? @_start "~(r|R)[/</\\\"[({|]"))

((sigil
   (sigil_start) @_start
   (sigil_content) @surface)
 (#eq? @_start "~F\"\"\""))
