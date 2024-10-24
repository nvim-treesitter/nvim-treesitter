(comment) @comment.inside

[
  (data)
  (record)
  (interface)
  (implementation)
] @class.around

((signature)?
  (function
    (rhs
      (_)) @function.inside)) @function.around

(exp_lambda) @function.around

(data
  (loname) @parameter.inside)

(patterns
  (_) @parameter.inside)
