((tag_name) @keyword
  (#set! "priority" 105))

[
  "@code"
  "@endcode"
] @keyword

(identifier) @variable

((tag
  (tag_name) @_param
  (identifier) @variable.parameter)
  (#any-of? @_param "@param" "\\param"))

(function
  (identifier) @function)

(function_link) @function

(emphasis) @markup.italic

[
  "\\a"
  "\\c"
] @tag

(code_block_language) @label

[
  "in"
  "out"
  "inout"
] @keyword.storage

"~" @operator

[
  "<a"
  ">"
  "</a>"
] @tag

[
  "."
  ","
  "::"
  (code_block_start)
  (code_block_end)
] @punctuation.delimiter

[
  "("
  ")"
  "{"
  "}"
  "["
  "]"
] @punctuation.bracket

(code_block_content) @none
