; Keywords

"alias" @keyword
"and" @keyword
"begin" @keyword
"break" @keyword
"case" @conditional
"class" @keyword
"def" @keyword
"do" @keyword
"else" @conditional
"elsif" @conditional
"end" @keyword
"ensure" @keyword
"for" @repeat
"if" @conditional
"in" @keyword
"module" @keyword
"next" @keyword
"or" @keyword
"rescue" @keyword
"retry" @keyword
"return" @keyword
"then" @keyword
"unless" @conditional
"until" @repeat
"when" @conditional
"while" @repeat
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

(class_variable) @label
(instance_variable) @label

((identifier) @constant.builtin
 (match? @constant.builtin "^__(FILE|LINE|ENCODING)__$"))

((constant) @constant.macro
 (match? @constant.macro "^[A-Z\\d_]+$"))

(constant) @constant

(self) @constant.builtin
(super) @constant.builtin

(method_parameters (identifier) @parameter)
(lambda_parameters (identifier) @parameter)
(block_parameters (identifier) @parameter)
(splat_parameter (identifier) @parameter)
(hash_splat_parameter (identifier) @parameter)
(optional_parameter (identifier) @parameter)
(destructured_parameter (identifier) @parameter)
(block_parameter (identifier) @parameter)
(keyword_parameter (identifier) @parameter)

((identifier) @function
 (is-not? local))

; Literals

(string) @string
(bare_string) @string
(bare_symbol) @constant
(subshell) @string
(heredoc_beginning) @constant
(heredoc_body) @string
(heredoc_end) @constant
(symbol) @constant
(regex) @string.regex
(escape_sequence) @string.escape
(integer) @number
(float) @float

(nil) @boolean
(true) @boolean
(false) @boolean

(interpolation
  "#{" @punctuation.bracket
  "}" @punctuation.bracket) @embedded

(comment) @comment

; Operators

"=" @operator
"=>" @operator
"->" @operator
"+" @operator
"-" @operator
"*" @operator
"/" @operator

"," @punctuation.delimiter
";" @punctuation.delimiter
"." @punctuation.delimiter

"(" @punctuation.bracket
")" @punctuation.bracket
"[" @punctuation.bracket
"]" @punctuation.bracket
"{" @punctuation.bracket
"}" @punctuation.bracket
"%w(" @punctuation.bracket
"%i(" @punctuation.bracket

(ERROR) @error
