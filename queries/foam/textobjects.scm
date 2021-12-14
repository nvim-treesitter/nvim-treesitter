(dict) @class.outer
((dict_core) @class.inner)
((key_value value: _? @_start (_)* _? @parameter.inner)
    (#make-range! "function.inner" @_start @parameter.inner)) @function.outer
(code (_)* @class.inner) @class.outer
((comment) @_start ((comment)+) @_end
 (#make-range! "comment.outer" @_start @_end))
(comment) @comment.inner
