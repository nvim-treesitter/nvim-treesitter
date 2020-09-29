(classlessPredicate
  name: (predicateName) @name) @definition.function

(memberPredicate
  name: (predicateName) @name) @definition.method

(aritylessPredicateExpr
  name: (literalId) @name) @reference.call

(module
  name: (moduleName) @name) @definition.module

(dataclass
  name: (className) @name) @definition.class

(datatype
  name: (className) @name) @definition.class

(datatypeBranch
  name: (className) @name) @definition.class

(qualifiedRhs
  name: (predicateName) @name) @reference.call

(typeExpr
  name: (className) @name) @reference.type
