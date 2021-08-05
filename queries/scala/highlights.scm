;; keywords

[
  "abstract"
  "case"
  "class"
  "do"
  "extends"
  "final"
  "finally"
  "forSome"
  "implicit"
  "lazy"
  "macro"
  "new"
  "null"
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
  "yield"
] @keyword

;; special keywords

[
  "else"
  "if"
  "match"
] @conditional

[
  "for" 
  "while"
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
