(
  (function_call
    (index
      (identifier) @_cdef_identifier)
    (arguments
      (string) @c)
  )

  (#eq? @_cdef_identifier "cdef")
  (#lua-match? @c "^[\"']")
  (#offset! @c 0 1 0 -1)
)

(
  (function_call
    (index
      (identifier) @_cdef_identifier)
    (arguments
      (string) @c)
  )

  (#eq? @_cdef_identifier "cdef")
  (#lua-match? @c "^%[%[")
  (#offset! @c 0 2 0 -2)
)

; string.format('...')
(function_call
  (index
    (identifier) @_base
    key: (identifier) @_entry)
  (arguments . (string) @printf)
  (#eq? @_base "string")
  (#eq? @_entry "format"))

; ('...'):format()
(function_call
  (method_index (string) @printf
    key: (identifier) @_func)
    (#eq? @_func "format"))

(comment) @comment
