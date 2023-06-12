[
  (method)
  (block)
] @local.scope

(method
  name: _ @local.definition.method)

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

(class
  modifier: (modifier
    "enum")
  name: _ @local.definition.enum)

(class
  modifier: (modifier
    "enum")
  body: (class_body
    (define_case
      name: _ @local.definition.field)))

(class
  name: _ @local.definition.type)

(trait
  name: _ @local.definition.type)

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
