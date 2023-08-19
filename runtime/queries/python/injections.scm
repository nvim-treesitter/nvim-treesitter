(call
  function: (attribute
              object: (identifier) @_re)
  arguments: (argument_list (string
                              (string_content) @injection.content) @_string)
  (#eq? @_re "re")
  (#lua-match? @_string "^r.*")
  (#set! injection.language "regex"))

((binary_operator
  left: (string (string_content) @injection.content)
  operator: "%")
 (#set! injection.language "printf"))

((comment) @injection.content
 (#set! injection.language "comment"))
