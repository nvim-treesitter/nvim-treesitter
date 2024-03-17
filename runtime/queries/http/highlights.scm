; Keywords

(scheme) @namespace

; Methods

(method) @method

; Constants

(const_spec) @constant

; Headers

(header
  name: (name) @constant)

; Variables

(variable_declaration
  name: (identifier) @variable)

(variable_declaration
  value: (number) @number)

(variable_declaration
  value: (boolean) @boolean)

(variable_declaration
  value: (string) @string)

; Fields

(pair name: (identifier) @field)

; URL / Host
(host) @text.uri
(host (identifier) @text.uri)
(path (identifier) @text.uri)

; Parameters

(query_param (key) @parameter)

; Operators

[
  "="
  "?"
  "&"
  "@"
  "<"
] @operator

; Literals

(target_url) @text.uri

(http_version) @constant

(string) @string

(number) @number

(boolean) @boolean

; Punctuation

[ "{{" "}}" ] @punctuation.bracket

[
  ":"
] @punctuation.delimiter

; external JSON body

(external_body
  file_path: (path) @text.uri)

; Comments

(comment) @comment @spell

; Errors

(ERROR) @error
