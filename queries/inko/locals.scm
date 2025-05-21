[
  (method)
  (block)
] @local.scope

((method
  name: _ @local.definition.method) @local.scope
  (#set! definition.function.scope "parent"))

(external_function
  name: _ @local.definition.function)

(argument
  name: _ @local.definition.parameter)

(define_variable
  name: _ @local.definition.var)

(define_constant
  name: _ @local.definition.constant)

(define_field
  name: _ @local.definition.field)

(named_argument
  name: _ @local.definition.parameter)

((class
  modifier: (modifier
    "enum")
  name: _ @local.definition.enum) @local.scope
  (#set! definition.type.scope "parent"))

(class
  modifier: (modifier
    "enum")
  body: (class_body
    (define_case
      name: _ @local.definition.field)))

((class
  name: _ @local.definition.type) @local.scope
  (#set! definition.type.scope "parent"))

((trait
  name: _ @local.definition.type) @local.scope
  (#set! definition.type.scope "parent"))

(import
  (symbols
    [
      (identifier)
      (constant)
      (self)
    ] @local.definition.import))

(identifier) @local.reference

(field) @local.reference

(constant) @local.reference
