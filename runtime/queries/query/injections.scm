((predicate
  name: (identifier) @_name
  parameters: (parameters
    (string
      (string_content) @injection.content)))
  (#any-of? @_name "match" "not-match" "any-match" "vim-match" "not-vim-match" "any-vim-match")
  (#set! injection.language "regex"))

((predicate
  name: (identifier) @_name
  parameters: (parameters
    (string
      (string_content) @injection.content)))
  (#any-of? @_name "lua-match" "not-lua-match" "any-lua-match")
  (#set! injection.language "luap"))

((predicate
  name: (identifier) @_name
  parameters: (parameters
    (string
      (string_content) @injection.content)
    .
    (string) .))
  (#any-of? @_name "gsub" "not-gsub")
  (#set! injection.language "luap"))

((comment) @injection.content
  (#set! injection.language "comment"))
