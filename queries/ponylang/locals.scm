[
  (entity)
  (object)
  (method)
  (behavior)
  (constructor)
  (if)
  (elseif)
  (ifdef)
  (elseifdef)
  (iftype)
  (elseiftype)
  (match)
  (match_case)
  (while)
  (repeat)
  (for)
  (lambda)
  (try_block)
  (with)
] @scope
(match else_block: (block) @scope)
(try_block else_block: (block) @scope)
(try_block then_block: (block) @scope)
("with" else_block: (block) @scope)

; types
(use name: (identifier) @definition.import)
(entity name: (identifier) @definition.type)
(typeparam name: (identifier) @definition.type)
; fields and methods
(field name: (identifier) @definition.field)
(constructor name: (identifier) @definition.method)
(method name: (identifier) @definition.method)
(behavior name: (identifier) @definition.method)

; local stuff
(local name: (identifier) @definition.var)
(param name: (identifier) @definition.parameter)
(lambdaparam name: (identifier) @definition.parameter)
("for" element: (idseq (identifier) @definition.var))
(withelem name: (idseq (identifier) @definition.var))

; only lower case identifiers are references
(
  (identifier) @reference
  (#match? @reference "^[a-z_][a-zA-Z_]*")
)
