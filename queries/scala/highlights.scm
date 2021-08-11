;; method calls

(call_expression
  function: (field_expression
    field: (identifier) @method))

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
  "new"
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

(
  (identifier) @super_keyword
  (#match? @super_keyword "^super$")
) @keyword

(
  (identifier) @this_keyword
  (#match? @this_keyword "^this$")
) @keyword

;; special keywords

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
