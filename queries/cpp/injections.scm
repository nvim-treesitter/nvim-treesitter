((preproc_arg) @injection.content
 (#set! injection.language "cpp"))

((comment) @injection.content 
 (#set! injection.language "comment"))

((comment) @injection.content
  (#lua-match? @injection.content "/[*][!<*][^a-zA-Z]")
  (#set! injection.language "doxygen"))

(raw_string_literal
  delimiter: (raw_string_delimiter) @injection.language
  (raw_string_content) @injection.content)
