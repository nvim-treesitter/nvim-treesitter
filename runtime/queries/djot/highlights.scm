(heading1) @markup.heading.1

(heading2) @markup.heading.2

(heading3) @markup.heading.3

(heading4) @markup.heading.4

(heading5) @markup.heading.5

(heading6) @markup.heading.6

(thematic_break) @string.special

[
  (div_marker_begin)
  (div_marker_end)
] @punctuation.delimiter

([
  (code_block)
  (raw_block)
  (frontmatter)
] @markup.raw.block
  (#set! "priority" 90))

; Remove @markup.raw for code with a language spec
(code_block
  .
  (code_block_marker_begin)
  (language)
  (code) @none
  (#set! "priority" 90))

[
  (code_block_marker_begin)
  (code_block_marker_end)
  (raw_block_marker_begin)
  (raw_block_marker_end)
] @punctuation.delimiter

(language) @attribute

(inline_attribute
  _ @conceal
  (#set! conceal ""))

((language_marker) @punctuation.delimiter
  (#set! conceal ""))

(block_quote) @markup.quote

(block_quote_marker) @punctuation.special

(table_header) @markup.heading

(table_header
  "|" @punctuation.special)

(table_row
  "|" @punctuation.special)

(table_separator) @punctuation.special

(table_caption
  (marker) @punctuation.special)

(table_caption) @markup.italic

[
  (list_marker_dash)
  (list_marker_plus)
  (list_marker_star)
  (list_marker_definition)
  (list_marker_decimal_period)
  (list_marker_decimal_paren)
  (list_marker_decimal_parens)
  (list_marker_lower_alpha_period)
  (list_marker_lower_alpha_paren)
  (list_marker_lower_alpha_parens)
  (list_marker_upper_alpha_period)
  (list_marker_upper_alpha_paren)
  (list_marker_upper_alpha_parens)
  (list_marker_lower_roman_period)
  (list_marker_lower_roman_paren)
  (list_marker_lower_roman_parens)
  (list_marker_upper_roman_period)
  (list_marker_upper_roman_paren)
  (list_marker_upper_roman_parens)
] @markup.list

(list_marker_task
  (unchecked)) @markup.list.unchecked

(list_marker_task
  (checked)) @markup.list.checked

; Colorize `x` in `[x]`
((checked) @constant.builtin
  (#offset! @constant.builtin 0 1 0 -1))

[
  (ellipsis)
  (en_dash)
  (em_dash)
  (quotation_marks)
] @string.special

(list_item
  (term) @type.definition)

; Conceal { and } but leave " and '
((quotation_marks) @string.special
  (#any-of? @string.special "\"}" "'}")
  (#offset! @string.special 0 1 0 0)
  (#set! conceal ""))

((quotation_marks) @string.special
  (#any-of? @string.special "\\\"" "\\'" "{'" "{\"")
  (#offset! @string.special 0 0 0 -1)
  (#set! conceal ""))

[
  (hard_line_break)
  (backslash_escape)
] @string.escape

; Only conceal \ but leave escaped character.
((backslash_escape) @string.escape
  (#offset! @string.escape 0 0 0 -1)
  (#set! conceal ""))

(frontmatter_marker) @punctuation.delimiter

(emphasis) @markup.italic

(strong) @markup.strong

(symbol) @string.special.symbol

(insert) @markup.underline

(delete) @markup.strikethrough

[
  (highlighted)
  (superscript)
  (subscript)
] @string.special

; We need to target tokens specifically because `{=` etc can exist as fallback symbols in
; regular text, which we don't want to highlight or conceal.
(highlighted
  [
    "{="
    "=}"
  ] @punctuation.delimiter
  (#set! conceal ""))

(insert
  [
    "{+"
    "+}"
  ] @punctuation.delimiter
  (#set! conceal ""))

(delete
  [
    "{-"
    "-}"
  ] @punctuation.delimiter
  (#set! conceal ""))

(superscript
  [
    "^"
    "{^"
    "^}"
  ] @punctuation.delimiter
  (#set! conceal ""))

(subscript
  [
    "~"
    "{~"
    "~}"
  ] @punctuation.delimiter
  (#set! conceal ""))

([
  (emphasis_begin)
  (emphasis_end)
  (strong_begin)
  (strong_end)
  (verbatim_marker_begin)
  (verbatim_marker_end)
  (math_marker)
  (math_marker_begin)
  (math_marker_end)
  (raw_inline_attribute)
  (raw_inline_marker_begin)
  (raw_inline_marker_end)
] @punctuation.delimiter
  (#set! conceal ""))

((math) @markup.math
  (#set! "priority" 90))

(verbatim) @markup.raw

((raw_inline) @markup.raw
  (#set! "priority" 90))

(comment
  "%" @comment
  (#set! conceal ""))

(span
  [
    "["
    "]"
  ] @punctuation.bracket)

(inline_attribute
  [
    "{"
    "}"
  ] @punctuation.bracket)

(block_attribute
  [
    "{"
    "}"
  ] @punctuation.bracket)

[
  (class)
  (class_name)
] @type

(identifier) @tag

(key_value
  "=" @operator)

(key_value
  (key) @property)

(key_value
  (value) @string)

(link_text
  [
    "["
    "]"
  ] @punctuation.bracket
  (#set! conceal ""))

(autolink
  [
    "<"
    ">"
  ] @punctuation.bracket
  (#set! conceal ""))

(inline_link
  (inline_link_destination) @markup.link.url
  (#set! conceal ""))

(link_reference_definition
  ":" @punctuation.special)

(full_reference_link
  (link_text) @markup.link)

(full_reference_link
  (link_label) @markup.link.label
  (#set! conceal ""))

(collapsed_reference_link
  "[]" @punctuation.bracket
  (#set! conceal ""))

(full_reference_link
  [
    "["
    "]"
  ] @punctuation.bracket
  (#set! conceal ""))

(collapsed_reference_link
  (link_text) @markup.link)

(collapsed_reference_link
  (link_text) @markup.link.label)

(inline_link
  (link_text) @markup.link)

(full_reference_image
  (link_label) @markup.link.label)

(full_reference_image
  [
    "!["
    "["
    "]"
  ] @punctuation.bracket)

(collapsed_reference_image
  [
    "!["
    "]"
  ] @punctuation.bracket)

(inline_image
  [
    "!["
    "]"
  ] @punctuation.bracket)

(image_description) @markup.italic

(image_description
  [
    "["
    "]"
  ] @punctuation.bracket)

(link_reference_definition
  [
    "["
    "]"
  ] @punctuation.bracket)

(link_reference_definition
  (link_label) @markup.link.label)

(inline_link_destination
  [
    "("
    ")"
  ] @punctuation.bracket)

[
  (autolink)
  (inline_link_destination)
  (link_destination)
  (link_reference_definition)
] @markup.link.url

(footnote
  (reference_label) @markup.link.label)

(footnote_reference
  (reference_label) @markup.link.label)

[
  (footnote_marker_begin)
  (footnote_marker_end)
] @punctuation.bracket

(todo) @comment.todo

(note) @comment.note

(fixme) @comment.error

[
  (paragraph)
  (comment)
  (table_cell)
] @spell

[
  (autolink)
  (inline_link_destination)
  (link_destination)
  (code_block)
  (raw_block)
  (math)
  (raw_inline)
  (verbatim)
  (reference_label)
  (class)
  (class_name)
  (identifier)
  (key_value)
  (frontmatter)
] @nospell

(full_reference_link
  (link_label) @nospell)

(full_reference_image
  (link_label) @nospell)
