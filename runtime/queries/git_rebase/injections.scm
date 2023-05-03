((operation
   (command) @_command
   (message) @injection.content)
(#set! injection.language "bash")
(#any-of? @_command "exec" "x"))

