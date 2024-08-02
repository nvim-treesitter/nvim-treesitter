; vim:ft=query
; format-ignore
(fenced_code_block (fenced_code_block_delimiter) @label
  (info_string
    (language) @_lang)
  (#offset! @label 0 1 0 -1)
  (#ft-conceal! @_lang))

([
  (list_marker_minus)
  (list_marker_plus)
  (list_marker_star)
] @markup.list
  (#offset-first-n! @markup.list 1)
  (#set! conceal "•"))

(list
  (list_item
    (list
      (list_item
        ([
          (list_marker_minus)
          (list_marker_plus)
          (list_marker_star)
        ] @markup.list
          (#offset-first-n! @markup.list 1)
          (#set! conceal "◦"))))))

; comment
(while_statement
  [
    "while"
    "do"
  ] @open.loop
  "end" @close.loop) @scope.loop

[
  "toplevel"
  "list"
] @variable

[
  (parent
    (child))+
  (parent
    (child))*
  (parent
    (child))?
] @cap
((
