(comment) @comment

(shell_code) @bash

(variable_assignment
  operator: "!="
     value: (text) @bash)

(function_expansion
  function: (name) @_fn (#eq? @_fn "shell")
            (arguments) @bash)
