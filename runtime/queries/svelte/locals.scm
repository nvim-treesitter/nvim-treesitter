; inherits: html

(snippet_block) @local.scope

(snippet_parameters
  parameter: (pattern) @local.definition.parameter)

(snippet_name) @local.definition.function

((tag_name) @local.reference
  (#lua-match? @local.reference "^[A-Z]"))

(tag_name
  object: (tag_member) @local.reference
  property: (tag_member) @local.reference)
