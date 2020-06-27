
(function_definition
  body: (block)? @function.inner) @function.outer

(class_definition
  body: (block)? @class.inner) @class.outer

(while_statement
  body: (block)? @loop.inner) @loop.outer

(for_statement
  body: (block)? @loop.inner) @loop.outer

(if_statement
  consequence: (block)? @conditional.inner
  alternative: (_ (block) @conditional.inner)?) @conditional.outer

(if_statement
  condition: (_) @conditional.inner)

(_ (block) @block.inner) @block.outer
(comment) @comment.outer

(block (_) @statement.outer)

(call) @call.outer
(call (_) @call.inner)
