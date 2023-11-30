(use_directive
 "use" @keyword)
(use_clause
 "as" @keyword)

(use_clause
  [
    (type_name)
    (simple_type_name)
  ] @type)

[
  "true"
  "false"
] @boolean

[
 "nil"
] @constant.builtin

[
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

[
 "def"
] @keyword.function

(include_member "include" @function.method)  
(extend_member "extend" @function.method)  
(prepend_member "prepend" @function.method)  

(visibility) @type.qualifier

(comment) @comment

(method_member
  (method_name
    [
     (identifier)
     (constant)
     (operator)
     (setter)
    ] @function.method))

(ivar_member (ivar_name) @property)
(ivar_member (cvar_name) @property)

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

(parameter (var_name) @variable.parameter)

(keyword) @variable.parameter

(self) @variable.builtin

(type (symbol_literal) @symbol)

(type (string_literal (escape_sequence) @string.escape))
(type (string_literal) @string)

(type (integer_literal) @number)

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
