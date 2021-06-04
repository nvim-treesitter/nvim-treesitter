(identifier) @variable

(method_declaration
  name: (identifier) @method)

(method_declaration
  type: (identifier) @type)

(interpolation) @none

(invocation_expression
  (member_access_expression
    name: (identifier) @method))

(invocation_expression
  function: (conditional_access_expression
    (member_binding_expression
      name: (identifier) @method)))

(namespace_declaration
  name: [(qualified_name) (identifier)] @namespace)

(qualified_name
  (identifier) @type)

(invocation_expression
      (identifier) @method)

(field_declaration
  (variable_declaration
    (variable_declarator
      (identifier) @field)))

(initializer_expression
  (assignment_expression
    left: (identifier) @field))

(parameter_list
  (parameter
   name: (identifier) @parameter))

(parameter_list
  (parameter
   type: (identifier) @type))

(integer_literal) @number
(real_literal) @float

(null_literal) @constant.builtin
(character_literal) @character

[
 (string_literal)
 (verbatim_string_literal)
 (interpolated_string_expression)
] @string

(boolean_literal) @boolean

[
 (predefined_type)
 (void_keyword)
] @type.builtin

(implicit_type) @keyword

(comment) @comment

(using_directive
  (identifier) @type)

(property_declaration
  name: (identifier) @property)

(property_declaration
  type: (identifier) @type)

(nullable_type
  (identifier) @type)

(catch_declaration
  type: (identifier) @type)

(interface_declaration
  name: (identifier) @type)
(class_declaration
  name: (identifier) @type)
(enum_declaration
  name: (identifier) @type)
(constructor_declaration
  name: (identifier) @constructor)

(variable_declaration
  (identifier) @type)
(object_creation_expression
  (identifier) @type)

(generic_name
  (identifier) @type)

(invocation_expression
  (member_access_expression
    (generic_name
      (identifier) @method)))

(base_list
  (identifier) @type)

(type_argument_list
 (identifier) @type)

(type_parameter_list
  (type_parameter) @type)

(type_parameter_constraints_clause
  target: (identifier) @type)

(attribute
 name: (identifier) @attribute)

(for_each_statement
  type: (identifier) @type)

(warning_directive) @text.warning
(error_directive) @exception

(define_directive
  (identifier) @constant) @constant.macro
(undef_directive
  (identifier) @constant) @constant.macro

(line_directive) @constant.macro
(line_directive
  (preproc_integer_literal) @constant
  (preproc_string_literal)? @string)

(pragma_directive
  (identifier) @constant) @constant.macro
(pragma_directive
  (preproc_string_literal) @string) @constant.macro

[
 (nullable_directive)
 (region_directive)
 (endregion_directive)
] @constant.macro

[
 "if"
 "else"
 "switch"
 "break"
 "case"
 (if_directive)
 (elif_directive)
 (else_directive)
 (endif_directive)
] @conditional

(if_directive
  (identifier) @constant)
(elif_directive
  (identifier) @constant)

[
 "while"
 "for"
 "do"
 "continue"
 "in"
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
 "+"
 "?"
 ":"
 "++"
 "-"
 "--"
 "&"
 "&&"
 "|"
 "||"
 "!"
 "!="
 "=="
 "*"
 "/"
 "%"
 "<"
 "<="
 ">"
 ">="
 "="
 "-="
 "+="
 "*="
 "/="
 "%="
 "^"
 "^="
 "&="
 "|="
 "~"
 ">>"
 "<<"
 "<<="
 ">>="
 "=>"
] @operator

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
 "<"
 ">"
] @punctuation.bracket

[
 (this_expression)
 (base_expression)
] @variable.builtin

[
 "using"
] @include

[
 "with"
 "new"
 "typeof"
 "sizeof"
 "ref"
 "is"
 "as"
] @keyword.operator

[
 "lock"
 "params"
 "operator"
 "default"
 "yield"
 "return"
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
 "get"
 "set"
 "where"
] @keyword

