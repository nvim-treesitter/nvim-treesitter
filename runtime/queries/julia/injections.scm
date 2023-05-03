;; Inject markdown in docstrings 
((string_literal) @injection.content
  . [
    (module_definition)
    (abstract_definition)
    (struct_definition)
    (function_definition)
    (short_function_definition)
    (assignment)
    (const_statement)
  ]
 (#lua-match? @injection.content "^\"\"\"")
 (#set! injection.language "markdown")
 (#offset! @injection.content 0 3 0 -3))

([
  (line_comment)
  (block_comment)
 ] @injection.content
 (#set! injection.language "comment"))

((prefixed_string_literal
   prefix: (identifier) @_prefix) @injection.content
 (#eq? @_prefix "r")
 (#set! injection.language "regex")
 (#offset! @injection.content 0 2 0 -1))
