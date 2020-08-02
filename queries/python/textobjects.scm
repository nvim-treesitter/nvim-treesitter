(function_definition
  body: (block)? @function.inner) @function.outer

(decorated_definition
  (function_definition) @function.outer) @function.outer.start

(class_definition
  body: (block)? @class.inner) @class.outer

(decorated_definition
  (class_definition) @class.outer) @class.outer.start

(while_statement
  body: (block)? @loop.inner) @loop.outer

(for_statement
  body: (block)? @loop.inner) @loop.outer

(if_statement
  alternative: (_ (_) @conditional.inner)?) @conditional.outer

(if_statement
  consequence: (block)? @conditional.inner)

(if_statement
  condition: (_) @conditional.inner)

(_ (block) @block.inner) @block.outer
(comment) @comment.outer

(block (_) @statement.outer)

(call) @call.outer
(call (_) @call.inner)

;; Parameters
(parameters
  [(identifier)
   (tuple)
   (typed_parameter)
   (default_parameter)
   (typed_default_parameter)
   (list_splat)
   (dictionary_splat)] @parameter.inner)

(lambda_parameters
  [(identifier)
   (tuple)
   (typed_parameter)
   (default_parameter)
   (typed_default_parameter)
   (list_splat)
   (dictionary_splat)] @parameter.inner)

; TODO: exclude comments using the future negate syntax from tree-sitter
(argument_list (_) @parameter.inner)
