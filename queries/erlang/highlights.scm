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
  "throw"
] @exception
;;; module define
[
  "module"
  "export"
] @include
;;; operator
[
  ":"
  ":="
  "?"
  "!"
  "-"
  "+"
  "="
  "->"
  "=>"
  "|"
  ;;;TODO
  "$"
 ] @operator

(comment) @comment
(string) @string
(var) @variable

(module_attribute
  (atom) @namespace
)
;;; expr_function_call
(call
  expr: [(atom) (remote) (var)] @function.call 
)

;;; Parenthesized expression: (SomeFunc)(), only highlight the parens
(call
  expr: (paren_expr ("(") @function.call (_) (")") @function.call)
)

;;; map
(map_expr
 (map_field [
   (atom)
   (var)
 ] @variable)
)

(map_expr_update
 (map_field [
   (atom)
   (variable)
 ] @variable)
)

(tuple (atom) @variable)
(pat_tuple ( pattern (atom) @variable))

;;; case
(cr_clause
  pat: (atom) @variable
)
(cr_clause
  body: (atom) @variable
)

;;; function
(external_fun
  module: (atom) @attribute
)
(external_fun
  fun: (atom) @function
)
(internal_fun
  fun: (atom) @function
)
