((atom) @constant
  (#set! "priority" "90"))

(var) @variable

(char) @character

(integer) @number

(float) @number.float

(comment) @comment @spell

((comment) @comment.documentation
  (#lua-match? @comment.documentation "^[%%][%%]"))

; keyword
[
  "fun"
  "div"
] @keyword

; bracket
[
  "("
  ")"
  "{"
  "}"
  "["
  "]"
  "#"
] @punctuation.bracket

; Comparisons
[
  "=="
  "=:="
  "=/="
  "=<"
  ">="
  "<"
  ">"
] @operator ; .comparison

; operator
[
  ":"
  ":="
  "!"
  ; "-"
  "+"
  "="
  "->"
  "=>"
  "|"
  "?="
] @operator

[
  ","
  "."
  ";"
] @punctuation.delimiter

; conditional
[
  "receive"
  "if"
  "case"
  "of"
  "when"
  "after"
  "begin"
  "end"
  "maybe"
  "else"
] @keyword.conditional

[
  "catch"
  "try"
] @keyword.exception

((atom) @boolean
  (#any-of? @boolean "true" "false"))

; Macros
((macro_call_expr) @constant.macro
  (#set! "priority" 101))

; Preprocessor
(pp_define
  lhs: _ @constant.macro
  (#set! "priority" 101))

(_preprocessor_directive) @keyword.directive
(#set! "priority" 99)

; Attributes
(pp_include) @keyword.import

(pp_include_lib) @keyword.import

(export_attribute) @keyword.import

(export_type_attribute) @type.definition

(export_type_attribute
  types:
    (fa
      fun: _ @type
      (#set! "priority" 101)))

(behaviour_attribute) @keyword.import

(module_attribute
  (atom) @module) @keyword.import

(wild_attribute
  name:
    (attr_name
      name: _ @attribute)) @attribute

; Records
(record_expr) @type

(record_field_expr
  _ @variable.member) @type

(record_field_name
  _ @variable.member) @type

(record_name
  "#" @type
  name: _ @type) @type

(record_decl
  name: _ @type) @type.definition

(record_field
  name: _ @variable.member)

(record_field
  name: _ @variable.member
  ty: _ @type)

; Type alias
(type_alias
  name: _ @type) @type.definition

(spec) @type.definition

[
  (string)
  (binary)
] @string

; expr_function_call
(call
  expr:
    [
      (atom)
      (remote)
      (var)
    ] @function)

(call
  (atom) @keyword.exception
  (#any-of? @keyword.exception "error" "throw" "exit"))

; Parenthesized expression: (SomeFunc)(), only highlight the parens
(call
  expr:
    (paren_expr
      "(" @function.call
      ")" @function.call))

; function
(external_fun) @function.call

(internal_fun
  fun: (atom) @function.call)

(function_clause
  name: (atom) @function)

(fa
  fun: (atom) @function)
