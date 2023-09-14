; =============================================================================
; generalized_strings

; regex in generalized_strings
(generalized_string 
  (identifier) @_string_prefix .
  (string_literal "\"" . "\"") @injection.content
  (#set! injection.language "regex")
  (#offset! @injection.content 0 1 0 -1) ; wrapping `"` 
  (#any-of? @_string_prefix "re" "rex"))

; regex in multiline generalized_strings
(generalized_string 
  (identifier) @_string_prefix .
  (string_literal "\"\"\"" . "\"\"\"") @injection.content
  (#set! injection.language "regex")
  (#offset! @injection.content 0 3 0 -3) ; wrapping `"""`
  (#any-of? @_string_prefix "re" "rex"))

; sql in generalized_strings
(generalized_string 
  (identifier) @_string_prefix .
  (string_literal "\"" . "\"") @injection.content
  (#set! injection.language "sql")
  (#offset! @injection.content 0 1 0 -1) ; wrapping `"` 
  (#eq? @_string_prefix "sql"))

; sql in multiline generalized_strings
(generalized_string 
  (identifier) @_string_prefix .
  (string_literal "\"\"\"" . "\"\"\"") @injection.content
  (#set! injection.language "sql")
  (#offset! @injection.content 0 3 0 -3) ; wrapping `"""`
  (#eq? @_string_prefix "sql"))

; there is no ts parser for peg
; (generalized_string 
;   (identifier) @_string_prefix .
;   (string_literal "\"" . "\"") @injection.content
;   (#set! injection.language "peg")
;   (#offset! @injection.content 0 1 0 -1)
;   (#eq? @_string_prefix "p[eE][gG]"))

; format string in generalized_strings
(generalized_string 
  (identifier) @_string_prefix .
  (string_literal) @injection.content
  (#set! injection.language "nim_format_string")
  (#eq? @_string_prefix "fmt"))

; format string in normal strings with & prefix
(prefix_expression
  operator: (operator) @_string_prefix .
  (string_literal) @injection.content
  (#set! injection.language "nim_format_string")
  (#eq? @_string_prefix "&"))

; =============================================================================
; asm statement

; there is no ts parser for assembly
; (assembly_statement (string_literal) @injection.content
;   (#set! injection.language "assembly"))

; =============================================================================
; emit pragma

; C / CPP / OBJC / JAVASCRIPT
; a `#<space><language name>`
; has to directly precede the {.emit: "<language code>".} pragma

; eg.:
; # objc
; {.emit: "<objc code>".}
; OR
; # javascript
; {.emit: "<javascript code>".}

; normal strings
((comment) @injection.language
  (#offset! @injection.language 0 2 0 0) . ; leading `# `
  (pragma_statement
    (pragma_list
      (colon_expression
        left: (identifier) @_emit_keyword (#eq? @_emit_keyword "emit")
        right: (string_literal "\"" . "\"") @injection.content)
          (#offset! @injection.content 0 1 0 -1) ; wrapping `"`
    )))

; multiline strings
((comment) @injection.language
  (#offset! @injection.language 0 2 0 0) . ; leading `# `
  (pragma_statement
    (pragma_list
      (colon_expression
        left: (identifier) @_emit_keyword (#eq? @_emit_keyword "emit")
        right: (string_literal "\"\"\"" . "\"\"\"") @injection.content)
          (#offset! @injection.content 0 3 0 -3) ; wrapping `"""`
    )))

; =============================================================================
; comments

; NOTE: ts "comment" parser heavily impacts performance

; ts comment parse in normal comments
; ((comment) @injection.content
;   (#offset! @injection.content 0 1 0 0) ; leading `#`
;   (#set! injection.language "comment"))

; ts comment parse in normal block comments
; ((block_comment) @injection.content
;   (#offset! @injection.content 0 2 0 -2) ; wrapping `#[` `]#`
;   (#set! injection.language "comment"))

; markdown parser in documentation_comment
((documentation_comment) @injection.content
  (#offset! @injection.content 0 2 0 0) ; leading `##`
  (#set! injection.language "markdown_inline"))

; markdown parser in block_documentation_comment
((block_documentation_comment) @injection.content
  (#offset! @injection.content 0 3 0 -3) ; wrapping `##[` `]##`
  (#set! injection.language "markdown"))

