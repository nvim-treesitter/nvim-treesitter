; inherits: ecma,jsx

; Both properties are matched here.
;
;   class Foo {
;     this.#bar = "baz";
;     this.quuz = "qux";
;   }
(field_definition
  property: [
    (property_identifier)
    (private_property_identifier)
  ] @local.definition.var)

; this.foo = "bar"
(assignment_expression
  left: (member_expression
    object: (this)
    property: (property_identifier) @local.definition.var))

(formal_parameters
  (identifier) @local.definition.parameter)

; function(arg = []) {
(formal_parameters
  (assignment_pattern
    left: (identifier) @local.definition.parameter))

; x => x
(arrow_function
  parameter: (identifier) @local.definition.parameter)

; ({ a }) => null
(formal_parameters
  (object_pattern
    (shorthand_property_identifier_pattern) @local.definition.parameter))

; ({ a: b }) => null
(formal_parameters
  (object_pattern
    (pair_pattern
      value: (identifier) @local.definition.parameter)))

; ([ a ]) => null
(formal_parameters
  (array_pattern
    (identifier) @local.definition.parameter))

(formal_parameters
  (rest_pattern
    (identifier) @local.definition.parameter))

; Both methods are matched here.
;
;   class Foo {
;     #bar(x) { x }
;     baz(y) { y }
;   }
(method_definition
  [
    (property_identifier)
    (private_property_identifier)
  ] @local.definition.function
  (#set! definition.var.scope parent))

; this.foo()
(member_expression
  object: (this)
  property: (property_identifier) @local.reference)
