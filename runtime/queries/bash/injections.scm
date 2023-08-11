((comment) @injection.content
 (#set! injection.language "comment"))

((regex) @injection.content
 (#set! injection.language "regex"))

((redirected_statement
   (heredoc_redirect
     (heredoc_start) @injection.language))
 (heredoc_body) @injection.content
 (#offset! @injection.content 0 0 -1 0))
