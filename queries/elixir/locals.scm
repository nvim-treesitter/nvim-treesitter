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

; Function definition without arguments
(call (function_identifier) @_call-name
 (identifier) @definition.function
 (#any-of? @_call-name "def" "defp" "defguard" "defguardp"))

; Function definition with arguments
(call (function_identifier) @_call-name
 (call
  function: (function_identifier) @definition.function
  (arguments
   [(identifier) @definition.parameter
    (tuple (identifier) @definition.parameter)
    (list (identifier) @definition.parameter)
    (_
     (keyword_list (identifier) @definition.parameter))
    (binary_op
     left: (identifier) @definition.parameter
     operator: "\\\\")]))
 (#any-of? @_call-name "def" "defp"))

; Function definition with (some) arguments and guard(s)
(call (function_identifier) @_call-name
 (binary_op
  left:
   (call
    function: (function_identifier) @definition.function
    (arguments
     [(identifier) @definition.parameter
      (tuple (identifier) @definition.parameter)
      (list (identifier) @definition.parameter)
      (_
       (keyword_list (identifier) @definition.parameter))]))
  operator: "when")
 (#any-of? @_call-name "def" "defp" "defguard" "defguardp"))

; Variable assignment and simple pattern matching
(binary_op
 left:
 [(identifier) @definition.var
  (tuple (identifier) @definition.var)
  (list (identifier) @definition.var)
  (_
   (keyword_list (identifier) @definition.var))]
 operator: "=")

; Simple stab expression (ex. case pattern matching) without guard(s)
(stab_expression
 left:
 (bare_arguments
  [(identifier) @definition.var
   (tuple (identifier) @definition.var)
   (list (identifier) @definition.var)
   (_
    (keyword_list (identifier) @definition.var))]))

; Simple stab expression (ex. case pattern matching) with guard(s)
(stab_expression
 left:
 (bare_arguments
  (binary_op
   left: [(identifier) @definition.var
          (tuple (identifier) @definition.var)
          (list (identifier) @definition.var)
          (_
           (keyword_list (identifier) @definition.var))])))
