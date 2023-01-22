; Namespace

(namespace) @namespace

; Includes

[
  "include"
  "cpp_include"
] @include

(include_path) @string

; Types

(primitive_type) @type.builtin

[
  "list"
  "map"
  "set"
] @type.builtin

; Function

(function) @function

; Fields

(field_identifier) @field

; Parameters

(param_identifier) @parameter

; Variables

(identifier) @variable
(enum_identifier) @variable

; Constants

(const_identifier) @constant
(enum_member) @constant

; Types

(field_type) @type
(type_identifier) @type

; Attributes

(annotation_identifier) @attribute

; Operators

[
 "="
 "+"
 "-"
 "&"
] @operator

; Exceptions

[
  (exception)
  (throws)
] @exception

; Keywords

[
  "const"
  "cpp_include"
  "enum"
  "exception"
  "extends"
  "include"
  "namespace"
  "oneway"
  "optional"
  "required"
  "senum"
  "service"
  "struct"
  "throws"
  "typedef"
  "union"
  "void"
] @keyword

; Deprecated Keywords

[
  "async"
  "byte"
  "cocoa_prefix"
  "cpp_namespace"
  "csharp_namespace"
  "delphi_namespace"
  "java_package"
  "perl_package"
  "php_namespace"
  "py_module"
  "ruby_namespace"
  "smalltalk_category"
  "smalltalk_prefix"
  "xsd_all"
  "xsd_attrs"
  "xsd_namespace"
  "xsd_nillable"
  "xsd_optional"
] @keyword

(namespace_scope) @keyword

; Literals

(string_literal) @string

(number) @number

(double) @float

(boolean) @boolean

(typedef_definition) @type.definition
(namespace_definition) @type.definition

[
  "const"
] @type.qualifier

[
  "*"
] @punctuation.special

; Misc

(field_modifier) @attribute

["{" "}"] @punctuation.bracket

["(" ")"] @punctuation.bracket

["[" "]"] @punctuation.bracket

["<" ">"] @punctuation.bracket

[
  ";"
  ","
  (list_separator)
] @punctuation.delimiter

; Errors

(invalid) @error

; Comments

(comment) @comment @spell
