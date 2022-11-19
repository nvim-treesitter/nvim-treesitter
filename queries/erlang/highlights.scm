;; keyword
[
  "fun"
  "div"
] @keyword

;; bracket
[
  "("
  ")"
  "{"
  "}"
  "["
  "]"
  "#"
] @punctuation.bracket

;;; operator
[
  ":"
  ":="
  "!"
  "-"
  "+"
  "="
  "->"
  "=>"
  "|"
 ] @operator

;;; Comparisons
[
  "=="
  "=:="
  "=/="
  "=<"
  ">="
  "<"
  ">"
] @operator ;; .comparison

[
  ","
  "."
  ";"
] @punctuation

[
  "record"
] @attribute

;; conditional
[
  "receive"
  "if"
  "case"
  "of"
  "when"
  "after"
  "end"
] @conditional

[
  "catch"
  "try"
] @exception
((atom) @exception (#any-of? @exception "error" "throw" "exit"))

((atom) @boolean (#any-of? @boolean "true" "false"))

;; Macros
(macro_call_expr
  "?" @macro
  name: (_) @macro
) @constant.macro

;; Preprocessor
(pp_define) @define
[(pp_include) (pp_include_lib)] @include
(_preprocessor_directive) @preprocessor

;;; module define
[
  "module"
  "export"
  "export_type"
  "include"
  "include_lib"
  "behaviour"
  "behavior"
] @include

;; Records
(record_field_expr _ @structure) @structure
(record_field_name _ @structure) @structure
(record_name name: _ @structure) @structure
(record_decl name: _ @structure)
(record_field name: _ @structure ty: _ @type)

;; Type alias
(type_alias "type" @type.definition)
(spec "spec" @type.definition)

(comment) @comment
[(string) (binary)] @string

(module_attribute
  (atom) @namespace
)
;;; expr_function_call
(call expr: [(atom) (remote) (var)] @function)

;;; Parenthesized expression: (SomeFunc)(), only highlight the parens
(call
  expr: (paren_expr "(" @function ")" @function)
)

;;; function
(external_fun) @function
(internal_fun fun: (atom) @function)
(function_clause name: (atom) @function)

;;; attributes
(attr_name name: (atom) @keyword)

(var) @variable
(atom) @constant
(integer) @number
(float) @float
