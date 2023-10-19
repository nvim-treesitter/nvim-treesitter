(identifier) @variable 

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
 "transition"
 "function"
 "inline"
] @keyword.function

"import" @include

"return" @keyword.return

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

(program_declaration
  (program_id) @string.special)

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

(return_arrow) @punctuation.delimiter

(transition_declaration
  . name: (identifier) @function.bultin)

;external transition call
;will be wrong for internal function calls!
(free_function_call
  (identifier) @function)

(function_declaration
  . name: (identifier) @function)

(inline_declaration
  . name: (identifier) @function)

(method_call
  . (_)
  . (identifier) @method)

(function_parameter
 (identifier) @parameter)

(struct_declaration
  name: (identifier) @field)

[ 
  (unsigned_literal) 

  (signed_literal) 

  (field_literal) 

  (product_group_literal) 

  (affine_group_literal) 

  (scalar_literal) 

  (address_literal)
] @number

;address with wrong length or characters -> error
((identifier) @_address
 (#match? @_address "^aleo1.*$")
 (#not-match? @_address "aleo1[a-z0-9]{58}"
 )) @punctuation.delimiter 


;external transition call locator if "leo" extension used -> okay
(struct_component_expression
  (_)
  (identifier) @_leo 
  (#eq? @_leo "leo")
) @string

;external transition call locator if "leo" is used as extension -> okay
(locator
  (program_id
    name: (identifier)
    extension: (identifier) @_ext
    (#eq? @_ext "leo")
  ) @string
) 

;external transition call locator if NOT "leo" is used as extension -> error
(locator
  (program_id
    name: (identifier)
    extension: (identifier) @_ext
    (#not-eq? @_ext "leo")
  ) @punctuation.delimiter
) 

;import declaration filename if "leo" is used as extension -> okay
(import_declaration
  (program_id
    name: (identifier)
    extension: (identifier) @_ext
    (#eq? @_ext "leo")
  ) @string
)
