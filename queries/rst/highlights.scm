; Marks

[
  ".."
  "|"
  "--"
  "__"
  "::"
  "bullet"
  "adornment"
  (transition)
] @punctuation.special

; Directives

(directive
  name: (type) @function)

((directive
  name: (type) @include)
 (#match? @include "^include::$"))

; Blocks

[
  (literal_block)
  (line_block)
  (block_quote)
  (doctest_block)
] @text.literal

(substitution_definition
  name: (substitution) @constant)

(footnote
  name: (label) @constant)

(citation
  name: (label) @constant)

(target
  name: (reference)? @constant
  link: (_) @text.literal)

; Inline markup

(emphasis) @text.emphasis

(strong) @text.strong

(standalone_hyperlink) @text.uri

[
  (interpreted_text)
  (literal)
] @text.literal

[
  (target)
  (substitution_reference)
  (footnote_reference)
  (citation_reference)
  (reference)
] @constant

; Embedded

(doctest_block) @embed
(directive
  body: (body) @embed)

; Others

(title) @text.title

(attribution) @text.emphasis

(comment) @comment
(comment "..") @comment

(ERROR) @error
