((multiline_line
  (identifier) @_id
  .
  (multiline_value
    (multiline_value_content) @injection.content))
  (#lua-match? @_id "_CSS_DEFAULT_STYLE$")
  (#set! injection.language "css")
  (#set! injection.overlay "constant"))

((comment) @injection.content
  (#set! injection.language "comment"))
