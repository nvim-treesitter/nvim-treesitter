
; Keywords

[
  "namespace"
  "service"
  "structure"
  "operation"
  "list"
  "map"
  "union"
  "resource"
  "set"
  "metadata"
  "apply"
  "for"
  "with"
  "enum"
  "intEnum"
] @keyword

(simple_type_name) @type.builtin
"use" @include

[
  ":"
  "."
] @punctuation.delimiter


[
  "("
  ")"
  "["
  "]"
  "{"
  "}"
  "#"
] @punctuation.bracket

(node_keywords) @boolean
(number) @number
(quoted_text) @string
[
  (comment)
  (documentation_comment)
] @comment
[
  ("@")
] @operator

(use_statement
  (absolute_root_shape_id
    (namespace) @namespace
    (identifier) @type
  ))

(trait
  (shape_id) @attribute
)

(node_string_value
  (shape_id) @type
)

; (trait_body) @local.scope

(shape_member_kvp
  (identifier) @variable
  (shape_id) @type
)
(shape_member_elided
  (identifier) @variable
)
(structure_shape_statement
  (identifier) @type.definition
)
(operation_shape_statement
  (identifier) @type.definition
)
(list_shape_statement
  (identifier) @type.definition
)
(simple_shape_statement
  (identifier) @type.definition
)
(resource_shape_statement
  (identifier) @type.definition
)
(union_shape_statement
  (identifier) @type.definition
)
(map_shape_statement
  (identifier) @type.definition
)
(service_shape_statement
  (identifier) @type.definition
)
(set_shape_statement
  (identifier) @type.definition
)
(enum_shape_statement
  (identifier) @type.definition
)
(operation_shape_statement
  (identifier) @type.definition
)
(operation_error
  (identifier) @type
)
(structure_resource
  (shape_id) @type
)
(mixins
  (shape_id) @type
)
