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
  "info"
  "service"
] @keyword

"import" @keyword.import

"returns" @keyword.return

"type" @keyword.type

[
  "@doc"
  "@handler"
  "@server"
] @keyword.directive

; Service
(serviceName) @type

; Httpmethod
(HTTPMETHOD) @operator

; Field
(fieldType) @type.builtin

(fieldName) @variable

; Functions
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
(structNameId) @type

(body) @type
