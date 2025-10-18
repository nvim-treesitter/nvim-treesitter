(call
  function: (attribute
    object: (identifier) @_re)
  arguments: [
    (argument_list
      .
      (string
        (string_content) @injection.content)
      (#set! injection.language "regex"))
    (argument_list
      .
      (concatenated_string
        (string
          (string_content) @injection.content))
      (#set! injection.language "regex"))
  ]
  (#eq? @_re "re")
  (#set! injection.combined))

((binary_operator
  left: (string
    (string_content) @injection.content)
  operator: "%")
  (#set! injection.language "printf"))

((comment) @injection.content
  (#set! injection.language "comment"))
