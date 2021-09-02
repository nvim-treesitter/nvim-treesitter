(
  (function_call
    (field_expression
      (property_identifier) @_cdef_identifier)
    (arguments
      (string) @c)
  )

  (#eq? @_cdef_identifier "cdef")
)

(
  (function_call
    (field_expression
      (property_identifier) @_cmd_identifier)
    (arguments
      (string) @vim)
  )

  (#eq? @_cmd_identifier "cmd")
)


(comment) @comment
