; CREDITS @stumash (stuart.mashaal@gmail.com)

;; variables

(
  (identifier) @variable.builtin
  (#match? @variable.builtin "^this$")
)

;; method calls

; method definition
(class_definition
  body: (template_body
    (function_definition
      name: (identifier) @method)))
(object_definition
  body: (template_body
    (function_definition
      name: (identifier) @method)))
(trait_definition
  body: (template_body
    (function_definition
      name: (identifier) @method)))

; method invocation
(call_expression
  function: (field_expression
    field: (identifier) @method))

(
  (identifier) @function.builtin
  (#match? @function.builtin "^super$")
)

;; keywords

[
  "abstract"
  "case"
  "class"
  "extends"
  "final"
  "finally"
;; `forSome` existential types not implemented yet
  "implicit"
  "lazy"
;; `macro` not implemented yet
  "object"
  "override"
  "package"
  "private"
  "protected"
  "sealed"
  "trait"
  "type"
  "val"
  "var"
  "with"
] @keyword

(null_literal) @keyword

;; special keywords

"new" @keyword.operator

[
  "else"
  "if"
  "match"
] @conditional

[
  "do"
  "for"
  "while"
  "yield"
] @repeat

"def" @keyword.function

"import" @include

[
  "try"
  "catch"
  "throw"
] @exception

"return" @keyword.return

;; `case` is a conditional keyword in case_block

(case_block
  (case_clause ("case") @conditional))
