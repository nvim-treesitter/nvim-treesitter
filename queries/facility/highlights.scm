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
]  @punctuation.bracket

(comment) @comment @spell
(doc_comment) @comment.documentation @spell

"method" @keyword.function

[
  "service"
  "errors"
  "data"
  "enum"
  "extern"
] @type.builtin

(type) @type.builtin

(service
  service_name: (identifier) @type)

(error_set
  (identifier) @property)

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
  name: (identifier) @property)

(field
  name: (identifier) @variable)

(method
  name: (identifier) @method)

(number_literal) @number
(string_literal) @string
