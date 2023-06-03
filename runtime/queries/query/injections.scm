((predicate 
  name: (identifier) @_name
  parameters: (parameters (string) @injection.content))
 (#match? @_name "^#?(not-)?(match|vim-match)$")
 (#set! injection.language "regex")
 (#offset! @injection.content 0 1 0 -1))

((predicate
  name: (identifier) @_name
  parameters: (parameters (string) @injection.content))
 (#match? @_name "^#?(not-)?lua-match$")
 (#set! injection.language "luap")
 (#offset! @injection.content 0 1 0 -1))

((predicate
   name: (identifier) @_name
   parameters: (parameters (string) @injection.content . (string) .))
 (#any-of? @_name "gsub" "not-gsub")
 (#set! injection.language "luap")
 (#offset! @injection.content 0 1 0 -1))

((comment) @injection.content
 (#set! injection.language "comment"))
