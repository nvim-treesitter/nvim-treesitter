; =============================================================================
; generalized_strings

; regex in generalized_strings
(generalized_string 
  function: (identifier) @_string_prefix .
  (string_content) @injection.content
  (#set! injection.language "regex")
  (#any-of? @_string_prefix "re" "rex"))

; sql in generalized_strings
; and anyhting you like as long as the function name is the same as the injected language's parser
(generalized_string 
  function: (identifier) @injection.language
  (string_content) @injection.content)

; format string in generalized_strings
(generalized_string 
  function: (identifier) @_string_prefix .
  (string_content) @injection.content
  (#set! injection.language "nim_format_string")
  (#eq? @_string_prefix "fmt"))

; format string in normal strings with & prefix
(prefix_expression
  operator: (operator) @_string_prefix .
  [
    (interpreted_string_literal (string_content) @injection.content)
    (long_string_literal (string_content) @injection.content)
    (raw_string_literal (string_content) @injection.content)
  ] 
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
; a `#<no whitespace><language name>`
; has to directly precede the {.emit: "<language code>".} pragma

; eg.:
; #objc
; {.emit: "<objc code>".}
; OR
; #javascript
; {.emit: "<javascript code>".}

; normal strings
((comment (comment_content) @injection.language) 
  .
  (pragma_statement
    (pragma_list
      (colon_expression
        left: (identifier) @_emit_keyword (#eq? @_emit_keyword "emit")
        right: [
          (interpreted_string_literal (string_content) @injection.content)
          (long_string_literal (string_content) @injection.content)
          (raw_string_literal (string_content) @injection.content)
        ]))))

; =============================================================================
; comments

; NOTE: ts "comment" parser heavily impacts performance

; markdown parser in documentation_comment
(documentation_comment (comment_content) @injection.content
  (#set! injection.language "markdown_inline"))

; markdown parser in block_documentation_comment
(block_documentation_comment (comment_content) @injection.content
  (#set! injection.language "markdown"))

