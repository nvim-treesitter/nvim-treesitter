;; All scopes: comments
(comment) @comment @spell

;; Code
;; punctuation
["#"] @punctuation.special
[":" ";" ","] @punctuation.delimiter
["(" ")" "{" "}"] @punctuation.bracket
;; TODO: context blocks?
[ "[" "]" ] @punctuation.bracket
;; operators
[
 "-"
 "+"
 "*"
 "/"

 "=="
 "!="
 "<"
 "<="
 ">"
 ">="

 "="

 "in"
 "and"
 "or"
 "not"
] @operator
;; keywords
[ "import" "include" ] @include
[ "let" "set" "show" ] @keyword
;; control flow
[ "for" "while" "break" "continue" ] @repeat
[ "if" "else" ] @conditional
;; special case: #for (ident) in (expr)
(for "in" @repeat)
;; type literals
(number) @number
(string) @string
(bool) @boolean
;; identifiers
(builtin) @namespace
(ident) @identifier
;; name-value pairs
(tagged
  field: (ident)) @field
;; function definitions, calls, etc.
;; TODO: support for functions such as #calc.cos, tree view appears as
;; (call)
;;  item: (field)
;;   (builtin)
;    field: (ident)
(call
  item: (builtin)) @function.builtin
(call
  item: (ident)) @function.call

;; Text
(heading) @text.title
(text) @text
(strong) @text.strong
(emph) @text.emph
(url) @text.uri
;; code blocks
(raw_span) @text.literal
(raw_span
  (blob)) @text.literal
(raw_blck) @text.literal
(raw_blck
  (blob)) @text.literal.block
;; refs and labels
(label) @text.reference
(ref) @text.reference

;; Math
(math) @text.math
