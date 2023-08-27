((tag_name) @keyword
  (#set! "priority" 105))

(identifier) @variable

((tag
  (tag_name) @_param 
  (identifier) @parameter)
  (#any-of? @_param "@param" "\\param"))

(function (identifier) @function)

(function_link) @function

(emphasis) @text.emphasis

"\\a" @tag

(code_block_language) @label

[
  "in"
  "out"
  "inout"
] @storageclass

"~" @operator

[
  "<a"
  ">"
  "</a>"
] @tag

[
  ","
  "::"
  (code_block_start)
  (code_block_end)
] @punctuation.delimiter

[ "(" ")" "[" "]" ] @punctuation.bracket

(code_block_content) @none
