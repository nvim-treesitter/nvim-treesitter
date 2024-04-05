((comment) @injection.content
  (#set! injection.language "comment"))

((regex) @injection.content
  (#set! injection.language "regex"))

((heredoc_redirect
  (heredoc_body) @injection.content
  (heredoc_end) @injection.language)
  (#downcase! @injection.language))

; printf 'format'
((command
  name: (command_name) @_command
  .
  argument: [
    (string)
    (concatenation
      (string) @injection.content)
    (raw_string)
    (concatenation
      (raw_string) @injection.content)
  ] @injection.content)
  (#eq? @_command "printf")
  (#set! injection.language "printf")
  (#set! injection.include-children))

; printf -v var 'format'
((command
  name: (command_name) @_command
  argument: (word) @_arg
  .
  (_)
  .
  argument: [
    (string)
    (concatenation
      (string) @injection.content)
    (raw_string)
    (concatenation
      (raw_string) @injection.content)
  ] @injection.content)
  (#eq? @_command "printf")
  (#eq? @_arg "-v")
  (#set! injection.language "printf")
  (#set! injection.include-children))

; printf -- 'format'
((command
  name: (command_name) @_command
  argument: (word) @_arg
  .
  argument: [
    (string)
    (concatenation
      (string) @injection.content)
    (raw_string)
    (concatenation
      (raw_string) @injection.content)
  ] @injection.content)
  (#eq? @_command "printf")
  (#eq? @_arg "--")
  (#set! injection.language "printf")
  (#set! injection.include-children))
