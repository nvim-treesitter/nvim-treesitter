(variable) @variable

[
 "assert"
 "assert_eq"
 "assert_neq"
 "block"
 "console"
 "const"
 "constant"
 "finalize"
 "in"
 "let"
 "mapping"
 "private"
 "program"
 "public"
 "record"
 "self"
 "struct"
] @keyword

[
	"constant"
	"public"
	"private"
] @type.qualifier

"self" @variable.builtin

[
 "transition"
 "function"
 "inline"
] @keyword.function

"import" @include

"return" @keyword.return

 (return_arrow) @punctuation.delimiter

"for" @repeat

[ 
  "if"
  "then"
  "else"
] @conditional

[
 (ternary_if)
 (ternary_else)
] @conditional.ternary


[ ";" "," "::"] @punctuation.delimiter

[
"!"

"&&"
"||"

"=="
"!="

"<"
"<="
">"
">="

"&"
"|"
"^"

"<<"
">>"

"+"
"-"
"*"
"/"
"%"
"**"

"="

"+="
"-="
"*="
"/="
"%="
"**="

"<<="
">>="

"&="
"|="
"^="

"&&="
"||="

] @operator

(comment) @comment @spell

(boolean_literal) @boolean

(constant_declaration 
  (identifier) @constant)

[
 (this_program_id)
 (program_id)
] @string.special

;record declaration
(record_declaration (identifier) @field) 

;struct component 
(struct_component_declaration 
  (identifier) @field)

(type) @type

(associated_constant) @constant

[
 (self_caller)
 (block_height)
] @constant.builtin

(free_function_call
 (locator
	(identifier) @function))

(record_type
 (locator
	(identifier) @field))

(transition_declaration
  name: (identifier) @function.builtin)

;external transition call
;will be wrong for internal function calls!
(free_function_call
  (identifier) @function)

(function_declaration
  name: (identifier) @function)

(inline_declaration
  name: (identifier) @function.macro)

(method_call
  . (_)
  . (identifier) @method)

(function_parameter
 (identifier) @parameter)

(struct_declaration
  name: (identifier) @field)

(variable_declaration
	(identifier_or_identifiers
		(identifier) @variable))

[ 
  (unsigned_literal) 
  (signed_literal) 
  (field_literal) 
  (product_group_literal) 
  (affine_group_literal) 
  (scalar_literal) 
  (address_literal)
] @number
