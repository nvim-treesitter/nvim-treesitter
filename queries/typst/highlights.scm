; punctuation
"#" @punctuation.special

[
  ":"
  ";"
  ","
] @punctuation.delimiter

; TODO: context blocks for "[" "]"?
[
  "("
  ")"
  "{"
  "}"
  "["
  "]"
] @punctuation.bracket

; operators
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

; keywords
[
  "import"
  "include"
] @keyword.import

[
  "let"
  "set"
  "show"
] @keyword

; control flow
[
  "for"
  "while"
  "break"
  "continue"
] @keyword.repeat

[
  "if"
  "else"
] @keyword.conditional

; special case: #for (ident) in (expr)
(for
  "in" @keyword.repeat)

; type literals
(number) @number

(string) @string

(bool) @boolean

; identifiers
(builtin) @module.builtin

(ident) @constant

; name-value pairs
(tagged
  field: (ident) @variable.member)

; function definitions, calls, etc.
; TODO: support for functions such as #calc.cos, tree view appears as
; (call)
;  item: (field)
;   (builtin)
;    field: (ident)
(call
  item: (builtin) @function.builtin)

(call
  item: (ident) @function.call)

; text
(text) @spell

; TODO: use multi level headings
(heading) @markup.heading

(strong) @markup.strong

(emph) @markup.italic

(url) @markup.link.url

; code blocks
(raw_span) @markup.raw

(raw_blck) @markup.raw

(raw_blck
  (blob) @markup.raw.block)

; refs and labels
(label) @markup.link.label

(ref) @markup.link

; math
(math) @markup.math

; comments
(comment) @comment @spell
