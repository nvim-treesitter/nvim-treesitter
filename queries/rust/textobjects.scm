;; functions
(function_item
  (_) @function.inner) @function.outer

;; quantifies as class(es)
(struct_item
  (_) @class.inner) @class.outer

(enum_item
  (_) @class.inner) @class.outer

(union_item
  (_) @class.inner) @class.outer

(trait_item
  (_) @class.inner) @class.outer

(impl_item
  (_) @class.inner) @class.outer

;; conditionals
(if_expression
  alternative: (_ (_)? @conditional.inner)?
  ) @conditional.outer

(if_expression
  alternative: (block)? @conditional.inner)

(if_expression
  condition: (_) @conditional.inner)

(if_expression
  consequence: (block)? @conditional.inner)

(match_arm
  (_)) @conditional.inner

(match_expression
  (match_arm)?
  ) @conditional.outer

(if_let_expression
  consequence: (block)?
  @conditional.inner) @conditional.outer

(if_let_expression
  alternative: (block)? @conditional.inner)

(if_let_expression
  condition: (_) @conditional.inner)

;; loops
(loop_expression
  (_)? @loop.inner) @loop.outer

(while_expression
  (_)? @loop.inner) @loop.outer

(while_let_expression
  (_)? @loop.inner) @loop.outer

(for_expression
  body: (block)? @loop.inner) @loop.outer

;; blocks
(_ (block) @block.inner) @block.outer
(unsafe_block (_)? @block.inner) @block.outer

;; calls
(call_expression (_)? @call.inner) @call.outer

;; statements
(block (_) @statement.outer)
