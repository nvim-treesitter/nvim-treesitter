([
  (c_struct)
  (c_preproc)
  (c_preproc_block)
] @injection.content
  (#set! injection.language "c"))

([
  (line_comment)
  (block_comment)
] @injection.content
  (#set! injection.language "comment"))
