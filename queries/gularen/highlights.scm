(chapter) @markup.heading.1
(section) @markup.heading.2
(subsection) @markup.heading.3
(subtitle) @operator

(bullet) @keyword
(index) @number
(v) @diff.plus
(x) @diff.minus

(bold) @markup.strong
(italic) @markup.italic
(monospaced) @string

(line_break) @diff.minus
(page_break) @diff.minus
(dinkus) @keyword

(code_inline) @markup.raw

(code_block (code_content) @markup.raw.block)

(code_lang) @operator
(fence_open) @operator
(fence_close) @operator

(link_label (label) @markup.link.url)
(admon_label) @function
(datetime_content) @string.escape

(exclamation) @operator
(question) @operator
(caret) @operator
(equal) @operator

(angle_open) @operator
(angle_close) @operator
(square_open) @operator
(square_close) @operator
(curly_open) @operator
(curly_close) @operator
(paren_open) @operator
(paren_close) @operator
(slash) @operator

(comment) @comment
(annotation) @comment
(annotation_key) @annotation
(annotation_colon) @operator
(annotation_value) @string

(footnote_desc (resource) @function)
(resource) @markup.link.url
(account_tag) @markup.link.url
(hash_tag) @markup.link.url

(blockquote) @markup.quote
