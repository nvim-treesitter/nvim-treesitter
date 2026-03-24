; inherits: html

(raw_text) @none

((tag_name) @type
  (#match? @type "^[A-Z]"))

(tag_name
  namespace: (tag_namespace) @keyword
  ":" @punctuation.delimiter
  name: (tag_local_name) @tag)

(tag_name
  object: (tag_member) @type
  "." @punctuation.delimiter
  property: (tag_member) @tag)

(attribute_directive) @keyword

(attribute_name
  ":" @punctuation.delimiter)

(attribute_identifier) @property

(attribute_modifier) @attribute

(attribute_modifiers
  "|" @punctuation.delimiter)

(expression) @embedded

(expression_value) @embedded

(shorthand_attribute
  content: (_) @variable)

[
  "{"
  "}"
] @punctuation.bracket

"|" @punctuation.delimiter

(tag_comment
  kind: (line_comment) @comment)

(tag_comment
  kind: (block_comment) @comment)

[
  "if"
  "each"
  "await"
  "key"
  "snippet"
  "else"
  "html"
  "debug"
  "const"
  "render"
  "attach"
  "as"
] @keyword.control

(block_keyword) @keyword.control

(block_open) @tag.delimiter

(block_close) @tag.delimiter

(shorthand_kind) @keyword.control

(branch_kind) @keyword.control

(block_sigil) @keyword.control

(if_block
  expression: (expression) @embedded)

(else_if_clause
  expression: (expression_value) @embedded)

(each_block
  expression: (expression) @embedded)

(each_block
  binding: (pattern) @variable)

(each_block
  index: (pattern) @variable)

(each_block
  key: (expression) @embedded)

(await_block
  expression: (expression) @embedded)

(await_branch
  (pattern) @variable)

(await_block
  (pattern) @variable)

(orphan_branch
  (pattern) @variable)

(key_block
  expression: (expression) @embedded)

(snippet_block
  name: (snippet_name) @function)

(snippet_parameters
  parameter: (pattern) @variable)

(snippet_type_parameters) @type

[
  "("
  ")"
  ","
] @punctuation.delimiter
