((identifier) @variable (#set! "priority" 95))

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

(comment) @comment

(boolean_literal) @boolean

(ternary_expression
  (_)
  (ternary_if) @conditional
  (_)
  (ternary_else) @conditional
  (_))

(constant_declaration 
  (identifier) @constant
)

;program name if with right extension "aleo" -> okay
(program_declaration
  (program_id 
    name: (identifier) 
    extension: (identifier) @ext (#eq? @ext "aleo")) @string
)

;program name if with not with extension "aleo" -> error
(program_declaration
  (program_id 
    name: (identifier) 
    extension: (identifier) @ext (#not-eq? @ext "aleo")) @punctuation.delimiter
)

;record declaration
(record_declaration (identifier) @structure) 

;struct component 
(struct_component_declaration 
  (identifier) @parameter
  (type)       @type
) 

(type) @type

(associated_constant) @constant

(self_caller) @constant

(block_height) @constant

(transition_declaration
  .
  name: (identifier) @function.bultin
  .
  (function_parameters)*
  .
  (return_arrow) @keyword.return
  .
  (type)
  .
  (block)
  .
)

;external transition call
;will be wrong for internal function calls!
(free_function_call
  (identifier)  @function ) 

(function_declaration
  .
  name: (identifier) @function
  .
  (function_parameters)*
  .
  (return_arrow) @keyword.return
  .
  (type)
  .
  (block)
  .
)

(inline_declaration
  .
  name: (identifier) @function
  .
  (function_parameters)*
  .
  (return_arrow) @keyword.return
  .
  (type)
  .
  (block)
  .
)

(method_call
  (_)
  (identifier) @method
)

(function_parameter
 (identifier) @parameter
) 

(struct_declaration
  name: (identifier) @structure)

(unsigned_literal) @number

(signed_literal) @number

(field_literal) @number

(product_group_literal) @number

(affine_group_literal) @number

(scalar_literal) @number

(boolean_literal) @boolean

(address_literal) @number


;address with wrong length or characters -> error
((identifier) @address
 (#match? @address "^aleo1.*$")
 (#not-match? @address "aleo1[a-z0-9]{58}"
 )) @punctuation.delimiter 


;external transition call locator if "leo" extension used -> okay
(struct_component_expression
  (_)
  (identifier) @leo 
  (#eq? @leo "leo")
) @string

;external transition call locator if "leo" is used as extension -> okay
(locator
  (program_id
    name: (identifier)
    extension: (identifier) @ext
    (#eq? @ext "leo")
  ) @string
) 

;external transition call locator if NOT "leo" is used as extension -> error
(locator
  (program_id
    name: (identifier)
    extension: (identifier) @ext
    (#not-eq? @ext "leo")
  ) @punctuation.delimiter
) 

;import declaration filename if "leo" is used as extension -> okay
(import_declaration
  (program_id
    name: (identifier)
    extension: (identifier) @ext
    (#eq? @ext "leo")
  ) @string
)

;import declaration filename if NOT "leo" used as extension -> error
(import_declaration
  (program_id
    name: (identifier)
    extension: (identifier) @ext
    (#not-eq? @ext "leo")
  ) @punctuation.delimiter
) 


