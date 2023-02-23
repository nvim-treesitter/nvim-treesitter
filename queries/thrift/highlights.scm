 ; Namespace

(namespace_definition) @namespace

; Includes

[
  "include"
  "cpp_include"
] @include

(include_path) @string
(package_path) @string

; Builtins

(primitive) @type.builtin

[
  "list"
  "map"
  "set"
  "sink"
  "stream"
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
(definition_type) @type
(exception_identifier) @type
(exception_param_type) @type
(field_type) @type
(param_type) @type
(type_identifier) @type

; Attributes

(annotation_identifier) @attribute
(uri_def) @attribute

; Operators

[
 "="
 "+"
 "-"
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
  "interaction"
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

; Extended Keywords
[
  "client"
  "idempotent"
  "package"
  "performs"
  "permanent"
  "readonly"
  "server"
  "safe"
  "stateful"
  "transient"
] @keyword

; Literals

[
 (annotation_value)
 (string)
] @string

(escape_sequence) @string.escape

(uri (string_fragment) @text.uri) @string.special

(number) @number

(double) @float

(boolean) @boolean

; Typedefs

(typedef_definition) @type.definition
(namespace_scope) @type.definition

; Qualifiers

[
  "const"
  (exception_modifier)
  (field_modifier)
  (function_modifier)
] @type.qualifier

; Punctuation

[
  "*"
  "&"
  "@"
] @punctuation.special

["{" "}"] @punctuation.bracket

["(" ")"] @punctuation.bracket

["[" "]"] @punctuation.bracket

["<" ">"] @punctuation.bracket

[
  ";"
  ","
] @punctuation.delimiter

; Errors

(invalid) @error

; Comments

(comment) @comment @spell
