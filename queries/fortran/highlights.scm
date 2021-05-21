(identifier) @variable
(string_literal) @string
(number_literal) @number
(boolean_literal) @boolean
(comment) @comment

[
  (intrinsic_type)
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
  "pointer"
] @type

[
  "contains"
  "public"
  "private"
] @include

[
"implicit"
(none)
] @attribute

[
  "function"
  "endfunction"
  "endprogram"
  "subroutine"
  "endsubroutine"
] @keyword.function

[
  "module"
  "endmodule"
  "bind"
  "call"
  "class"
  "continue"
  "cycle"
  "enumerator"
  "equivalence"
  "exit"
  "format"
  "goto"
  "include"
  "interface"
  "endinterface"
  "only"
  "parameter"
  "procedure"
  "print"
  "program"
  "endprogram"
  "read"
  "return"
  "stop"
  "use"
  "write"
  "enum"
  "endenum"
  (default)
  (procedure_qualifier)
] @keyword

[
  "if" 
  "then"
  "else"
  "elseif"
  "endif"
  "where"
  "endwhere"
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
  "%"
 ] @punctuation.delimiter

(parameters
  (identifier) @parameter)

(program_statement
  (name) @namespace)

(module_statement
  (name) @namespace)

(function_statement
  (name) @function)

(subroutine_statement
  (name) @function)

(end_program_statement
  (name) @namespace)

(end_module_statement
  (name) @namespace)

(end_function_statement
  (name) @function)

(end_subroutine_statement
  (name) @function)

(subroutine_call
	(name) @function)

(keyword_argument
  name: (identifier) @keyword)

(derived_type_member_expression
  (type_member) @property)
