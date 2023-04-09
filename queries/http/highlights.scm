; Display errors
(ERROR) @error

; Comments
(comment) @comment

(request
  (method) @keyword
  (target_url) @text.uri)

(pair
  name: (_) @attribute
  value: (_) @string)

(query_param
  key: (key) @attribute
  value: (value) @string)

(header
  name: (name) @constant
  value: (value))

(host) @text.uri
(path) @text.uri
(number) @number
(string) @string
(scheme) @keyword
(variable) @variable
(variable_declaration
  identifier: (identifier) @variable
  value: (value) @string)

[
  "@"
  ":"
  "="
] @operator
