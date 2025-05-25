"|" @punctuation.delimiter

" col " @keyword

[
  (row)
  (col)
] @number

(filename) @string.special.path

((code_block) @markup.raw.block
  (#set! priority 90))

(code_block
  (language_delimiter) @markup.raw.block
  (#set! conceal ""))

((item_type) @comment.error
  (#eq? @comment.error "error"))

((item_type) @comment.warning
  (#eq? @comment.warning "warning"))

((item_type) @comment.note
  (#eq? @comment.note "note"))
