((comment) @injection.content
 (#set! injection.language "comment"))

(heredoc_template
  (template_literal) @injection.content
  (heredoc_identifier) @injection.language
  (#downcase! @injection.language))
