; Preproc (?)

(unique_id) @preproc
(top_level_annotation_body) @preproc

; Includes

[
  "import"
  "$import"
  "embed"
] @include

(import_path) @string

; Types

(primitive_type) @type.builtin

[
  "annotation"
  "enum"
  "group"
  "interface"
  "struct"
  "union"
] @keyword

; Typedefs

(type_definition) @type.definition

; Labels (@number, @number!)

(field_version) @label

; Methods

(annotation_definition_identifier) @method
(method_identifier) @method

; Fields

(field_identifier) @field

; Properties

(property) @property

; Parameters

(param_identifier) @parameter
(return_identifier) @parameter

; Variables

(identifier) @variable

; Constants

(const_identifier) @constant
(local_const) @constant
(enum_member) @constant

(void) @constant.builtin

; Types

(enum_identifier) @type
(extend_type) @type
(field_type) @type
(generic_identifier) @type
(type_identifier) @type

; Attributes

(annotation_identifier) @attribute
(attribute) @attribute

; Operators

[
 ; @ ! -
  "="
] @operator

; Keywords

[
  "extends"
  "namespace"
  "using"
  (annotation_target)
] @keyword

; Literals

(string_literal) @string
(block_text) @string

(data_string) @string.special
(namespace) @string.special

(number) @number

(float) @float

(boolean) @boolean

; Misc

[
  "const"
] @type.qualifier

[
  "*"
  "$"
] @punctuation.special

["{" "}"] @punctuation.bracket

["(" ")"] @punctuation.bracket

["[" "]"] @punctuation.bracket

[
  ","
  ";"
  "->"
] @punctuation.delimiter

(data_hex) @symbol

; Comments

(comment) @comment @spell
