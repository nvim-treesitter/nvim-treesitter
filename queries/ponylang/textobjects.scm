;; Queries for navigating using textobjects

; comments
[
  (line_comment)
  (block_comment)
] @comment.inner

(line_comment)+ @comment.outer
(block_comment) @comment.outer

; entities
(entity members: (members)? @class.inner) @class.outer
(object members: (members)? @class.inner) @class.outer

; functions
(method
  body: (block)? @function.inner
) @function.outer
(behavior
  body: (block)? @function.inner
) @function.outer
(constructor
  body: (block)? @function.inner
) @function.outer
(lambda
  body: (block)? @function.inner
) @function.outer

; parameter
(params
  ((_) @parameter.inner . ","? @parameter.outer) @parameter.outer
)
(lambda
  params: ((_) @parameter.inner . ","? @parameter.outer) @parameter.outer
)
(typeargs
  ((_) @parameter.inner . ","? @parameter.outer) @parameter.outer
)
(typeparams
  ((_) @parameter.inner . ","? @parameter.outer) @parameter.outer
)
(arguments
  positional: (positional_args
                ((_) @parameter.inner . ","? @parameter.outer)? @parameter.outer)
  ; TODO: get named args right
  named: (named_args ((_) @parameter.inner . ","? @parameter.outer)? @parameter.outer)
)

; conditionals
(if
    condition: (block) @condition.inner
    if_block: (block) @condition.inner
    (elseif condition: (_) @condition.inner if_block: (block) @condition.inner)*
    else_block: (block)? @condition.inner
) @condition.outer
(ifdef
    condition: (_) @condition.inner
    if_block: (block) @condition.inner
    (elseifdef condition: (_) @condition.inner if_block: (block) @condition.inner)*
    else_block: (block)? @condition.inner
) @condition.outer
(iftype
    condition: (iftype_condition) @condition.inner
    if_block: (block) @condition.inner
    (elseiftype condition: (_) @condition.inner if_block: (block) @condition.inner)*
    else_block: (block)? @condition.inner
) @condition.outer

(match
    match: (block) @condition.inner
    (match_case pattern: (_) @condition.inner body: (block) @condition.inner)
    else_block: (block) @condition.inner
) @condition.outer

; loops
(for) @loop.outer
("for" body: (block) @loop.inner else_block: (block)? @loop.inner)
(while body: (block) @loop.inner) @loop.outer
(repeat body: (block) @loop.inner) @loop.outer

; assignment
(assignment left: (_) @assignment.lhs right: (_) @assignment.rhs @assignment.inner) @assignment.outer
(assignment left: (_) @assignment.inner)

; calls
(call arguments: (arguments) @call.inner) @call.outer

; return
(return (_)? @return.inner) @return.outer

(_ (block) @block.inner) @block.outer
(block (_) @statement.outer)

[
 (integer)
 (float)
 ] @number.inner
;(
;  (entity
;    provides: (type (nominal_type name: (identifier) @_provides))
;    members: (members) @test.inside
;  ) @test.outside
;  (#eq? @_provides "UnitTest")
;)

