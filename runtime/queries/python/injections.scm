(call
  function: (attribute
    object: (identifier) @_re)
  arguments: (argument_list
    (string
      (string_start)
      [
        (string_content) @injection.content
        (interpolation)
      ]+
      (string_end)))
  (#eq? @_re "re")
  (#set! injection.language "regex"))

(call
  function: (attribute
    object: (identifier) @_re)
  arguments: (argument_list
    (concatenated_string
      ((string
        (string_start)
        [
          (string_content) @injection.content
          (interpolation)
        ]+
        (string_end))
        (comment)?)+))
  (#eq? @_re "re")
  (#set! injection.language "regex"))

((binary_operator
  left: (string
    (string_content) @injection.content)
  operator: "%")
  (#set! injection.language "printf"))

((comment) @injection.content
  (#set! injection.language "comment"))
