[
  (anonymous_function)
  (binding)
  (def)
  (let)
] @local.scope

(anonymous_argument
  (var) @local.definition.parameter)

(labeled_argument
  label: (var) @local.definition.parameter)

(binding
  defined: (var) @local.definition.var)

(def
  defined: (var) @local.definition.var)

(let
  defined: (var) @local.definition.var)

(meth_pattern
  (var) @local.definition.var)

(list_pattern
  (var) @local.definition.var)

(tuple_pattern
  (var) @local.definition.var)

(spread
  (var) @local.definition.var)

(var) @local.reference
