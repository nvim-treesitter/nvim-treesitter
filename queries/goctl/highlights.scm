; Key Symbol
[
  "."
  ","
  ":"
  ";"
] @punctuation.delimiter

[
  "("
  ")"
  "{"
  "}"
  "["
  "]"
] @punctuation.bracket

; Keywords
[
  "syntax"
  "import"
  "info"
  "type"
  "@server"
  "service"
  "returns"
] @keyword

; Service
(serviceName) @type.definition

; Httpmethod
(HTTPMETHOD) @operator

; Field
(fieldType) @type.builtin

(fieldName) @variable

; Functions
(serviceHandlerNew) @keyword.directive

(handlerValue) @function.method

; Strings
(VALUE) @string

(tag) @string.documentation

(PATH) @string.special.path

; Comments
(comment) @comment @spell

(key) @string

(identValue) @string

(DURATION) @number

(NUMBER) @number

; Struct
(structNameId) @type.definition

(body) @type.definition
