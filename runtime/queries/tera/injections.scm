(frontmatter
  (content) @injection.content
  (#set! injection.language "yaml")
  (#set! injection.combined))

((comment_tag) @injection.content
  (#set! injection.language "comment"))
