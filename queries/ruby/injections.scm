((comment) @injection.content 
 (#set! injection.language "comment"))

(heredoc_body
 (heredoc_content) @injection.content
 (heredoc_end) @injection.language
 (#downcase! @injection.language))

(regex 
  (string_content) @injection.content 
  (#set! injection.language "regex"))
