(call_expr
  function: (selector_expr
    (identifier) @_regex)
  arguments: (argument_list
    (_)
    .
    (string
      (string_content) @injection.content))
  (#eq? @_regex "regex")
  (#set! injection.language "regex"))

(call_expr
  function: (selector_expr
    (identifier) @_regex
    (select_suffix
      (identifier) @_fn
      (#eq? @_fn "compile")))
  arguments: (argument_list
    .
    (string
      (string_content) @injection.content))
  (#eq? @_regex "regex")
  (#set! injection.language "regex"))

((comment) @injection.content
  (#set! injection.language "comment"))
