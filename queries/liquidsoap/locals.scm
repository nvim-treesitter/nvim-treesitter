[(anonymous_function) (binding) (def) (let)] @scope

(anonymous_argument (var) @definition.parameter)
(labeled_argument label: (var) @definition.parameter)

(binding
  defined: (var) @definition.var)
(def defined: (var) @definition.var)
(let defined: (var) @definition.var)
(meth_pattern (var) @definition.var)
(list_pattern (var) @definition.var)
(tuple_pattern (var) @definition.var)
(spread (var) @definition.var)

(var) @reference
