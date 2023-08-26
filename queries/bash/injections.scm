((comment) @injection.content 
 (#set! injection.language "comment"))

((regex) @injection.content
 (#set! injection.language "regex"))

((heredoc_redirect
  (heredoc_body) @injection.content
  (heredoc_end) @injection.language)
 (#downcase! @injection.language))
