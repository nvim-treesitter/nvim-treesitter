;; by @oponkork with extensions by @theHamsta

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
  "module"
  "endmodule"
  "contains"
  "public"
  "private"
] @include

[
"implicit"
(none)
] @annotation

[
  "function"
  "endfunction"
  "endprogram"
  "subroutine"
  "endsubroutine"
] @keyword.function

[
  "bind"
  "call"
  "continue"
  "cycle"
  "enumerator"
  "equivalence"
  "exit"
  "format"
  "goto"
  "include"
  "interface"
  "parameter"
  "print"
  "program"
  "read"
  "return"
  "stop"
  "use"
  "write"
  (default)
  (procedure_qualifier)
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
  "*"
  "+"
  "-"
  "/"
  "="
  "<"
  ">"
  "<="
  ">="
  "=="
  "/="
] @operator

[
  "\\.and\\."
  "\\.or\\."
  "\\.lt\\."
  "\\.gt\\."
  "\\.ge\\."
  "\\.le\\."
  "\\.eq\\."
  "\\.eqv\\."
  "\\.neqv\\."
] @keyword.operator

 ;; Brackets
 [
  "("
  ")"
  "["
  "]"
 ] @punctuation.bracket

 ;; Delimiter
 [
  "::"
  ","
 ] @punctuation.bracket

(parameters
  (identifier) @parameter)

(subroutine_statement
  (name) @function)

(subroutine_call
	(name) @function)

(module_statement
  (name) @namespace)
