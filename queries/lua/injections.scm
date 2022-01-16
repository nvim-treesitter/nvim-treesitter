; C Injections
(
  (function_call
    (field_expression
      (property_identifier) @_cdef_identifier)
    (arguments
      (string) @c)
  )

  (#eq? @_cdef_identifier "cdef")
  (#lua-match? @c "^[\"']")
  (#offset! @c 0 1 0 -1)
)

(
  (function_call
    (field_expression
      (property_identifier) @_cdef_identifier)
    (arguments
      (string) @c)
  )

  (#eq? @_cdef_identifier "cdef")
  (#lua-match? @c "^%[%[")
  (#offset! @c 0 2 0 -2)
)

; Vimscript Injections
(
  (function_call
    (field_expression) @_vimcmd_identifier
    (arguments
      (string) @vim)
  )

  (#any-of? @_vimcmd_identifier "vim.cmd" "vim.api.nvim_command" "vim.api.nvim_exec")
  (#lua-match? @vim "^[\"']")
  (#offset! @vim 0 1 0 -1)
)

(
  (function_call
    (field_expression) @_vimcmd_identifier
    (arguments
      (string) @vim)
  )

  (#any-of? @_vimcmd_identifier "vim.cmd" "vim.api.nvim_command" "vim.api.nvim_exec")
  (#lua-match? @vim "^%[%[")
  (#offset! @vim 0 2 0 -2)
)

(comment) @comment
