((comment) @injection.content
 (#set! injection.language "comment"))

((regex) @injection.content
 (#set! injection.language "regex"))

((redirected_statement
   (heredoc_redirect
     (heredoc_start) @injection.language))
 (heredoc_body) @injection.content
 (#offset! @injection.content 0 0 -1 0))

; printf 'format'
((command
  name: (command_name) @_command
  . argument: [(string) (raw_string)] @injection.content)
 (#eq? @_command "printf")
 (#set! injection.language "printf"))

; printf -v var 'format'
((command
  name: (command_name) @_command
  argument: (word) @_arg
  . (_) . argument: [(string) (raw_string)] @injection.content)
 (#eq? @_command "printf")
 (#eq? @_arg "-v")
 (#set! injection.language "printf"))

; printf -- 'format'
((command
  name: (command_name) @_command
  argument: (word) @_arg
  . argument: [(string) (raw_string)] @injection.content)
 (#eq? @_command "printf")
 (#eq? @_arg "--")
 (#set! injection.language "printf"))
