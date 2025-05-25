; Specified language.
; filename.lua | 10 col 5 | >!lua!< local value = 10;
(code_block
  (language_delimiter) @injection.language
  (content) @injection.content
  (#offset! @injection.language 0 2 0 -2))

; Automatic language(slightly inaccurate).
; filename.lua | 10 col 5 | local value = 10;
(quickfix_item
  (filename) @injection.filename
  (range)
  (code_block
    .
    (content) @injection.content .))
