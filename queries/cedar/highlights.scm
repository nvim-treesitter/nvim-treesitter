; Function calls

(call_expression
  function: (selector_expression
    field: (field_identifier) @function.method))

[
    "contains"
    "containsAll"
] @function

; Identifiers

[
    (entity)
    (principal)
    (action)
    (resource)
    (context)
    (identifier)
    (annotation)
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
] @constant.builtin

(comment) @comment
