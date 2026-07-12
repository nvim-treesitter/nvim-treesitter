(comment) @comment @spell

(string) @string

(path) @string.special.path

(int) @number

[
  (option)
  (name)
] @variable

(command_line_option) @variable.builtin

((option) @variable.builtin
  (#not-lua-match? @variable.builtin "^@"))

[
  (if_keyword)
  (elif_keyword)
  (else_keyword)
  (endif_keyword)
] @keyword.conditional

[
  (hidden_keyword)
  (command)
] @keyword

(source_file_directive
  (command) @keyword.import)

(hook_name) @attribute

"=" @operator

";" @punctuation.delimiter

[
  "}"
  "]"
  "["
  "{"
] @punctuation.bracket
