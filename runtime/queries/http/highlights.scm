; Methods
(method) @function.method

; Headers
(header
  name: (_) @constant)

(header
  value: (_) @string)

; Variables
(identifier) @variable

(variable_declaration
  "@" @character.special)

(variable_declaration
  (value) @string)

; Operators
(comment
  "=" @operator)

(variable_declaration
  "=" @operator)

; keywords
(comment
  "@" @keyword
  name: (_) @keyword)

; Literals
(request
  url: (_) @string.special.url)

(http_version) @string.special

; Response
(status_code) @number

(status_text) @string

; Punctuation
[
  "{{"
  "}}"
  "{%"
  "%}"
] @punctuation.bracket

">" @punctuation.special

(header
  ":" @punctuation.delimiter)

; external JSON body
(external_body
  path: (_) @string.special.path)

; Comments
[
  (comment)
  (request_separator)
] @comment @spell
