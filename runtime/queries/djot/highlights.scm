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
] @markup.raw
  (#set! "priority" 90))

; Remove @markup.raw for code with a language spec
(code_block
  .
  (code_block_marker_begin)
  (language)
  (code) @none)

[
  (code_block_marker_begin)
  (code_block_marker_end)
  (raw_block_marker_begin)
  (raw_block_marker_end)
] @punctuation.delimiter

(language) @label

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

(table_caption) @markup.heading

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
  (unchecked) @constant.builtin) @markup.list.unchecked

(list_marker_task
  (checked) @constant.builtin) @markup.list.checked

[
  (ellipsis)
  (en_dash)
  (em_dash)
  (straight_quote)
] @string.special

(frontmatter_marker) @punctuation.delimiter

(emphasis) @markup.italic

(strong) @markup.strong

(emphasis
  (emphasis_begin) @punctuation.delimiter)

(emphasis
  (emphasis_end) @punctuation.delimiter)

(strong
  (strong_begin) @punctuation.delimiter)

(strong
  (strong_end) @punctuation.delimiter)

(highlighted
  [
    "{="
    "=}"
  ] @punctuation.delimiter)

(insert
  [
    "{+"
    "+}"
  ] @punctuation.delimiter)

(delete
  [
    "{-"
    "-}"
  ] @punctuation.delimiter)

(superscript
  [
    "^"
    "{^"
    "^}"
  ] @punctuation.delimiter)

(subscript
  [
    "~"
    "{~"
    "~}"
  ] @punctuation.delimiter)

(verbatim) @markup.raw

[
  (verbatim_marker_begin)
  (verbatim_marker_end)
] @punctuation.delimiter

(math) @markup.math

[
  (math_marker)
  (math_marker_begin)
  (math_marker_end)
] @punctuation.delimiter

(raw_inline) @markup.raw

[
  (raw_inline_attribute)
  (raw_inline_marker_begin)
  (raw_inline_marker_end)
] @punctuation.delimiter

[
  "{"
  "}"
  "!["
  "["
  "]"
  "("
  ")"
  "<"
  ">"
] @punctuation.bracket

(comment) @comment

(class) @type

(identifier) @tag

(key_value
  "=" @operator)

(key_value
  (key) @property)

(key_value
  (value) @string)

[
  (backslash_escape)
  (hard_line_break)
] @string.escape

(link_reference_definition
  ":" @punctuation.special)

(full_reference_link
  (link_text) @markup.link)

(full_reference_link
  (link_label) @markup.link.label)

(collapsed_reference_link
  (link_text) @markup.link)

(collapsed_reference_link
  (link_text) @markup.link.label)

(inline_link
  (link_text) @markup.link)

(full_reference_image
  (link_label) @markup.link.label)

(image_description) @markup.link.label

(link_reference_definition
  (link_label) @markup.link.label)

[
  (autolink)
  (inline_link_destination)
  (link_destination)
  (link_reference_definition)
] @markup.link.url

(footnote
  (reference_label) @markup.link)

(footnote_reference
  (reference_label) @markup.link)

[
  (footnote_marker_begin)
  (footnote_marker_end)
] @punctuation.bracket

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
