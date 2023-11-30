; Use directive

(use_clause
  [
    (type_name)
    (simple_type_name)
  ] @type)

; Buitin constants and Keywords

[
  "true"
  "false"
] @boolean

"nil" @constant.builtin

[
  "use"
  "as"
  "class"
  "module"
  "interface"
  "type"
  "def"
  "attr_reader"
  "attr_writer"
  "attr_accessor"
  "end"
  "alias"
] @keyword

"def" @keyword.function

; Members of declaration

[
 "include"
 "extend"
 "prepend"
] @function.method

(visibility) @type.qualifier

(comment) @comment @spell

(method_member
  (method_name
    [
     (identifier)
     (constant)
     (operator)
     (setter)
    ] @method))

[(ivar_name) (cvar_name)] @property

(alias_member (method_name) @function)

(class_name (constant) @type)
(module_name (constant) @type)
(interface_name (interface) @type)
(alias_name (identifier) @type)
(type_variable) @constant
(namespace (constant) @namespace)

(builtin_type) @type.builtin

(const_name (constant) @constant)
(global_name) @property

; Standard Arguments
(parameter (var_name) @parameter)

; Keyword Arguments
(keyword) @parameter

; Self
(self) @variable.builtin

; Literal
(type (symbol_literal) @symbol)

(type (string_literal (escape_sequence) @string.escape))
(type (string_literal) @string)

(type (integer_literal) @number)

; Operators

[
 "="
 "->"
 "<"
 "**"
 "*"
 "&"
 "|"
 "^"
 ] @operator

; Punctuation

[
 "("
 ")"
 "["
 "]"
 "{"
 "}"
 ] @punctuation.bracket


[
 ","
 "."
 ] @punctuation.delimiter
