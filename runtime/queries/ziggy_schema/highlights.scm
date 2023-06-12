(struct_field
  key: (_) @keyword)

(tag_name) @function

[
  "unknown"
  "any"
  "struct"
  "root"
  "enum"
  "map"
] @keyword

(identifier) @type

"?" @type

[
  "bool"
  "bytes"
  "int"
  "float"
] @constant.builtin

(doc_comment) @comment.documentation

[
  ","
  "|"
] @punctuation.delimiter

[
  "["
  "]"
  "{"
  "}"
] @punctuation.bracket
