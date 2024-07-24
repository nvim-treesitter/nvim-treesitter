; Inject markdown in docstrings
((string_literal) @injection.content
  .
  [
    (module_definition)
    (abstract_definition)
    (struct_definition)
    (function_definition)
    (assignment)
    (const_statement)
  ]
  (#lua-match? @injection.content "^\"\"\"")
  (#set! injection.language "markdown")
  (#offset! @injection.content 0 3 0 -3))

; Inject comments
([
  (line_comment)
  (block_comment)
] @injection.content
  (#set! injection.language "comment"))

; Inject regex in r"hello\bworld"
((prefixed_string_literal
  prefix: (identifier) @_prefix) @injection.content
  (#eq? @_prefix "r")
  (#set! injection.language "regex")
  (#offset! @injection.content 0 2 0 -1))

; Inject markdown in md"**Bold** and _Italics_"
((prefixed_string_literal
  prefix: (identifier) @_prefix) @injection.content
  (#eq? @_prefix "md")
  (#set! injection.language "markdown")
  (#offset! @injection.content 0 3 0 -1))

; Inject bash in `git add --help`
((command_literal) @injection.content
  (#set! injection.language "bash"))
