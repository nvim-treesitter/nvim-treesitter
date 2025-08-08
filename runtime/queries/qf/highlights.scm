[
  "|"
  "-"
] @punctuation.delimiter

(filename) @string.special.path

(row
  [
    (value)
    (from)
    (to)
  ] @number)

"col" @keyword

(col
  [
    (value)
    (from)
    (to)
  ] @number)

((item_type) @comment.error
  (#eq? @comment.error "error"))

((item_type) @comment.warning
  (#eq? @comment.warning "warning"))

((item_type) @comment.note
  (#eq? @comment.note "note"))

((code_block) @markup.raw.block
  (#set! priority 90))

(code_block
  (language_delimiter) @markup.raw.block
  (#set! conceal ""))
