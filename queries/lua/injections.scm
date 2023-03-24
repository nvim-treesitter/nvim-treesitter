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
  (#any-of? @_vimcmd_identifier "vim.treesitter.query.set" "vim.treesitter.query.parse_query" "vim.treesitter.query.parse"))

;; highlight string as query if starts with `;; query`
((string ("string_content") @query) (#lua-match? @query "^%s*;+%s?query"))

((comment) @luadoc
  (#lua-match? @luadoc "[-][-][-][%s]*@")
  (#offset! @luadoc 0 3 0 0))

; string.match("123", "%d+")
(function_call
  (dot_index_expression
    field: (identifier) @_method
    (#any-of? @_method "find" "match"))
  arguments: (arguments (_) . (string content: _ @luap)))

(function_call
  (dot_index_expression
    field: (identifier) @_method
    (#eq? @_method "gmatch" "gsub"))
  arguments: (arguments (_) (string content: _ @luap)))

; ("123"):match("%d+")
(function_call
  (method_index_expression
    method: (identifier) @_method
    (#any-of? @_method "find" "match"))
    arguments: (arguments . (string content: _ @luap)))

(function_call
  (method_index_expression
    method: (identifier) @_method
    (#any-of? @_method "gmatch" "gsub"))
    arguments: (arguments (string content: _ @luap)))

(comment) @comment
