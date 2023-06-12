((comment) @injection.content
  (#set! injection.language "comment"))

((regex) @injection.content
  (#set! injection.language "regex"))

((print_statement
  (exp_list
    .
    (string) @injection.content))
  (#set! injection.language "printf"))

((printf_statement
  (exp_list
    .
    (string) @injection.content))
  (#set! injection.language "printf"))
