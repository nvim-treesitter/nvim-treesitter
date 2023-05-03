((comment) @injection.content 
 (#set! injection.language "comment"))

(heredoc_body
 (heredoc_content) @injection.content
 (heredoc_end) @injection.language
 (#set! "language" @injection.language)
 (#downcase! "language"))

(regex 
  (string_content) @injection.content 
  (#set! injection.language "regex"))
