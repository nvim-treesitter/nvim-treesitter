;; by @oponkork

(identifier) @variable
(string_literal) @string
(number_literal) @number
(boolean_literal) @boolean
(comment) @comment

[
  (intrinsic_type)
  ; (primitive_type_qualifier)
  "dimension"
  "intent"
  "in"
  "out"
  "inout"
  "type"
  "endtype"
  "attributes"
  "global"
  "device"
  "host"
  "grid_global"
] @type

[
  "bind"
  "call"
  "contains"
  "continue"
  "cycle"
  "endfunction"
  "endmodule"
  "endprogram"
  "endsubroutine"
  "enumerator"
  "equivalence"
  "exit"
  "format"
  "function"
  "goto"
  "include"
  "interface"
  "module"
  "parameter"
  "print"
  "program"
  "read"
  "return"
  "stop"
  "subroutine"
  "use"
  "write"
  "implicit"
  (none)
  (default)
  (procedure_qualifier)
  (private_statement)
  (public_statement)
] @keyword

[
  "if" 
  "then"
  "else"
  "elseif"
  "endif"
] @conditional

[
  "do"
  "enddo"
  "while"
  "forall"
] @repeat

[
  "<"
  ">"
  "<="
  ">="
  "=="
  "/="
] @keyword.operator

; ;; Brackets
; [
;  "("
;  ")"
;  "["
;  "]"
; ] @punctuation.bracket
