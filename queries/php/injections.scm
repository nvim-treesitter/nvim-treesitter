(text) @html

(comment) @phpdoc

;; regex

((function_call_expression
  function: (_) @_preg_func_identifier
  arguments: (arguments . (argument (_ (string_value) @regex))))
    (#lua-match? @_preg_func_identifier "^preg_"))
