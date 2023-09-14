(class_declaration
    body: (class_body) @class.inner) @class.outer

(method_declaration) @function.outer

(method_declaration
    body: (block . "{" . (_) @_start @_end (_)? @_end . "}"
                  (#make-range! "function.inner" @_start @_end)))

(constructor_declaration) @function.outer

(constructor_declaration
    body: (constructor_body . "{" . (_) @_start @_end (_)? @_end . "}"
                             (#make-range! "function.inner" @_start @_end)))

(for_statement
    body: (_)? @loop.inner) @loop.outer

(enhanced_for_statement
    body: (_)? @loop.inner) @loop.outer

(while_statement
    body: (_)? @loop.inner) @loop.outer

(do_statement
    body: (_)? @loop.inner) @loop.outer

(if_statement
    condition: (_ (parenthesized_expression) @conditional.inner)  @conditional.outer)

(if_statement
    consequence: (_)? @conditional.inner
      alternative: (_)? @conditional.inner
        ) @conditional.outer

(switch_expression
    body: (_)? @conditional.inner) @conditional.outer

;; blocks
(block) @block.outer


(method_invocation) @call.outer
(method_invocation
    arguments: (argument_list . "(" . (_) @_start (_)? @_end . ")"
                                (#make-range! "call.inner" @_start @_end)))

;; parameters
(formal_parameters
    "," @_start .
      (formal_parameter) @parameter.inner
       (#make-range! "parameter.outer" @_start @parameter.inner))
(formal_parameters
    . (formal_parameter) @parameter.inner
      . ","? @_end
       (#make-range! "parameter.outer" @parameter.inner @_end))

(argument_list
    "," @_start .
      (_) @parameter.inner
       (#make-range! "parameter.outer" @_start @parameter.inner))
(argument_list
    . (_) @parameter.inner
      . ","? @_end
       (#make-range! "parameter.outer" @parameter.inner @_end))

[
   (line_comment)
     (block_comment)
] @comment.outer
