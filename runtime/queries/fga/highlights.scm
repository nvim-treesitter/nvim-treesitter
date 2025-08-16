(call_expression
  function: (identifier) @function)

(call_expression
  function: (selector_expression
    field: (identifier) @function.method))

((type_identifier) @type.builtin
  (#any-of? @type.builtin
    "string" "int" "map" "uint" "list" "timestamp" "bool" "duration" "double" "ipaddress"))

(condition_declaration
  name: (identifier) @function)

(version) @number

[
  "("
  ")"
  "["
  "]"
] @punctuation.bracket

[
  "+"
  "-"
  "|"
  "^"
  "*"
  "/"
  "%"
  ">>"
  "<<"
  "&"
  "&^"
] @keyword.operator

[
  "or"
  "and"
  "but not"
] @keyword.operator

[
  "model"
  "module"
  "schema"
  "relations"
  "define"
  "from"
] @keyword

"condition" @keyword.function

"type" @keyword.operator

(comment) @comment
