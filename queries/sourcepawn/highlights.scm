(identifier) @variable

; Assume all-caps names are constants
((identifier) @constant
  (#lua-match? @constant "^[A-Z][A-Z0-9_]+$"))

; Function definitions/declarations
(function_definition
  name: (identifier) @function)

(function_declaration
  name: (identifier) @function)

(parameter_declaration
  name: (identifier) @variable.parameter)

; Methods / Properties
(field_access
  field: (identifier) @variable.member)

; Function calls
(call_expression
  function: (identifier) @function)

(call_expression
  function: (field_access
    field: (identifier) @function.method.call))

; Types
[
  (builtin_type)
  (any_type)
] @type.builtin

(type
  (identifier) @type)

; Variables
(variable_declaration
  name: (identifier) @variable)

(old_variable_declaration
  name: (identifier) @variable)

[
  (system_lib_string)
  (string_literal)
] @string

; Preprocessor
[
  "#include"
  "#tryinclude"
] @keyword.import

[
  (preproc_assert)
  (preproc_pragma)
  (preproc_if)
  (preproc_else)
  (preproc_elseif)
  (preproc_endinput)
  (preproc_endif)
  (preproc_error)
  (preproc_warning)
] @keyword.directive

[
  "#define"
  "#undef"
] @keyword.directive.define

(macro_param) @variable.parameter

(preproc_define
  name: (identifier) @constant)

(preproc_macro
  name: (identifier) @function.macro)

(preproc_undefine
  name: (identifier) @constant)

; Expressions
(view_as) @function.builtin

(sizeof_expression) @function.macro

[
  (this)
  ; https://github.com/alliedmodders/sourcemod/blob/5c0ae11a4619e9cba93478683c7737253ea93ba6/plugins/include/handles.inc#L78
  (hardcoded_symbol)
] @variable.builtin

; Comments
(comment) @comment @spell

; General
(parameter_declaration
  defaultValue: (identifier) @constant)

[
  (fixed_dimension)
  (dimension)
] @punctuation.bracket

(escape_sequence) @string.escape

; Constructors
(new_expression
  class: (identifier) @type
  arguments: (call_arguments) @constructor)

; Methodmaps
(methodmap
  name: (identifier) @type)

(methodmap
  inherits: (identifier) @type)

(methodmap_method_constructor
  name: (identifier) @constructor)

(methodmap_method
  name: (identifier) @function.method)

(methodmap_native
  name: (identifier) @function.method)

(methodmap_property
  name: (identifier) @property)

[
  (methodmap_property_getter)
  (methodmap_property_setter)
] @function.method

; Enum structs
(enum_struct
  name: (identifier) @type)

(enum_struct_field
  name: (identifier) @variable.member)

(enum_struct_method
  name: (identifier) @function.method)

; Non-type Keywords
(variable_storage_class) @keyword.modifier

(visibility) @keyword.modifier

(assertion) @function.builtin

(function_declaration_kind) @keyword.function

[
  "new"
  "delete"
] @keyword.operator

[
  "."
  ","
] @punctuation.delimiter

; Operators
[
  "+"
  "-"
  "*"
  "/"
  "%"
  "++"
  "--"
  "="
  "+="
  "-="
  "*="
  "/="
  "=="
  "!="
  "<"
  ">"
  ">="
  "<="
  "!"
  "&&"
  "||"
  "&"
  "|"
  "~"
  "^"
  "<<"
  ">>"
  ">>>"
  "|="
  "&="
  "^="
  "~="
  "<<="
  ">>="
  "..."
  (ignore_argument)
  (scope_access)
  (rest_operator)
] @operator

; public Plugin myinfo
(struct_declaration
  name: (identifier) @variable.builtin)

; Typedef/Typedef
(typedef
  name: (identifier) @type)

(functag
  name: (identifier) @type)

(funcenum
  name: (identifier) @type)

(typeset
  name: (identifier) @type)

(typedef_expression) @keyword.function ; function void(int x)

; Enums
(enum
  name: (identifier) @type)

(enum_entry
  name: (identifier) @constant)

(enum_entry
  value: (_) @constant)

; Literals
(int_literal) @number

(char_literal) @character

(float_literal) @number.float

(string_literal) @string

(array_literal) @punctuation.bracket

(bool_literal) @boolean

(null) @constant.builtin

((identifier) @constant.builtin
  (#eq? @constant.builtin "INVALID_HANDLE"))

; Keywords
"return" @keyword.return

[
  "if"
  "else"
  "case"
  "default"
  "switch"
] @keyword.conditional

[
  "do"
  "while"
  "for"
  "continue"
  "break"
] @keyword.repeat

[
  "__nullable__"
  "defined"
  "delete"
  "enum"
  "funcenum"
  "functag"
  "get"
  "methodmap"
  "new"
  "property"
  "public"
  "set"
  "struct"
  "typedef"
  "typeset"
  "void"
] @keyword

[
  "const"
  "native"
  "static"
  "stock"
  "forward"
] @keyword.modifier
