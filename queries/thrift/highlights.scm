; Namespace

(namespace) @namespace

; Includes

[
  "include"
  "cpp_include"
] @include

(include_path) @definition.import

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

(field) @field

; Parameters

(parameter) @parameter

; Variables

(identifier) @variable

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

; Deprecated
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

[
  "typedef"
] @type.definition

[
  "const"
] @type.qualifier

[
  "*"
] @character.special

; Misc

(field_modifier) @attribute

["{" "}"] @punctuation.bracket

["(" ")"] @punctuation.bracket

["[" "]"] @punctuation.bracket

[
  ";"
  ","
  (list_separator)
] @punctuation.delimiter

; Errors

(invalid) @error

; Comments

(comment) @comment @spell
