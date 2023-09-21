[(anonymous_function) (binding) (def) (let)] @scope

(anonymous_argument (var) @local.parameter)
(labeled_argument label: (var) @local.parameter)

(binding
  defined: (var) @local.var)
(def defined: (var) @local.var)
(let defined: (var) @local.var)
(meth_pattern (var) @local.var)
(list_pattern (var) @local.var)
(tuple_pattern (var) @local.var)
(spread (var) @local.var)

(var) @reference
