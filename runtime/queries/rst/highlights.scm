; Marks
[
  ".."
  "|"
  "--"
  "__"
  ":"
  "::"
  (transition)
] @punctuation.special

"bullet" @markup.list

; Resets for injection
(doctest_block) @none

; Directives
(directive
  name: (type) @function)

(directive
  body: (body
    (arguments) @variable.parameter))

((directive
  name: (type) @keyword.import)
  (#eq? @keyword.import "include"))

(directive
  name: (type) @function.builtin
  (#any-of? @function.builtin
    ; https://docutils.sourceforge.io/docs/ref/rst/directives.html
    "attention" "caution" "danger" "error" "hint" "important" "note" "tip" "warning" "admonition"
    "image" "figure" "topic" "sidebar" "line-block" "parsed-literal" "code" "math" "rubric"
    "epigraph" "highlights" "pull-quote" "compound" "container" "table" "csv-table" "list-table"
    "contents" "sectnum" "section-numbering" "header" "footer" "target-notes" "meta" "replace"
    "unicode" "date" "raw" "class" "role" "default-role" "title" "restructuredtext-test-directive"))

; Blocks
[
  (literal_block)
  (line_block)
] @markup.raw.block

(block_quote
  (attribution)? @markup.italic) @markup.quote

(substitution_definition
  name: (substitution) @constant)

(footnote
  name: (label) @constant)

(citation
  name: (label) @constant)

(target
  name: (name)? @markup.link.label
  link: (_)? @markup.link)

; Lists
; Definition lists
(list_item
  (term) @markup.strong
  (classifier)? @markup.italic)

; Field lists
(field
  (field_name) @constant)

; Inline markup
(emphasis) @markup.italic

(strong) @markup.strong

(standalone_hyperlink) @string.special.url @nospell

(role) @function

((role) @function.builtin
  (#any-of? @function.builtin
    ; https://docutils.sourceforge.io/docs/ref/rst/roles.html
    ":emphasis:" ":literal:" ":code:" ":math:" ":pep-reference:" ":PEP:" ":rfc-reference:" ":RFC:"
    ":strong:" ":subscript:" ":sub:" ":superscript:" ":sup:" ":title-reference:" ":title:" ":t:"
    ":raw:"))

[
  "interpreted_text"
  (literal)
] @markup.raw

; Prefix role
((interpreted_text
  (role) @_role
  "interpreted_text" @markup.italic)
  (#eq? @_role ":emphasis:"))

((interpreted_text
  (role) @_role
  "interpreted_text" @markup.strong)
  (#eq? @_role ":strong:"))

((interpreted_text
  (role) @_role
  "interpreted_text" @none)
  (#eq? @_role ":math:"))

; Suffix role
((interpreted_text
  "interpreted_text" @markup.italic
  (role) @_role)
  (#eq? @_role ":emphasis:"))

((interpreted_text
  "interpreted_text" @markup.strong
  (role) @_role)
  (#eq? @_role ":strong:"))

((interpreted_text
  "interpreted_text" @none
  (role) @_role)
  (#eq? @_role ":math:"))

[
  (inline_target)
  (substitution_reference)
  (footnote_reference)
  (citation_reference)
  (reference)
] @markup.link @nospell

; Others
[
  (title)
  "adornment"
] @markup.heading

(comment) @comment @spell

(comment
  "..") @comment

(directive
  name: (type) @_directive
  body: (body
    (content) @spell
    (#not-any-of? @_directive "code" "code-block" "sourcecode")))

(paragraph) @spell
