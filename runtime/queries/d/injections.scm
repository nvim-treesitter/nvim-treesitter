((comment) @injection.content
  (#set! injection.language "comment"))

((call_expression
  (type) @_printf
  (arguments
    "("
    .
    (expression
      (string_literal) @injection.content)))
  (#eq? @_printf "printf")
  (#offset! @injection.content 0 1 0 -1)
  (#set! injection.language "printf"))

; TODO: uncomment when asm is added
; ((asm_inline) @injection.content
;   (#set! injection.language "asm")
;   (#set! injection.combined))
