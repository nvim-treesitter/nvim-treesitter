; inherits: hlsl
[
  "var"
  "let"
  "This"
] @type.builtin

[
  "interface"
  "extension"
  "property"
] @keyword

"__init" @constructor

[
  "__subscript"
  "get"
  "set"
] @function.builtin

(interface_requirements
  (identifier) @type)

(binary_expression
  [
    "is"
    "as"
  ]
  right: (identifier) @type)

[
  "as"
  "is"
] @keyword.operator

[
  "__exported"
  "import"
] @keyword.import

(property_declaration
  (identifier) @property)
