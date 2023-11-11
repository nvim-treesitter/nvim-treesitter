((comment) @injection.content
  (#set! injection.language "comment"))

; asm_statement if asm ever highlighted :)
; #include <...>
((hash_statement) @injection.content
  (#set! injection.language "c"))

; regex for the methods defined in `re` module
((call_expression
  name:
    (selector_expression
      field:
        (reference_expression
          (identifier) @_re))
  arguments:
    (argument_list
      (argument
        (literal
          (raw_string_literal) @injection.content
          (#offset! @injection.content 0 2 0 -1)))))
  (#any-of? @_re "regex_base" "regex_opt" "compile_opt")
  (#set! injection.language "regex"))
