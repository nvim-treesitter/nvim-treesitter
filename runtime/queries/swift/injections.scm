((regex_literal) @injection.content
  (#set! injection.language "regex"))

([
  (comment)
  (multiline_comment)
] @injection.content
  (#set! injection.language "comment"))
