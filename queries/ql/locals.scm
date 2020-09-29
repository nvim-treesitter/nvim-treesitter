((classlessPredicate
  name: (predicateName)) @definition.function)

((memberPredicate
  name: (predicateName)) @definition.method)

((aritylessPredicateExpr
  name: (literalId)) @reference.call)

((module
  name: (moduleName)) @definition.module)

((dataclass
  name: (className)) @definition.class)

((datatype
  name: (className)) @definition.class)

((datatypeBranch
  name: (className)) @definition.class)

((qualifiedRhs
  name: (predicateName)) @reference.call)

((typeExpr
  name: (className)) @reference.type)
