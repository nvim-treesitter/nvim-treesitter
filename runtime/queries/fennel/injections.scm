((comment) @injection.content
  (#set! injection.language "comment"))

(list
  .
  (multi_symbol) @_vimcmd_identifier
  (#any-of? @_vimcmd_identifier "vim.cmd" "vim.api.nvim_command" "vim.api.nvim_exec2")
  .
  (string
    (string_content) @injection.content
    (#set! injection.language "vim")))

; NOTE: Matches *exactly* `ffi.cdef`
(list
  .
  (multi_symbol) @_cdef_identifier
  (#eq? @_cdef_identifier "ffi.cdef")
  .
  (string
    (string_content) @injection.content
    (#set! injection.language "c")))

(list
  .
  (multi_symbol) @_ts_query_identifier
  (#any-of? @_ts_query_identifier "vim.treesitter.query.set" "vim.treesitter.query.parse")
  .
  (_)
  .
  (_)
  .
  (string
    (string_content) @injection.content
    (#set! injection.language "query")))

(list
  .
  (multi_symbol) @_vimcmd_identifier
  (#eq? @_vimcmd_identifier "vim.api.nvim_create_autocmd")
  .
  (_)
  .
  (table
    (table_pair
      key: (string
        (string_content) @_command
        (#eq? @_command "command"))
      value: (string
        (string_content) @injection.content
        (#set! injection.language "vim")))))

(list
  .
  (multi_symbol) @_user_cmd
  (#eq? @_user_cmd "vim.api.nvim_create_user_command")
  .
  (_)
  .
  (string
    (string_content) @injection.content
    (#set! injection.language "vim")))

(list
  .
  (multi_symbol) @_user_cmd
  (#eq? @_user_cmd "vim.api.nvim_buf_create_user_command")
  .
  (_)
  .
  (_)
  .
  (string
    (string_content) @injection.content
    (#set! injection.language "vim")))

(list
  .
  (multi_symbol) @_map
  (#any-of? @_map "vim.api.nvim_set_keymap" "vim.keymap.set")
  .
  (_)
  .
  (_)
  .
  (string
    (string_content) @injection.content
    (#set! injection.language "vim")))

(list
  .
  (multi_symbol) @_map
  (#eq? @_map "vim.api.nvim_buf_set_keymap")
  .
  (_)
  .
  (_)
  .
  (_)
  .
  (string
    (string_content) @injection.content
    (#set! injection.language "vim")))

; highlight string as query if starts with `; query`
(string
  (string_content) @injection.content
  (#lua-match? @injection.content "^%s*;+%s?query")
  (#set! injection.language "query"))

; ──────────────────────────────────────────────────────────────────────
; (string.match "123" "%d+")
(list
  .
  (multi_symbol
    member: (symbol_fragment) @_func
    .
    (#any-of? @_func "find" "match" "gmatch" "gsub"))
  .
  (_)
  .
  (string
    (string_content) @injection.content
    (#set! injection.language "luap")
    (#set! injection.include-children)))

; (my-string:match "%d+")
(list
  .
  (multi_symbol_method
    method: (symbol_fragment) @_method
    (#any-of? @_method "find" "match" "gmatch" "gsub"))
  .
  (string
    (string_content) @injection.content
    (#set! injection.language "luap")
    (#set! injection.include-children)))

; (string.format "pi = %.2f" 3.14159)
(list
  .
  (multi_symbol) @_func
  (#eq? @_func "string.format")
  .
  (string
    (string_content) @injection.content
    (#set! injection.language "printf")))
