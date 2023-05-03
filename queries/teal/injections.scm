(
  (function_call
    (index
      (identifier) @_cdef_identifier)
    (arguments
      (string) @injection.content)
  )

  (#eq? @_cdef_identifier "cdef")
  (#lua-match? @injection.content "^[\"']")
  (#offset! @injection.content 0 1 0 -1)
  (#set! injection.language "c")
)

(
  (function_call
    (index
      (identifier) @_cdef_identifier)
    (arguments
      (string) @injection.content)
  )

  (#eq? @_cdef_identifier "cdef")
  (#lua-match? @injection.content "^%[%[")
  (#offset! @injection.content 0 2 0 -2)
  (#set! injection.language "c")
)

((comment) @injection.content
 (#set! injection.language "comment"))
