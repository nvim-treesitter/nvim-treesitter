; Display errors
(ERROR) @error

; Comments
(comment) @comment

(request
  method: (method) @keyword
  url: (url) @text.uri)

(header
  name: (name) @constant
  value: (value))

; JSON
(json_pair
  key: (_) @keyword)

(json_string) @string

(json_number) @number

(json_boolean) @boolean

(json_null) @constant

(json_escape_sequence) @string.escape

(json_body) @keyword

; rest.nvim Neovim plugin specific features
(external_body
  json_file: (json_file) @text.uri) @keyword
