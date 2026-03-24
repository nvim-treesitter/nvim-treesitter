; inherits: html

[
  (if_block)
  (each_block)
  (await_block)
  (key_block)
  (snippet_block)
] @indent.begin

(block_end
  (block_close) @indent.end)

[
  (block_end)
  (else_if_clause)
  (else_clause)
  (await_branch)
] @indent.branch
