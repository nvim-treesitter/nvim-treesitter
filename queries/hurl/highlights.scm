; highlights.scm

[ 
  "[QueryStringParams]"
  "[FormParams]"
  "[MultipartFormData]"
  "[Cookies]"
  "[Captures]"
  "[Asserts]"
  "[Options]"
  "[BasicAuth]"
] @property

(comment) @comment @spell

(key_string) @property
(json_key_string) @property

[ 
  (value_string)
  (quoted_string)
  (json_string)
] @string
(file_value) @string.special
(regex) @string.regex

[ 
  "\\"
  (regex_escaped_char)
  (quoted_string_escaped_char)
  (key_string_escaped_char)
  (value_string_escaped_char)
  (oneline_string_escaped_char)
  (multiline_string_escaped_char)
  (filename_escaped_char)
  (json_string_escaped_char)
] @string.escape

(method) @type.builtin
(multiline_string_type) @type

[
  "status"
  "url"
  "header"
  "cookie"
  "body"
  "xpath"
  "jsonpath"
  "regex"
  "variable"
  "duration"
  "sha256"
  "md5"
  "bytes"
] @function.builtin

(filter) @attribute

(version) @string.special

"null" @constant.builtin
"cacert" @constant.builtin
"compressed" @constant.builtin
"location" @constant.builtin
"insecure" @constant.builtin
"path_as_is" @constant.builtin
"proxy" @constant.builtin
"max-redirs" @constant.builtin
"retry" @constant.builtin
"retry-interval" @constant.builtin
"retry-max-count" @constant.builtin
(variable_option "variable") @constant.builtin
"verbose" @constant.builtin
"very-verbose" @constant.builtin

(boolean) @boolean

(variable_name) @variable

[
  "not"
  "equals"
  "notEquals"
  "greaterThan"
  "greaterThanOrEquals"
  "lessThan"
  "lessThanOrEquals"
  "startsWith"
  "endsWith"
  "contains"
  "matches"
  "exists"
  "includes"
  "isInteger"
  "isFloat"
  "isBoolean"
  "isString"
  "isCollection"
] @keyword.operator

[
  "=="
  "!="
  ">"
  ">="
  "<"
  "<="
] @operator

[
  (integer)
  (status)
] @number

[
  (float)
  (json_number)
] @float

[ ":" "," ] @punctuation.delimiter

[ "[" "]" "{" "}" "{{" "}}" ] @punctuation.bracket

"base64," @string.special
"file," @string.special
"hex," @string.special
