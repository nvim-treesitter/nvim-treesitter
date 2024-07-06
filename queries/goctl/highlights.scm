; Key Symbol
"." @punctuation.delimiter

"," @punctuation.delimiter

":" @punctuation.delimiter

";" @punctuation.delimiter

"(" @punctuation.bracket

")" @punctuation.bracket

"{" @punctuation.bracket

"}" @punctuation.bracket

"[" @punctuation.bracket

"]" @punctuation.bracket

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
(fieldName) @field

; Functions
(serviceHandlerNew) @namespace
(handlerValue) @method

; Strings
(VALUE) @string
(tag) @string
(PATH) @string

; Comments
(comment) @comment @spell


(key) @string
(identValue) @parameter
(DURATION) @number
(NUMBER) @number

; Struct
(structNameId) @type.definition
(body) @type.definition


