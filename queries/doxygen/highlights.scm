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
] @punctuation.delimiter

[ "(" ")" "[" "]" ] @punctuation.bracket
