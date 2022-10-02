(comment) @comment

; printf 'format'
(command
  name: (command_name) @_command
  (#eq? @_command "printf")
  . argument: [(string) (raw_string)] @printf)

; printf -v var 'format'
(command
  name: (command_name) @_command
  (#eq? @_command "printf")
  argument: (word) @_arg
  (#eq? @_arg "-v")
  . (_) . argument: [(string) (raw_string)] @printf)

; printf -- 'format'
(command
  name: (command_name) @_command
  (#eq? @_command "printf")
  argument: (word) @_arg
  (#eq? @_arg "--")
  . argument: [(string) (raw_string)] @printf)
