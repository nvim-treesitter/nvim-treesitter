; Keywords

[
 "alias"
 "and"
 "begin"
 "break"
 "class"
 "def"
 "do"
 "end"
 "ensure"
 "in"
 "module"
 "next"
 "or"
 "rescue"
 "retry"
 "return"
 "then"
 "yield"
 ] @keyword

[
 "case"
 "else"
 "elsif"
 "if"
 "unless"
 "when"
 ] @conditional

[
 "for"
 "until"
 "while"
 ] @repeat


((identifier) @keyword
 (#vim-match? @keyword "^(private|protected|public)$"))

; Function calls

((identifier) @function
 (#eq? @function "require"))

"defined?" @function

(call
  [
   receiver: (constant) @constant
   method: [
            (identifier)
            (constant)
            ] @function
   ])

(method_call
  [
   receiver: (constant) @constant
   method: [
            (identifier)
            (constant)
            ] @function
   ])

; Function definitions

(alias (identifier) @function)
(setter (identifier) @function)

(method name: [
               (identifier) @function
               (constant) @constant
               ])

(singleton_method name: [
                         (identifier) @function
                         (constant) @constant
                         ])

(class name: (constant) @constant)

; Identifiers
[
 (class_variable)
 (instance_variable)
 ] @label

((identifier) @constant.builtin
 (#vim-match? @constant.builtin "^__(FILE|LINE|ENCODING)__$"))

((constant) @constant.macro
 (#vim-match? @constant.macro "^[A-Z\\d_]+$"))

(constant) @constant

[
 (self)
 (super)
 ] @constant.builtin

(method_parameters (identifier) @parameter)
(lambda_parameters (identifier) @parameter)
(block_parameters (identifier) @parameter)
(splat_parameter (identifier) @parameter)
(hash_splat_parameter (identifier) @parameter)
(optional_parameter (identifier) @parameter)
(destructured_parameter (identifier) @parameter)
(block_parameter (identifier) @parameter)
(keyword_parameter (identifier) @parameter)

; TODO: Re-enable this once it is supported
; ((identifier) @function
;  (#is-not? local))

; Literals

[
 (string)
 (bare_string)
 (subshell)
 (heredoc_body)
 ] @string

[
 (bare_symbol)
 (heredoc_beginning)
 (heredoc_end)
 (symbol)
 ] @constant

(pair key: (symbol) ":" @constant)
(regex) @string.regex
(escape_sequence) @string.escape
(integer) @number
(float) @float

[
 (nil)
 (true)
 (false)
 ] @boolean

(interpolation
  "#{" @punctuation.bracket
  "}" @punctuation.bracket) @embedded

(comment) @comment

; Operators

[
 "="
 "=>"
 "->"
 "+"
 "-"
 "*"
 "/"
 ] @operator

[
 ","
 ";"
 "."
 ] @punctuation.delimiter

[
 "("
 ")"
 "["
 "]"
 "{"
 "}"
 "%w("
 "%i("
 ] @punctuation.bracket

(ERROR) @error
