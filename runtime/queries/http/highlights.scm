; Schemes
(scheme) @type

; Methods
(method) @function.method

; Constants
(const_spec) @constant

; Variables
(identifier) @variable

; Fields
(pair
  name: (identifier) @variable.member)

; Parameters
(query_param
  (key) @variable.parameter)

; Operators
[
  "="
  "?"
  "&"
  "@"
] @operator

; Literals
(string) @string

(target_url) @string.special.url

(number) @number

; (boolean) @boolean
(null) @constant.builtin

; Punctuation
[
  "{{"
  "}}"
] @punctuation.bracket

":" @punctuation.delimiter

; Comments
(comment) @comment @spell
