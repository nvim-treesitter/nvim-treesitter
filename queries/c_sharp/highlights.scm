(identifier) @variable

(method_declaration
  name: (identifier) @method)

(method_declaration
  type: (identifier) @type)

; This would be nice but fails in some cases
; https://github.com/nvim-treesitter/nvim-treesitter/pull/203
; (invocation_expression
;     (member_access_expression
;            name: (identifier) @method))

; (invocation_expression
;      (identifier) @method)

((identifier) @field
 (#match? @field "^_"))

((identifier) @field
 (#match? @field "^m_"))

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

(qualified_name
  (identifier) @type)
(property_declaration
  name: (identifier) @property)

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

(base_list
  (identifier) @type)

(type_argument_list
 (identifier) @type)

(attribute
 name: (identifier) @attribute)

[
 "if"
 "else"
 "switch"
 "break"
 "case"
] @conditional

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
] @keyword

