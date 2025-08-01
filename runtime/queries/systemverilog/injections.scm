([
  (one_line_comment)
  (block_comment)
] @injection.content
  (#set! injection.language "comment"))

((macro_text) @injection.content
  (#set! injection.language "verilog"))
