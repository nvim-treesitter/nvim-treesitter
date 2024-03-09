(chapter) @markup.heading.1

(section) @markup.heading.2

(subsection) @markup.heading.3

(subtitle) @markup.heading.4

(bullet) @markup.list

(index) @number

(v) @markup.list.checked

(x) @markup.list.unchecked.cancelled

(bold) @markup.strong

(italic) @markup.italic

(monospaced) @markup.raw

[
  (line_break)
  (page_break)
] @punctuation.special.break

(dinkus) @punctuation.special.thematic

(code_inline) @markup.raw.inline

(code_block
  (code_content) @markup.raw.block)

(code_lang) @label.lang

([
  (fence_open)
  (fence_close)
] @markup.raw.block
  (#set! conceal ""))

(link_label
  (label) @markup.link.url)

(admon_label) @function.builtin

(datetime_content) @string.special

(exclamation) @operator

(question) @operator

(caret) @operator

(equal) @operator

[
  (exclamation)
  (question)
  (caret)
  (equal)
] @punctuation.special

[
  (angle_open)
  (angle_close)
  (square_open)
  (square_close)
  (curly_open)
  (curly_close)
  (paren_open)
  (paren_close)
] @punctuation.bracket

(slash) @punctuation.delimiter

(comment) @comment @spell

(annotation) @comment.documentation @spell

(annotation_key) @attribute

(annotation_colon) @punctuation.delimiter

(annotation_value) @string

(footnote_desc
  (resource) @function)

(resource) @markup.link.url

(account_tag) @markup.link.url

(hash_tag) @markup.link.url

(blockquote) @markup.quote
