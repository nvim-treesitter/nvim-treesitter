([
  (line_comment)
  (block_comment)
  (nesting_block_comment)
 ] @injection.content
 (#set! injection.language "comment")) 

((token_string_tokens) @injection.content
 (#set! injection.language "d"))
