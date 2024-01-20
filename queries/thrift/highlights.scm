; Variables
((identifier) @variable
  (#set! "priority" 95))

; Includes
[
  "include"
  "cpp_include"
] @keyword.import

; Function
(function_definition
  (identifier) @function)

; Fields
(field
  (identifier) @variable.member)

; Parameters
(function_definition
  (parameters
    (parameter
      (identifier) @variable.parameter)))

(throws
  (parameters
    (parameter
      (identifier) @variable.parameter)))

; Types
(typedef_identifier) @type

(struct_definition
  "struct"
  (identifier) @type)

(union_definition
  "union"
  (identifier) @type)

(exception_definition
  "exception"
  (identifier) @type)

(service_definition
  "service"
  (identifier) @type)

(interaction_definition
  "interaction"
  (identifier) @type)

(type
  type: (identifier) @type)

(definition_type
  type: (identifier) @type)

((identifier) @type
  (#lua-match? @type "^[_]*[A-Z]"))

; Constants
(const_definition
  (identifier) @constant)

((identifier) @constant
  (#lua-match? @constant "^[_A-Z][A-Z0-9_]*$"))

(enum_definition
  "enum"
  .
  (identifier) @type
  "{"
  (identifier) @constant
  "}")

; Builtin Types
(primitive) @type.builtin

[
  "list"
  "map"
  "set"
  "sink"
  "stream"
  "void"
] @type.builtin

; Namespace
(namespace_declaration
  (namespace_scope) @string.special
  [
    (namespace) @module
    (_
      (identifier) @module)
  ])

; Attributes
(annotation_definition
  (annotation_identifier
    (identifier) @attribute))

(fb_annotation_definition
  "@" @attribute
  (annotation_identifier
    (identifier) @attribute)
  (identifier)? @attribute)

(namespace_uri
  (string) @attribute)

; Operators
[
  "="
  "&"
] @operator

; Exceptions
"throws" @keyword.exception

; Keywords
[
  "enum"
  "exception"
  "extends"
  "interaction"
  "namespace"
  "senum"
  "service"
  "struct"
  "typedef"
  "union"
  "uri"
] @keyword

; Deprecated Keywords
[
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
  "package"
  "performs"
] @keyword

[
  "async"
  "oneway"
] @keyword.coroutine

; Qualifiers
[
  "client"
  "const"
  "idempotent"
  "optional"
  "permanent"
  "readonly"
  "required"
  "safe"
  "server"
  "stateful"
  "transient"
] @type.qualifier

; Literals
(string) @string

(escape_sequence) @string.escape

(namespace_uri
  (string) @string.special.url)

(number) @number

(double) @number.float

(boolean) @boolean

; Typedefs
(typedef_identifier) @type.definition

; Punctuation
"*" @punctuation.special

[
  "{"
  "}"
] @punctuation.bracket

[
  "("
  ")"
] @punctuation.bracket

[
  "["
  "]"
] @punctuation.bracket

[
  "<"
  ">"
] @punctuation.bracket

[
  "."
  ","
  ";"
  ":"
] @punctuation.delimiter

; Comments
(comment) @comment @spell

((comment) @comment.documentation
  (#lua-match? @comment.documentation "^/[*][*][^*].*[*]/$"))

((comment) @comment.documentation
  (#lua-match? @comment.documentation "^///[^/]"))

((comment) @comment.documentation
  (#lua-match? @comment.documentation "^///$"))

((comment) @keyword.directive
  (#lua-match? @keyword.directive "#!.*"))
