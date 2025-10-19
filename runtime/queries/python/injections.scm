(call
  function: (attribute
    object: (identifier) @_re)
  arguments: (argument_list
    (comment)*
    .
    [
      (string
        (string_content) @injection.content)
      (concatenated_string
        [
          (string
            (string_content) @injection.content)
          (comment)
        ]+)
    ])
  (#eq? @_re "re")
  (#set! injection.language "regex"))

((binary_operator
  left: (string
    (string_content) @injection.content)
  operator: "%")
  (#set! injection.language "printf"))

((comment) @injection.content
  (#set! injection.language "comment"))
