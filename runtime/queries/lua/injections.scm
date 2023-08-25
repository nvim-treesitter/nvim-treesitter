((function_call
  name: [
    (identifier) @_cdef_identifier
    (_ _ (identifier) @_cdef_identifier)
  ]
  arguments: 
    (arguments 
      (string content: _ @injection.content)))
  (#set! injection.language "c")
  (#eq? @_cdef_identifier "cdef"))

((function_call
  name: (_) @_vimcmd_identifier
  arguments: (arguments (string content: _ @injection.content)))
  (#set! injection.language "vim")
  (#any-of? @_vimcmd_identifier "vim.cmd" "vim.api.nvim_command" "vim.api.nvim_command" "vim.api.nvim_exec2"))

((function_call
  name: (_) @_vimcmd_identifier
  arguments: (arguments (string content: _ @injection.content) .))
  (#set! injection.language "query")
  (#any-of? @_vimcmd_identifier "vim.treesitter.query.set" "vim.treesitter.query.parse"))

((function_call
  name: (_) @_vimcmd_identifier
  arguments: (arguments . (_) . (string content: _ @_method) . (string content: _ @injection.content)))
  (#any-of? @_vimcmd_identifier "vim.rpcrequest" "vim.rpcnotify")
  (#eq? @_method "nvim_exec_lua")
  (#set! injection.language "lua"))

;; highlight string as query if starts with `;; query`
(string content: _ @injection.content 
 (#lua-match? @injection.content "^%s*;+%s?query")
 (#set! injection.language "query"))

((comment) @injection.content
  (#lua-match? @injection.content "^[-][-][-][%s]*@")
  (#set! injection.language "luadoc")
  (#set! injection.include-children)
  (#offset! @injection.content 0 3 0 0))

; string.match("123", "%d+")

(function_call
  (dot_index_expression
    field: (identifier) @_method
    (#any-of? @_method "find" "match"))
  arguments: (arguments
               . (_)
               .
               (string
                 content: (string_content) @injection.content
                 (#set! injection.language "luap")
                 (#set! injection.include-children))))

(function_call
  (dot_index_expression
    field: (identifier) @_method
    (#any-of? @_method "gmatch" "gsub"))
  arguments: (arguments
               . (_)
               .
               (string
                 content: (string_content) @injection.content
                 (#set! injection.language "luap")
                 (#set! injection.include-children))))

;("123"):match("%d+")

(function_call
  (method_index_expression
    method: (identifier) @_method
    (#any-of? @_method "find" "match"))
  arguments: (arguments
               . (string
                   content: (string_content) @injection.content
                   (#set! injection.language "luap")
                   (#set! injection.include-children))))

(function_call
  (method_index_expression
    method: (identifier) @_method
    (#any-of? @_method "gmatch" "gsub"))
  arguments: (arguments
               . (string
                 content: (string_content) @injection.content
                 (#set! injection.language "luap")
                 (#set! injection.include-children))))

; string.format("pi = %.2f", 3.14159)
((function_call
  (dot_index_expression
    field: (identifier) @_method)
  arguments: (arguments
               . (string (string_content) @injection.content)))
 (#eq? @_method "format")
 (#set! injection.language "printf"))

; ("pi = %.2f"):format(3.14159)
((function_call
  (method_index_expression
    table: (_ (string (string_content) @injection.content))
    method: (identifier) @_method))
 (#eq? @_method "format")
 (#set! injection.language "printf"))

((comment) @injection.content
  (#set! injection.language "comment")
  (#set! injection.include-children))
