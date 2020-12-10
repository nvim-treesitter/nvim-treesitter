;; Forked from tree-sitter-go
;; Copyright (c) 2014 Max Brunsfeld (The MIT License)

;;
; Identifiers

(type_identifier) @type
(field_identifier) @property
(identifier) @variable
(package_identifier) @variable

(parameter_declaration (identifier) @parameter)
(variadic_parameter_declaration (identifier) @parameter)

((identifier) @constant
 (#eq? @constant "_"))

((identifier) @constant
 (#vim-match? @constant "^[A-Z][A-Z\\d_]+$"))

; Function calls

(call_expression
  function: (identifier) @function)

(call_expression
  function: (selector_expression
    field: (field_identifier) @method))

; Function definitions

(function_declaration
  name: (identifier) @function)

(method_declaration
  name: (field_identifier) @method)

; Operators

"--" @operator
"-" @operator
"-=" @operator
":=" @operator
"!" @operator
"!=" @operator
"..." @operator
"*" @operator
"*" @operator
"*=" @operator
"/" @operator
"/=" @operator
"&" @operator
"&&" @operator
"&=" @operator
"%" @operator
"%=" @operator
"^" @operator
"^=" @operator
"+" @operator
"++" @operator
"+=" @operator
"<-" @operator
"<" @operator
"<<" @operator
"<<=" @operator
"<=" @operator
"=" @operator
"==" @operator
">" @operator
">=" @operator
">>" @operator
">>=" @operator
"|" @operator
"|=" @operator
"||" @operator

; Keywords

"break" @keyword
"case" @conditional
"chan" @keyword
"const" @keyword
"continue" @keyword
"default" @keyword
"defer" @keyword
"else" @conditional
"fallthrough" @keyword
"for" @repeat
"func" @keyword
"go" @keyword
"goto" @keyword
"if" @conditional
"import" @include
"interface" @keyword
"map" @keyword
"package" @include
"range" @keyword
"return" @keyword
"select" @keyword
"struct" @keyword
"switch" @conditional
"type" @keyword
"var" @keyword

; Delimiters

"." @punctuation.delimiter
"," @punctuation.delimiter
":" @punctuation.delimiter
";" @punctuation.delimiter

"(" @punctuation.bracket
")" @punctuation.bracket
"{" @punctuation.bracket
"}" @punctuation.bracket
"[" @punctuation.bracket
"]" @punctuation.bracket


; Literals

(interpreted_string_literal) @string
(raw_string_literal) @string
(rune_literal) @string
(escape_sequence) @string.escape

(int_literal) @number
(float_literal) @float
(imaginary_literal) @number

(true) @boolean
(false) @boolean
(nil) @constant.builtin

(comment) @comment

(ERROR) @error
