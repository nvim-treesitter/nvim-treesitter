; SCOPES
(module) @local.scope

(dataclass) @local.scope

(datatype) @local.scope

; TODO does not work
;(classMember (body)  @local.scope)
(memberPredicate
  (body) @local.scope)

(classlessPredicate
  (body) @local.scope)

(quantified
  (conjunction) @local.scope)

(select) @local.scope

; DEFINITIONS
; module
(module
  name: (moduleName) @local.definition.namespace)

; classes
(dataclass
  name: (className) @local.definition.type)

(datatype
  name: (className) @local.definition.type)

; predicates
(charpred
  (className) @local.definition.method)

(memberPredicate
  name: (predicateName) @local.definition.method)

(classlessPredicate
  name: (predicateName) @local.definition.function)

; variables
(varDecl
  (varName
    (simpleId) @local.definition.var))

; REFERENCES
(simpleId) @local.reference
