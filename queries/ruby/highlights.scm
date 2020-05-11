; Keywords

"alias" @keyword
"and" @keyword
"begin" @keyword
"break" @keyword
"case" @keyword
"class" @keyword
"def" @keyword
"do" @keyword
"else" @keyword
"elsif" @keyword
"end" @keyword
"ensure" @keyword
"for" @keyword
"if" @keyword
"in" @keyword
"module" @keyword
"next" @keyword
"or" @keyword
"rescue" @keyword
"retry" @keyword
"return" @keyword
"then" @keyword
"unless" @keyword
"until" @keyword
"when" @keyword
"while" @keyword
"yield" @keyword

((identifier) @keyword
 (match? @keyword "^(private|protected|public)$"))

; Function calls

((identifier) @function
 (eq? @function "require"))

"defined?" @function

(call
  receiver: (constant) @constant)
(method_call
  receiver: (constant) @constant)
(call
  method: (identifier) @function)
(method_call
  method: (identifier) @function)
(call
  method: (constant) @function)
(method_call
  method: (constant) @function)

; Function definitions

(alias (identifier) @function)
(setter (identifier) @function)
(method name: (identifier) @function)
(method name: (constant) @constant)
(class name: (constant) @constant)
(singleton_method name: (identifier) @function)
(singleton_method name: (constant) @constant)

; Identifiers

(class_variable) @Identifier
(instance_variable) @Identifier

((identifier) @constant
 (match? @constant "^__(FILE|LINE|ENCODING)__$"))

((constant) @constant
 (match? @constant "^[A-Z\\d_]+$"))

(constant) @constant

(self) @constant
(super) @Identifier

(method_parameters (identifier) @Type)
(lambda_parameters (identifier) @Type)
(block_parameters (identifier) @Type)
(splat_parameter (identifier) @Type)
(hash_splat_parameter (identifier) @Type)
(optional_parameter (identifier) @Type)
(destructured_parameter (identifier) @Type)
(block_parameter (identifier) @Type)
(keyword_parameter (identifier) @Type)

((identifier) @function
 (is-not? local))

; Literals

(string) @string
(bare_string) @string
(bare_symbol) @constant
(subshell) @string
(heredoc_beginning) @Delimiter
(heredoc_body) @string
(heredoc_end) @Delimiter
(symbol) @constant
(regex) @string
(escape_sequence) @Special
(integer) @number
(float) @number

(nil) @Identifier
(true) @Identifier
(false) @Identifier

(interpolation
  "#{" @Delimiter
  (identifier) @Identifier
  "}" @Delimiter) @embedded

(comment) @comment

; Operators

"=" @operator
"=>" @operator
"->" @operator
"+" @operator
"-" @operator
"*" @operator
"/" @operator

"," @Normal
";" @Normal
"." @Normal

"(" @Normal
")" @Normal
"[" @Normal
"]" @Normal
"{" @Normal
"}" @Normal
"%w(" @Normal
"%i(" @Normal
