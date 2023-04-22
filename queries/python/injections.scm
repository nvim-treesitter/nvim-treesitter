(call
  function: (attribute
              object: (identifier) @_re)
  arguments: (argument_list (string
                              (string_content) @injection.content) @_string)
  (#eq? @_re "re")
  (#lua-match? @_string "^r.*")
  (#set! injection.language "regex"))

((expression_statement
   (string (string_content) @injection.content))
 (#set! injection.language "rst"))

((comment) @injection.content
 (#lua-match? @injection.content "^#: ")
 (#offset! @injection.content 0 3 0 0)
 (#set! injection.language "rst"))

((comment) @injection.content
 (#set! injection.language "comment"))
