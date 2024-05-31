(title0) @markup.heading.1

(title1) @markup.heading.2

(title2) @markup.heading.3

(title3) @markup.heading.4

(title4) @markup.heading.5

(title5) @markup.heading.6

(email) @markup.link.url @markup.link

(author_line
  ";" @punctuation.delimiter)

(revision_line
  "," @punctuation.delimiter
  ":" @punctuation.delimiter)

[
  (firstname)
  (middlename)
  (lastname)
] @attribute

(revnumber) @number

(revdate) @string.special

(revremark) @string

(table_block_marker) @punctuation.special

(table_cell_attr) @attribute

(table_cell
  "|" @punctuation.special)

[
  (breaks)
  (hard_wrap)
  (quoted_block_md_marker)
  (quoted_paragraph_marker)
  (open_block_marker)
  (listing_block_marker)
  (literal_block_marker)
  (passthrough_block_marker)
  (quoted_block_marker)
  (ntable_block_marker)
  (anno_marker)
] @punctuation.special

(ntable_cell
  "!" @punctuation.special)

(task_list_marker_unchecked) @markup.list.unchecked

(task_list_marker_checked) @markup.list.checked

[
  (list_marker_star)
  (list_marker_hyphen)
  (list_marker_dot)
  (list_marker_digit)
  (list_marker_geek)
  (list_marker_alpha)
] @markup.list

[
  (line_comment)
  (comment_block)
] @comment @spell

[
  (document_attr_marker)
  (element_attr_marker)
] @punctuation.delimiter

(document_attr
  (attr_name) @property)

(element_attr
  (attr_value) @attribute)

(block_title
  (block_title_marker) @punctuation.special) @attribute

(ident_block) @markup.raw.block

(anno_list_marker) @punctuation.special

(delimited_block) @punctuation.bracket

(block_macro
  (block_macro_name) @keyword
  "::" @punctuation.delimiter
  (target)? @markup.link
  "[" @punctuation.bracket
  "]" @punctuation.bracket)

(block_macro_attr
  (name) @attribute
  "=" @operator
  (value) @variable.parameter)

(admonition
  (admonition_important) @comment.error
  ":" @comment.error)

(admonition
  (admonition_warning) @comment.warning
  ":" @comment.warning)

(admonition
  (admonition_caution) @comment.warning
  ":" @comment.warning)

(admonition
  (admonition_note) @comment.note
  ":" @comment.note)

(admonition
  (admonition_tip) @comment.note
  ":" @comment.note)

((section_block
  (element_attr
    (element_attr_marker) @comment.note
    (attr_value) @attribute @comment.note
    (element_attr_marker) @comment.note)
  (delimited_block
    (delimited_block_marker) @comment.note
    (delimited_block_marker) @comment.note))
  (#any-of? @attribute "NOTE" "TIP"))

((section_block
  (element_attr
    (element_attr_marker) @comment.warning
    (attr_value) @attribute @comment.warning
    (element_attr_marker) @comment.warning)
  (delimited_block
    (delimited_block_marker) @comment.warning
    (delimited_block_marker) @comment.warning))
  (#any-of? @attribute "CAUTION" "WARNING"))

((section_block
  (element_attr
    (element_attr_marker) @comment.error
    (attr_value) @attribute @comment.error
    (element_attr_marker) @comment.error)
  (delimited_block
    (delimited_block_marker) @comment.error
    (delimited_block_marker) @comment.error))
  (#eq? @attribute "IMPORTANT"))

((element_attr
  (element_attr_marker)
  (attr_value) @_attr
  (element_attr_marker))
  (listing_block
    (listing_block_body) @markup.raw.block)
  (#not-lua-match? @_attr "^[^,]*,%s*(%w+)")
  (#not-any-of? @_attr
    "a2s" "barcode" "blockdiag" "bpmn" "bytefield" "d2" "dbml" "diagrams" "ditaa" "dpic" "erd"
    "gnuplot" "graphviz" "lilypond" "meme" "mermaid" "msc" "nomnoml" "pikchr" "plantuml" "shaape"
    "smcat" "structurizr" "svgbob" "symbolator" "syntrax" "tikz" "umlet" "vega" "wavedrom"))
