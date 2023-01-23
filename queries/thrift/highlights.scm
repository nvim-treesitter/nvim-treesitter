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
  "void"
] @type.builtin

; Function

(function_identifier) @function

; Fields

(field_identifier) @field

; Parameters

(param_identifier) @parameter
(exception_param_identifier) @parameter

; Variables

(identifier) @variable

; Constants

(const_identifier) @constant
(enum_member) @constant

; Types

(enum_identifier) @type
(exception_identifier) @type
(exception_param_type) @type
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
 "throws"
] @exception

; Keywords

[
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
  "typedef"
  "union"
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

(namespace_scope) @namespace

; Literals

(string_literal) @string

(number) @number

(double) @float

(boolean) @boolean

; Typedefs
(typedef_definition) @type.definition
(namespace_definition) @type.definition

; Misc

[
  "const"
] @type.qualifier

[
  "*"
] @punctuation.special

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
