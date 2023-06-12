[
  ";"
  "."
  ","
] @punctuation.delimiter

[
  "("
  ")"
  "["
  "]"
  "{"
  "}"
] @punctuation.bracket

(comment) @comment @spell

(doc_comment) @comment.documentation @spell

[
  "service"
  "errors"
] @keyword

[
  "method"
  "event"
] @keyword.function

[
  "enum"
  "data"
] @keyword.type

"extern" @keyword.modifier

(type) @type.builtin

(service
  service_name: (identifier) @type)

(error_set
  (identifier) @variable.member)

(error_set
  name: (identifier) @type)

(dto
  name: (identifier) @type)

(external_dto
  name: (identifier) @type)

(enum
  (values_block
    (identifier) @constant))

(enum
  name: (identifier) @type)

(external_enum
  name: (identifier) @type)

(type
  name: (identifier) @type)

[
  "map"
  "nullable"
  "result"
  "required"
  "http"
  "csharp"
  "js"
  "info"
  "obsolete"
] @attribute.builtin

(parameter
  name: (identifier) @variable.parameter)

(field
  name: (identifier) @variable.member)

(method
  name: (identifier) @function.method)

(number_literal) @number

(string_literal) @string
