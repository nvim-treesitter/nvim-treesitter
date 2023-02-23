((function_call
  name: [
    (identifier) @_cdef_identifier
    (_ _ (identifier) @_cdef_identifier)
  ]
  arguments: (arguments (string content: _ @c)))
  (#eq? @_cdef_identifier "cdef"))

((function_call
  name: (_) @_vimcmd_identifier
  arguments: (arguments (string content: _ @vim)))
  (#any-of? @_vimcmd_identifier "vim.cmd" "vim.api.nvim_command" "vim.api.nvim_exec"))

((function_call
  name: (_) @_vimcmd_identifier
  arguments: (arguments (string content: _ @query) .))
  (#eq? @_vimcmd_identifier "vim.treesitter.query.set_query"))

(function_call
  (dot_index_expression
    table: (identifier) @_table_name
    field: (identifier) @_field_name)
  arguments: (arguments (_) (string ("string_content") @luap))
  (#eq? @_table_name "string")
  (#any-of? @_field_name "find" "gsub" "gmatch" "match"))

((method_index_expression
   table: (_)
   method: (identifier) @_method_name)
 (arguments (string ("string_content") @luap))
 (#any-of? @_method_name "find" "gsub" "match" "gmatch"))

;; highlight string as query if starts with `;; query`
((string ("string_content") @query) (#lua-match? @query "^%s*;+%s?query"))

(comment) @comment
