([
  (paired_comment)
  (unpaired_comment)
] @injection.content
  (#set! injection.language "comment"))

((content) @injection.content
  (#set! injection.language "html")
  (#set! injection.combined))
