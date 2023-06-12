(block
  ")" @indent.branch .) @indent.begin

(if_block) @indent.begin

(if_block
  (block)) @indent.dedent

(else_block) @indent.branch

(else_block
  (if_block) @indent.dedent)

(while_block
  (command_expression)) @indent.auto

(repeat_block
  (command_expression)) @indent.auto

(comment) @indent.auto
