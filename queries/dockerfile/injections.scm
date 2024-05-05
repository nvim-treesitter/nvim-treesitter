((comment) @injection.content
  (#set! injection.language "comment"))

((shell_command) @injection.content
  (#set! injection.language "bash")
  (#set! injection.include-children))

((run_instruction
  (heredoc_block) @injection.content)
  (#set! injection.language "bash")
  (#set! injection.include-children))
