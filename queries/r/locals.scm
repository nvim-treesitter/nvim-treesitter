; locals.scm

(function) @scope

(parameter name: (identifier) @definition.parameter)
(argument  name: (identifier) @definition)

("<-" lhs: (identifier) @definition)
("="  lhs: (identifier) @definition)
("->" rhs: (identifier) @definition)

(identifier) @reference
