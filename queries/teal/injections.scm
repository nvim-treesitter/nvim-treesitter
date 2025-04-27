((function_call
  (index
    (identifier) @_cdef_identifier)
  (arguments
    (string) @injection.content))
  (#eq? @_cdef_identifier "cdef")
  (#lua-match? @injection.content "^[\"']")
  (#offset! @injection.content 0 1 0 -1)
  (#set! injection.language "c"))

((function_call
  (index
    (identifier) @_cdef_identifier)
  (arguments
    (string) @injection.content))
  (#eq? @_cdef_identifier "cdef")
  (#lua-match? @injection.content "^%[%[")
  (#offset! @injection.content 0 2 0 -2)
  (#set! injection.language "c"))

; string.format('...')
((function_call
  (index
    (identifier) @_base
    key: (identifier) @_entry)
  (arguments
    .
    (string) @injection.content))
  (#eq? @_base "string")
  (#eq? @_entry "format")
  (#set! injection.language "printf"))

; ('...'):format()
((function_call
  (method_index
    (parenthesized_expression
      (string) @injection.content)
    key: (identifier) @_func))
  (#eq? @_func "format")
  (#set! injection.language "printf"))

((comment) @injection.content
  (#set! injection.language "comment"))
