(source_file
  ((string_literal) @markdown
                    (#lua-match? @markdown "^\"\"\"")
                    (#offset! @markdown 0 3 0 -3)))

[
  (line_comment)
  (block_comment)
] @comment
