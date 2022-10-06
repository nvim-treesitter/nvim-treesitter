(text) @html

(comment) @phpdoc

;; bash

((function_call_expression
  function: (_) @_shell_func_identifier
  arguments: (arguments . (argument (_ (string_value) @bash))))
  (#any-of? @_shell_func_identifier "shell_exec" "escapeshellarg" 
   "escapeshellcmd" "exec" "passthru" "proc_open" "shell_exec" "system"))

((expression_statement (shell_command_expression (string_value) @bash)))

