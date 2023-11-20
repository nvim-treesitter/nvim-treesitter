(call
  function: (attribute
              object: (identifier) @_re)
  arguments: (argument_list . (string
                              (string_content) @injection.content) @_string)
  (#eq? @_re "re")
  (#set! injection.language "regex"))

((comment) @injection.content
 (#set! injection.language "comment"))
