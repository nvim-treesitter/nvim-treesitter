(variable) @variable

[
 "assert"
 "assert_eq"
 "assert_neq"
 "block"
 "console"
 "in"
 "let"
 "mapping"
 "program"
 "record"
 "self"
 "struct"
] @keyword

[
 "const"
 "in"
] @keyword.operator

[
 "constant"
 "private"
 "public"
 ] @type.qualifier

"self" @variable.builtin

[
 "finalize"
 "function"
 "inline"
 "transition"
] @keyword.function

"import" @include

"return" @keyword.return

(return_arrow) @punctuation.delimiter

"for" @repeat

[ 
  "else"
  "if"
  "then"
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
 (program_id)
 (this_program_id)
] @string.special

;record declaration
(record_declaration (identifier) @field) 

;struct component 
(struct_component_declaration 
  (identifier) @field)

(type) @type

(associated_constant) @constant

[
 (block_height)
 (self_caller)
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
  (identifier) @function.call)

(function_declaration
  name: (identifier) @function)

(inline_declaration
  name: (identifier) @function.macro)

(method_call
  . (_)
  . (identifier) @method.call)

(function_parameter
 (identifier) @parameter)

(struct_declaration
  name: (identifier) @field)

(variable_declaration
	(identifier_or_identifiers
		(identifier) @variable))

[ 
  (address_literal)
  (affine_group_literal) 
  (field_literal) 
  (product_group_literal) 
  (scalar_literal) 
  (signed_literal) 
  (unsigned_literal) 
] @number
