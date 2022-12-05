;; keywoord

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

((atom) @boolean
  (#any-of? @boolean "true" "false" "True" "False"))
[
 "when"
 "if"
 "case"
 "of"
 "after"
 "end"
] @conditional

;;; module define
;;;[
;;;  "module"
;;;  "export"
;;;] @include
forms: (module_attribute) @include
forms: (compile_options_attribute) @include
;;; operator
[
  "->"
	;;;TODO
 ] @operator

(comment) @comment

(function_clause
  [
    name :(atom) @function.call
])

(tuple
  [
    expr: (atom) @variable
  ]
)
