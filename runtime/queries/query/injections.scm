((predicate
  name: (identifier) @_name
  parameters: (parameters
    (string) @injection.content))
  (#any-of? @_name "match" "not-match" "vim-match" "not-vim-match")
  (#set! injection.language "regex")
  (#offset! @injection.content 0 1 0 -1))

((predicate
  name: (identifier) @_name
  parameters: (parameters
    (string) @injection.content))
  (#any-of? @_name "lua-match" "not-lua-match")
  (#set! injection.language "luap")
  (#offset! @injection.content 0 1 0 -1))

((predicate
  name: (identifier) @_name
  parameters: (parameters
    (string) @injection.content
    .
    (string) .))
  (#any-of? @_name "gsub" "not-gsub")
  (#set! injection.language "luap")
  (#offset! @injection.content 0 1 0 -1))

((comment) @injection.content
  (#set! injection.language "comment"))
