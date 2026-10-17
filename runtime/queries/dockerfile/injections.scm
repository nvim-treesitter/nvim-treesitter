((comment) @injection.content
  (#set! injection.language "comment"))

((run_instruction
  (shell_command) @injection.content)
  (#set! injection.language "bash")
  (#set! injection.include-children))

((run_instruction
  (heredoc_block) @injection.content)
  (#set! injection.language "bash")
  (#set! injection.include-children))
