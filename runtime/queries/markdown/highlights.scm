;From MDeiml/tree-sitter-markdown & Helix
(setext_heading
  (paragraph) @markup.heading.1
  (setext_h1_underline) @markup.heading.1.marker)

(setext_heading
  (paragraph) @markup.heading.2
  (setext_h2_underline) @markup.heading.2.marker)

(atx_heading
  (atx_h1_marker) @markup.heading.1.marker
  (inline) @markup.heading.1)

(atx_heading
  (atx_h2_marker) @markup.heading.2.marker
  (inline) @markup.heading.2)

(atx_heading
  (atx_h3_marker) @markup.heading.3.marker
  (inline) @markup.heading.3)

(atx_heading
  (atx_h4_marker) @markup.heading.4.marker
  (inline) @markup.heading.4)

(atx_heading
  (atx_h5_marker) @markup.heading.5.marker
  (inline) @markup.heading.5)

(atx_heading
  (atx_h6_marker) @markup.heading.6.marker
  (inline) @markup.heading.6)

(info_string) @label

(pipe_table_header
  (pipe_table_cell) @markup.heading)

(pipe_table_header
  "|" @punctuation.special)

(pipe_table_row
  "|" @punctuation.special)

(pipe_table_delimiter_row
  "|" @punctuation.special)

(pipe_table_delimiter_cell) @punctuation.special

; Code blocks (conceal backticks and language annotation)
(indented_code_block) @markup.raw.block

(fenced_code_block
  (fenced_code_block_delimiter) @markup.raw.block
  (#set! "priority" 90)
  (#set! conceal ""))

(fenced_code_block
  (info_string
    (language) @markup.raw.block
    (#set! conceal "")))

(link_destination) @markup.link.url

[
  (link_title)
  (link_label)
] @markup.link.label

[
  (list_marker_plus)
  (list_marker_minus)
  (list_marker_star)
  (list_marker_dot)
  (list_marker_parenthesis)
] @markup.list

; NOTE: The following has been commented out due to issues with spaces in the
; list marker nodes generated by the parser. If those spaces ever get captured
; by a different node (e.g. block_continuation) we can safely readd these
; conceals.
; ;; Conceal bullet points
; ([(list_marker_plus) (list_marker_star)]
;   @punctuation.special
;   (#offset! @punctuation.special 0 0 0 -1)
;   (#set! conceal "•"))
; ([(list_marker_plus) (list_marker_star)]
;   @punctuation.special
;   (#any-of? @punctuation.special "+" "*")
;   (#set! conceal "•"))
; ((list_marker_minus)
;   @punctuation.special
;   (#offset! @punctuation.special 0 0 0 -1)
;   (#set! conceal "—"))
; ((list_marker_minus)
;   @punctuation.special
;   (#eq? @punctuation.special "-")
;   (#set! conceal "—"))
(code_fence_content) @none

(thematic_break) @punctuation.special

(task_list_marker_unchecked) @markup.list.unchecked

(task_list_marker_checked) @markup.list.checked

((block_quote) @markup.quote
  (#set! "priority" 90))

[
  (block_continuation)
  (block_quote_marker)
] @punctuation.special

(backslash_escape) @string.escape

(inline) @spell
