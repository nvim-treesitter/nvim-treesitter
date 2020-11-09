;; Marks

[
  ".."
  "|"
  "--"
  "__"
  ":"
  "::"
  "bullet"
  "adornment"
  (transition)
] @punctuation.special

;; Directives

(directive
  name: (type) @function)

((directive
  name: (type) @include)
 (#match? @include "^include::$"))

((directive
   name: (type) @function.builtin)
 (#vim-match?
  @function.builtin
  ; https://docutils.sourceforge.io/docs/ref/rst/directives.html
  "^(attention|caution|danger|error|hint|important|note|tip|warning|admonition)|(image|figure)|(topic|sidebar|line-block|parsed-literal|code|math|rubric|epigraph|highlights|pull-quote|compound|container)|(table|csv-table|list-table)|(contents|sectnum|section-numbering|header|footer)|(target-notes)|(meta)|(replace|unicode|date)|(raw|class|role|default-role|title|restructuredtext-test-directive)::$"))

;; Blocks

[
  (literal_block)
  (line_block)
  (doctest_block)
] @text.literal

(block_quote
  (attribution)? @text.emphasis) @text.literal

(substitution_definition
  name: (substitution) @constant)

(footnote
  name: (label) @constant)

(citation
  name: (label) @constant)

(target
  name: (name)? @constant
  link: (_) @text.literal)

;; Lists

; Definition lists
(list_item
  (term) @text.strong
  (classifier)? @text.emphasis)

; Field lists
(field (field_name) @constant)

;; Inline markup

(emphasis) @text.emphasis

(strong) @text.strong

(standalone_hyperlink) @text.uri

(role) @function

((role) @function.builtin
 (#vim-match?
  @function.builtin
  ; https://docutils.sourceforge.io/docs/ref/rst/roles.html
  "^:(emphasis|literal|code|math|pep-reference|PEP|rfc-reference|RFC|strong|subscript|sub|superscript|sup|title-reference|title|t|raw):$"))

; Prefix role
((interpreted_text
  (role) @_role
  "interpreted_text" @text.emphasis)
 (#eq? @_role ":emphasis:"))

((interpreted_text
  (role) @_role
  "interpreted_text" @text.strong)
 (#eq? @_role ":strong:"))

; Sufix role
((interpreted_text
  "interpreted_text" @text.emphasis
  (role) @_role)
 (#eq? @_role ":emphasis:"))

((interpreted_text
  "interpreted_text" @text.strong
  (role) @_role)
 (#eq? @_role ":strong:"))

[
 "interpreted_text"
  (literal)
] @text.literal

[
  (inline_target)
  (substitution_reference)
  (footnote_reference)
  (citation_reference)
  (reference)
] @constant

;; Others

(title) @text.title

(comment) @comment
(comment "..") @comment

(ERROR) @error
