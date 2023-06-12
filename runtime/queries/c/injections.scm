((preproc_arg) @injection.content
 (#set! injection.language "c"))

((comment) @injection.content
 (#set! injection.language "comment"))

((comment) @injection.content
  (#match? @injection.content "/\\*!([a-zA-Z]+:)?re2c")
  (#set! injection.language "re2c"))

((comment) @injection.content
  (#lua-match? @injection.content "/[*][!<*][^a-zA-Z]")
  (#set! injection.language "doxygen"))

; TODO: add when asm is added
; (gnu_asm_expression assembly_code: (string_literal) @injection.content
; (#set! injection.language "asm"))
; (gnu_asm_expression assembly_code: (concatenated_string (string_literal) @injection.content)
; (#set! injection.language "asm"))
