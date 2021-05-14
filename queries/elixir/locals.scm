[
  (after_block)
  (catch_block)
  (do_block)
  (stab_expression)
  (rescue_block)
] @scope

(identifier) @reference

(call
 function: (function_identifier) @_call-name
 (module) @definition.type
 (#eq? @_call-name "defmodule"))

(call
 function: (function_identifier) @_call-name
 (call
  function: (function_identifier) @definition.function)
 (#any-of? @_call-name "def" "defp"))

(call
 function: (function_identifier) @_call-name
 (call
  function: (function_identifier) @definition.function
  (arguments
   [(identifier) @definition.parameter
    (tuple
     (identifier) @definition.parameter)
    (list
     (identifier) @definition.parameter)
    (map
     (keyword_list
      (identifier) @definition.parameter))
    (struct
     (keyword_list
      (identifier) @definition.parameter))
    (binary_op
     left: (identifier) @definition.parameter
     operator: "\\\\")]
   (#lua-match? @definition.parameter "^[^_]")))
 (#any-of? @_call-name "def" "defp"))

(call
 function: (function_identifier) @_call-name
 (binary_op
  left: (call
         function: (function_identifier) @definition.function
         (arguments
          [(identifier) @definition.parameter
           (tuple
            (identifier) @definition.parameter)
           (list
            (identifier) @definition.parameter)
           (map
            (keyword_list
             (identifier) @definition.parameter))
           (struct
            (keyword_list
             (identifier) @definition.parameter))]
          (#lua-match? @definition.parameter "^[^_]")))
  operator: "when")
 (#any-of? @_call-name "def" "defp"))

(binary_op
 left:
 [(identifier) @definition.var
   (tuple
    (identifier) @definition.var)
   (list
    (identifier) @definition.var)
   (map
    (keyword_list
     (identifier) @definition.var))
   (struct
    (keyword_list
     (identifier) @definition.var))]
 operator: "="
 (#lua-match? @definition.var "^[^_]"))

(stab_expression
 left:
 (bare_arguments
  [(identifier) @definition.var
   (tuple
    (identifier) @definition.var)
   (list
    (identifier) @definition.var)
   (map
    (keyword_list
     (identifier) @definition.var))
   (struct
    (keyword_list
     (identifier) @definition.var))])
 (#lua-match? @definition.var "^[^_]"))
