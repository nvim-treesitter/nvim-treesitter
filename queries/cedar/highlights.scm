; Function calls
(call_expression
  function: (selector_expression
    field: (field_identifier) @function.method))

[
  "contains"
  "containsAll"
] @function

; Annotations
(annotation) @attribute

; Identifiers
[
  (entity)
  (principal)
  (action)
  (resource)
  (context)
  (identifier)
] @variable

(path) @type

(field_identifier) @property

; Operators
[
  "-"
  "!"
  "!="
  "*"
  "&&"
  "+"
  "<"
  "<="
  "=="
  ">"
  ">="
  "||"
  "in"
  "has"
] @operator

; Keywords
[
  (permit)
  (forbid)
  (when)
  (unless)
] @keyword

; Literals
(str) @string

(int) @number

[
  (true)
  (false)
] @boolean

(comment) @comment @spell
