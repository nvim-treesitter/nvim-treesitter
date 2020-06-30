"break" @keyword
"case" @conditional
"const" @keyword
"continue" @repeat
"default" @keyword
"do" @repeat
"else" @conditional
"enum" @keyword
"extern" @keyword
"for" @repeat
"if" @conditional
"inline" @keyword
"return" @keyword
"sizeof" @keyword
"static" @keyword
"struct" @keyword
"switch" @keyword
"typedef" @keyword
"union" @keyword
"volatile" @keyword
"while" @repeat

"#define" @constant.macro
"#else" @keyword
"#endif" @keyword
"#if" @keyword
"#ifdef" @keyword
"#ifndef" @keyword
"#include" @keyword
(preproc_directive) @keyword

"--" @operator
"-" @operator
"->" @operator
"!=" @operator
"*" @operator
"/" @operator
"&" @operator
"&&" @operator
"+" @operator
"++" @operator
"<" @operator
"<=" @operator
"==" @operator
"=" @operator
"~" @operator
">" @operator
">=" @operator
"!" @operator
"||" @operator
(conditional_expression [ "?" ":" ] @conditional)

"-=" @operator
"+=" @operator
"*=" @operator
"/=" @operator
"|=" @operator
"&=" @operator

"." @punctuation.delimiter
";" @punctuation.delimiter
":" @punctuation.delimiter
"," @punctuation.delimiter

"(" @punctuation.bracket
")" @punctuation.bracket
"[" @punctuation.bracket
"]" @punctuation.bracket
"{" @punctuation.bracket
"}" @punctuation.bracket

(string_literal) @string
(system_lib_string) @string

(null) @constant.builtin
(number_literal) @number
(char_literal) @number

(call_expression
  function: (identifier) @function)
(call_expression
  function: (field_expression
    field: (field_identifier) @function))
(function_declarator
  declarator: (identifier) @function)
(preproc_function_def
  name: (identifier) @function.macro)
(preproc_arg)  @function.macro
; TODO (preproc_arg)  @embedded

(field_identifier) @property
(statement_identifier) @label
(type_identifier) @type
(primitive_type) @type
(sized_type_specifier) @type

((identifier) @type
 (#match? @type "^[A-Z]"))

((identifier) @constant
 (#match? @constant "^[A-Z][A-Z0-9_]+$"))

(comment) @comment

;; Parameters
(parameter_list
  (parameter_declaration) @parameter)

(preproc_params
  (identifier)) @parameter

(ERROR) @error
