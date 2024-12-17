((function_call
  name: [
    (identifier) @_cdef_identifier
    (_
      _
      (identifier) @_cdef_identifier)
  ]
  arguments: (arguments
    (string
      content: _ @injection.content)))
  (#set! injection.language "c")
  (#eq? @_cdef_identifier "cdef"))

((function_call
  name: (_) @_vimcmd_identifier
  arguments: (arguments
    (string
      content: _ @injection.content)))
  (#set! injection.language "vim")
  (#any-of? @_vimcmd_identifier "vim.cmd" "vim.api.nvim_command" "vim.api.nvim_exec2"))

((function_call
  name: (_) @_vimcmd_identifier
  arguments: (arguments
    (string
      content: _ @injection.content) .))
  (#set! injection.language "query")
  (#any-of? @_vimcmd_identifier "vim.treesitter.query.set" "vim.treesitter.query.parse"))

((function_call
  name: (_) @_vimcmd_identifier
  arguments: (arguments
    .
    (_)
    .
    (string
      content: _ @_method)
    .
    (string
      content: _ @injection.content)))
  (#any-of? @_vimcmd_identifier "vim.rpcrequest" "vim.rpcnotify")
  (#eq? @_method "nvim_exec_lua")
  (#set! injection.language "lua"))

; exec_lua [[ ... ]] in functionaltests
((function_call
  name: (identifier) @_function
  arguments: (arguments
    (string
      content: (string_content) @injection.content)))
  (#eq? @_function "exec_lua")
  (#set! injection.language "lua"))

; vim.api.nvim_create_autocmd("FileType", { command = "injected here" })
(function_call
  name: (_) @_vimcmd_identifier
  arguments: (arguments
    .
    (_)
    .
    (table_constructor
      (field
        name: (identifier) @_command
        value: (string
          content: (_) @injection.content))) .)
  ; limit so only 2-argument functions gets matched before pred handle
  (#eq? @_vimcmd_identifier "vim.api.nvim_create_autocmd")
  (#eq? @_command "command")
  (#set! injection.language "vim"))

(function_call
  name: (_) @_user_cmd
  arguments: (arguments
    .
    (_)
    .
    (string
      content: (_) @injection.content)
    .
    (_) .)
  (#eq? @_user_cmd "vim.api.nvim_create_user_command")
  (#set! injection.language "vim"))

(function_call
  name: (_) @_user_cmd
  arguments: (arguments
    .
    (_)
    .
    (_)
    .
    (string
      content: (_) @injection.content)
    .
    (_) .)
  ; Limiting predicate handling to only functions with 4 arguments
  (#eq? @_user_cmd "vim.api.nvim_buf_create_user_command")
  (#set! injection.language "vim"))

; rhs highlighting for vim.keymap.set/vim.api.nvim_set_keymap/vim.api.nvim_buf_set_keymap
; (function_call
;   name: (_) @_map
;   arguments:
;     (arguments
;       . (_)
;       . (_)
;       .
;       (string
;         content: (_) @injection.content))
;   (#any-of? @_map "vim.api.nvim_set_keymap" "vim.keymap.set")
;   (#set! injection.language "vim"))
;
; (function_call
;   name: (_) @_map
;   arguments:
;     (arguments
;       . (_)
;       . (_)
;       . (_)
;       .
;       (string
;         content: (_) @injection.content)
;       . (_) .)
;   (#eq? @_map "vim.api.nvim_buf_set_keymap")
;   (#set! injection.language "vim"))
; highlight string as query if starts with `;; query`
(string
  content: _ @injection.content
  (#lua-match? @injection.content "^%s*;+%s?query")
  (#set! injection.language "query"))

(comment
  content: (_) @injection.content
  (#lua-match? @injection.content "^[-][%s]*[@|]")
  (#set! injection.language "luadoc")
  (#offset! @injection.content 0 1 0 0))

; string.match("123", "%d+")
(function_call
  (dot_index_expression
    field: (identifier) @_method
    (#any-of? @_method "find" "match" "gmatch" "gsub"))
  arguments: (arguments
    .
    (_)
    .
    (string
      content: (string_content) @injection.content
      (#set! injection.language "luap")
      (#set! injection.include-children))))

;("123"):match("%d+")
(function_call
  (method_index_expression
    method: (identifier) @_method
    (#any-of? @_method "find" "match" "gmatch" "gsub"))
  arguments: (arguments
    .
    (string
      content: (string_content) @injection.content
      (#set! injection.language "luap")
      (#set! injection.include-children))))

; string.format("pi = %.2f", 3.14159)
((function_call
  (dot_index_expression
    field: (identifier) @_method)
  arguments: (arguments
    .
    (string
      (string_content) @injection.content)))
  (#eq? @_method "format")
  (#set! injection.language "printf"))

; ("pi = %.2f"):format(3.14159)
((function_call
  (method_index_expression
    table: (_
      (string
        (string_content) @injection.content))
    method: (identifier) @_method))
  (#eq? @_method "format")
  (#set! injection.language "printf"))

(comment
  content: (_) @injection.content
  (#set! injection.language "comment"))

; vim.filetype.add({ pattern = { ["some lua pattern here"] = "filetype" } })
((function_call
  name: (_) @_filetypeadd_identifier
  arguments: (arguments
    (table_constructor
      (field
        name: (_) @_pattern_key
        value: (table_constructor
          (field
            name: (string
              content: _ @injection.content)))))))
  (#set! injection.language "luap")
  (#eq? @_filetypeadd_identifier "vim.filetype.add")
  (#eq? @_pattern_key "pattern"))
