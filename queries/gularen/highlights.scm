(text) @spell

(section) @markup.heading.1

(subsection) @markup.heading.2

(subsubsection) @markup.heading.3

(subtitle) @markup.heading.4

(bullet) @markup.list

(index) @number

(x) @markup.list.checked

(bold) @markup.strong

(italic) @markup.italic

(highlighted) @diff.plus

[
  (line_break)
  (page_break)
  (dinkus)
] @punctuation.special

(code_inline) @markup.raw

(code_block
  (code_block_content) @markup.raw.block)

(code_block_label) @label

([
  (fence_open)
  (fence_close)
] @markup.raw.block
  (#set! conceal ""))

(link_labeled
  (label) @markup.link.url)

(admon_label) @function

(datetime_content) @string.special

[
  (exclamation)
  (question)
  (caret)
] @punctuation.special

[
  (angle_open)
  (angle_close)
  (square_open)
  (square_close)
  (paren_open)
  (paren_close)
] @punctuation.bracket

(slash) @punctuation.delimiter

(comment) @comment @spell

(annotation) @comment.documentation

(annotation_key) @attribute

(annotation_colon) @punctuation.delimiter

(annotation_value) @string

(resource) @markup.link.url

(account_tag) @markup.link.url

(hash_tag) @markup.link.url

(blockquote) @markup.quote
