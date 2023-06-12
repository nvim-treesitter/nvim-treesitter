; Built-ins {{{
((function_call
  function: (identifier) @function.builtin)
  (#any-of? @function.builtin
    "chr" "concat" "exit" "flush" "getchar" "not" "ord" "print" "print_err" "print_int" "size"
    "strcmp" "streq" "substring"))

((type_identifier) @type.builtin
  (#any-of? @type.builtin "int" "string" "Object"))

((identifier) @variable.builtin
  (#eq? @variable.builtin "self"))

; }}}
; Keywords {{{
[
  "function"
  "primitive"
  "method"
] @keyword.function

[
  "do"
  "for"
  "to"
  "while"
] @keyword.repeat

"new" @keyword.operator

"import" @keyword.import

[
  "array"
  (break_expression)
  "else"
  "end"
  "if"
  "in"
  "let"
  "of"
  "then"
  "type"
  "var"
  "class"
  "extends"
  "_cast"
  "_chunks"
  "_exp"
  "_lvalue"
  "_namety"
] @keyword

; }}}
; Operators {{{
(operator) @operator

[
  ","
  ";"
  ":"
  "."
] @punctuation.delimiter

[
  "("
  ")"
  "["
  "]"
  "{"
  "}"
] @punctuation.bracket

; }}}
; Functions and methods {{{
(function_call
  function: (identifier) @function)

(function_declaration
  name: (identifier) @function)

(primitive_declaration
  name: (identifier) @function)

(method_call
  method: (identifier) @function.method)

(method_declaration
  name: (identifier) @function.method)

(parameters
  name: (identifier) @variable.parameter)

; }}}
; Declarations {{{
(import_declaration
  file: (string_literal) @string.special.path)

; }}}
; Literals {{{
(nil_literal) @constant.builtin

(integer_literal) @number

(string_literal) @string

(escape_sequence) @string.escape

; }}}
; Misc {{{
(comment) @comment @spell

(type_identifier) @type

(field_identifier) @variable.member

(identifier) @variable

; }}}
; vim: sw=2 foldmethod=marker
