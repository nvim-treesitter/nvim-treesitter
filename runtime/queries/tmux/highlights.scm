; Comments
(comment) @comment @spell

; General
[
  (string)
  (raw_string)
] @string

(int) @number

(path) @string.special.path

[
  (option)
  (variable_name)
] @variable

(command_line_option) @variable.builtin

((option) @variable.builtin
  (#not-lua-match? @variable.builtin "^@"))

(command) @keyword

(source_file_directive
  (command) @keyword.import)

(attribute) @attribute

(function_name) @function.call

"=" @operator

[
  ","
  ":"
] @punctuation.delimiter

[
  "#"
  "?"
] @punctuation.special

[
  "#{"
  "}"
  "#["
  "]"
  "["
  "{"
] @punctuation.bracket
