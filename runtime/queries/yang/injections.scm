((comment) @injection.content
 (#set! injection.language "comment"))

((statement
  (statement_keyword "pattern")
  (argument (string) @injection.content))
 (#set! injection.language "regex")
 (#offset! @injection.content 0 1 0 -1))
