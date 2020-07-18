
(method_declaration
  name: (identifier) @method)

(parameter_list
  (parameter
   name: (identifier) @parameter))

[
 (integer_literal)
 (real_literal)
] @number

(null_literal) @constant.builtin
(character_literal) @character

[
 (string_literal)
 (interpolated_string_text)
] @string

(boolean_literal) @boolean

[
 (predefined_type)
 (implicit_type)
 (void_keyword)
] @type.builtin

(comment) @comment

(using_directive
  (identifier) @type)

(using_directive
  (qualified_name
    (identifier) @type))

(interface_declaration
  name: (identifier) @type)
(class_declaration
  name: (identifier) @type)
(enum_declaration
  name: (identifier) @type)
(constructor_declaration
  name: (identifier) @type)
(variable_declaration
  (identifier) @type)

(object_creation_expression
  (identifier) @type)

(attribute
 name: (identifier) @attribute)

[
 "if"
 "else"
 "switch"
 "case"
] @conditional

[
 "while"
 "for"
 "do"
 "continue"
 "break"
 "goto"
 "foreach"
] @repeat

[
 "try"
 "catch"
 "throw"
 "finally"
] @exception

[
 ";"
 "."
 ","
 ":"
] @punctuation.delimiter

[
 "["
 "]"
 "{"
 "}"
 "("
 ")"
] @punctuation.bracket

[
 "using"
 "lock"
 "params"
 "ref"
 "sizeof"
 "operator"
 "is"
 "as"
 "new"
 "default"
 "yield"
 "return"
 "typeof"
 "abstract"
 "const"
 "extern"
 "internal"
 "override"
 "private"
 "protected"
 "public"
 "readonly"
 "sealed"
 "static"
 "virtual"
 "volatile"
 "async"
 "await"
 "class"
 "delegate"
 "enum"
 "interface"
 "namespace"
 "struct"
] @keyword

