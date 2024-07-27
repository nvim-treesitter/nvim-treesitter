(parenthesis) @local.scope

(anonymous_function) @local.scope

(object) @local.scope

(field) @local.scope

(local_bind) @local.scope

(field
  function: (fieldname
    (id) @local.definition.function)
  (#set! definition.function.scope "parent"))

(bind
  (id) @local.definition.var)

(bind
  function: (id) @local.definition.function)

(param
  (id) @local.definition.parameter)

(id) @local.reference

;(fieldname (id) (#is-not? local)) ; (#is-not?) not supported yet
