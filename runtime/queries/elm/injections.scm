([
  (line_comment) 
  (block_comment)
 ] @injection.content
 (#set! injection.language "comment"))

((glsl_content) @injection.content
 (#set! injection.language "glsl"))
