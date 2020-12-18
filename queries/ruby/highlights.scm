; Variables
(identifier) @variable
(interpolation
  "#{" @punctuation.special
  "}" @punctuation.special) @none

; Keywords

[
 "alias"
 "begin"
 "break"
 "class"
 "def"
 "do"
 "end"
 "ensure"
 "module"
 "next"
 "rescue"
 "retry"
 "return"
 "then"
 "yield"
 ] @keyword

[
 "and"
 "or"
 "in"
] @keyword.operator

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

(constant) @constant

((identifier) @keyword
 (#vim-match? @keyword "^(private|protected|public)$"))

[
 "rescue"
 "ensure"
 ] @exception

((identifier) @exception
 (#vim-match? @exception "^(fail|raise)$"))

; Function calls

"defined?" @function

(call
   receiver: (constant)? @type
   method: [
            (identifier)
            (constant)
            ] @function
   )

(program
 (call
  (identifier) @include)
 (#vim-match? @include "^(require|require_relative|load)$"))

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

(class name: (constant) @type)
(module name: (constant) @type)
(superclass (constant) @type)

; Identifiers
[
 (class_variable)
 (instance_variable)
 ] @label

((identifier) @constant.builtin
 (#vim-match? @constant.builtin "^__(callee|dir|id|method|send|ENCODING|FILE|LINE)__$"))

((constant) @constant.macro
 (#vim-match? @constant.macro "^[A-Z\\d_]+$"))

[
 (self)
 (super)
 ] @variable.builtin

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
  "#{" @punctuation.special
  "}" @punctuation.special) @embedded

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
