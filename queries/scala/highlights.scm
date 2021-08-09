;; keywords

;; `forSome` existential types not implemented yet
;; `macro` not implemented yet

[
  "abstract"
  "case"
  "class"
  "extends"
  "final"
  "finally"
  "implicit"
  "lazy"
  "new"
  "object"
  "override"
  "package"
  "private"
  "protected"
  "sealed"
  "super"
  "this"
  "trait"
  "type"
  "val"
  "var"
  "with"
] @keyword

(null_literal) @keyword

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
  (case_clause ("case") @conditional)
)
