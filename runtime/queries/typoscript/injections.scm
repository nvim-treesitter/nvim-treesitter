((multiline_line
  (identifier) @_id
  .
  (multiline_value
    (multiline_value_content) @injection.content))
  (#lua-match? @_id "_CSS_DEFAULT_STYLE$")
  (#set! injection.language "css"))

((comment) @injection.content
  (#set! injection.language "comment"))

((single_line_comment) @injection.content
  (#set! injection.language "comment"))
