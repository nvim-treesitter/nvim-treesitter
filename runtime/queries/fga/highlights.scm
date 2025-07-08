(call_expression
  function: (identifier) @function)

(call_expression
  function: (selector_expression
    field: (identifier) @function.method))

((type_identifier) @type.builtin
  (#match? @type.builtin "^(string|int|map|uint|list|timestamp|bool|duration|double|ipaddress)$"))

(condition_declaration
  name: (identifier) @function)

(version) @number

[
  "*"
  "/"
  "%"
  ">>"
  "<<"
  "&"
  "&^"
] @operator

[
  "+"
  "-"
  "|"
  "^"
] @operator

[
  "or"
  "and"
  "but not"
] @operator

[
  "model"
  "schema"
  "type"
  "relations"
  "define"
  "from"
] @keyword

"condition" @keyword.function

(comment) @comment
