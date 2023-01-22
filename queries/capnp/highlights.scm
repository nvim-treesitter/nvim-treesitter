; Preproc (?)

(unique_id) @preproc

; Includes

[
  "import"
  "$import"
] @include

(import_path) @string

; Types

(primitive_type) @type.builtin

[
  "annotation"
  "enum"
  "group"
  "interface"
  "List"
  "struct"
  "union"
] @type.builtin

; Methods

(method_identifier) @method

; Fields

(field_identifier) @field

; Parameters

(param_identifier) @parameter
(return_identifier) @parameter

; Variables

(identifier) @variable

; Constants

(const_identifier) @constant
(enum_member) @constant

; Types

(enum_identifier) @type
(extend_type) @type
(field_type) @type
(generic_identifier) @type
(type_identifier) @type

; Attributes

(attribute) @attribute
(annotation_identifier) @attribute

; Operators

[
 ; @ ! -
  "="
] @operator

; Keywords

[
  "const"
  "extends"
  "namespace"
  "using"
] @keyword

; Literals

(string_literal) @string

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
] @punctuation.special

["{" "}"] @punctuation.bracket

["(" ")"] @punctuation.bracket

["[" "]"] @punctuation.bracket

[
  ","
  ";"
  "->"
] @punctuation.delimiter

; Comments

(comment) @comment @spell
