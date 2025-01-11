(razor_comment) @comment @spell

(razor_page_directive) @constant.macro

(razor_rendermode_directive) @constant.macro

(razor_rendermode) @property

(razor_inject_directive) @constant.macro

(razor_implicit_expression) @variable

(razor_html_attribute) @function

(razor_attribute_value
  (identifier) @function)

; HTML RULES
(tag_name) @tag

(comment) @comment @spell

(html_attribute_name) @tag.attribute

((html_attribute
  (html_attribute_value) @string)
  (#set! priority 99))

(html_text) @none @spell

((element
  (start_tag
    (tag_name) @_tag)
  (html_text) @markup.heading)
  (#eq? @_tag "title"))

((element
  (start_tag
    (tag_name) @_tag)
  (html_text) @markup.heading.1)
  (#eq? @_tag "h1"))

((element
  (start_tag
    (tag_name) @_tag)
  (html_text) @markup.heading.2)
  (#eq? @_tag "h2"))

((element
  (start_tag
    (tag_name) @_tag)
  (html_text) @markup.heading.3)
  (#eq? @_tag "h3"))

((element
  (start_tag
    (tag_name) @_tag)
  (html_text) @markup.heading.4)
  (#eq? @_tag "h4"))

((element
  (start_tag
    (tag_name) @_tag)
  (html_text) @markup.heading.5)
  (#eq? @_tag "h5"))

((element
  (start_tag
    (tag_name) @_tag)
  (html_text) @markup.heading.6)
  (#eq? @_tag "h6"))

((element
  (start_tag
    (tag_name) @_tag)
  (html_text) @markup.strong)
  (#any-of? @_tag "strong" "b"))

((element
  (start_tag
    (tag_name) @_tag)
  (html_text) @markup.italic)
  (#any-of? @_tag "em" "i"))

((element
  (start_tag
    (tag_name) @_tag)
  (html_text) @markup.strikethrough)
  (#any-of? @_tag "s" "del"))

((element
  (start_tag
    (tag_name) @_tag)
  (html_text) @markup.underline)
  (#eq? @_tag "u"))

((element
  (start_tag
    (tag_name) @_tag)
  (html_text) @markup.raw)
  (#any-of? @_tag "code" "kbd"))

((element
  (start_tag
    (tag_name) @_tag)
  (html_text) @markup.link.label)
  (#eq? @_tag "a"))

; ((attribute
;   (html_attribute_name) @_attr
;   (quoted_attribute_value
;     (attribute_value) @string.special.url))
;   (#any-of? @_attr "href" "src")
;   (#set! @string.special.url url @string.special.url))
[
  "<"
  ">"
  "</"
] @tag.delimiter

"=" @operator

; CSHARP RULES
((identifier) @keyword
  (#eq? @keyword "value")
  (#has-ancestor? @keyword accessor_declaration))

(method_declaration
  name: (identifier) @function.method)

(local_function_statement
  name: (identifier) @function.method)

(method_declaration
  returns: [
    (identifier) @type
    (generic_name
      (identifier) @type)
  ])

(event_declaration
  type: (identifier) @type)

(event_declaration
  name: (identifier) @variable.member)

(event_field_declaration
  (variable_declaration
    (variable_declarator
      name: (identifier) @variable.member)))

(declaration_pattern
  type: (identifier) @type)

(local_function_statement
  type: (identifier) @type)

(interpolation) @none

(member_access_expression
  name: (identifier) @variable.member)

(invocation_expression
  (member_access_expression
    name: (identifier) @function.method.call))

(invocation_expression
  function: (conditional_access_expression
    (member_binding_expression
      name: (identifier) @function.method.call)))

(namespace_declaration
  name: [
    (qualified_name)
    (identifier)
  ] @module)

(qualified_name
  (identifier) @type)

(namespace_declaration
  name: (identifier) @module)

(file_scoped_namespace_declaration
  name: (identifier) @module)

(qualified_name
  (identifier) @module
  (#not-has-ancestor? @module method_declaration)
  (#not-has-ancestor? @module record_declaration)
  (#has-ancestor? @module namespace_declaration file_scoped_namespace_declaration))

(invocation_expression
  (identifier) @function.method.call)

(field_declaration
  (variable_declaration
    (variable_declarator
      (identifier) @variable.member)))

(initializer_expression
  (assignment_expression
    left: (identifier) @variable.member))

(parameter
  name: (identifier) @variable.parameter)

(parameter_list
  name: (identifier) @variable.parameter)

(bracketed_parameter_list
  name: (identifier) @variable.parameter)

(implicit_parameter) @variable.parameter

(parameter_list
  (parameter
    type: (identifier) @type))

(integer_literal) @number

(real_literal) @number.float

(null_literal) @constant.builtin

(calling_convention
  [
    (identifier)
    "Cdecl"
    "Stdcall"
    "Thiscall"
    "Fastcall"
  ] @attribute.builtin)

(character_literal) @character

[
  (string_literal)
  (raw_string_literal)
  (verbatim_string_literal)
  (interpolated_string_expression)
] @string

(escape_sequence) @string.escape

[
  "true"
  "false"
] @boolean

(predefined_type) @type.builtin

(implicit_type) @keyword

(comment) @comment @spell

((comment) @comment.documentation
  (#lua-match? @comment.documentation "^/[*][*][^*].*[*]/$"))

((comment) @comment.documentation
  (#lua-match? @comment.documentation "^///[^/]"))

((comment) @comment.documentation
  (#lua-match? @comment.documentation "^///$"))

(using_directive
  (identifier) @type)

(using_directive
  (type) @type.definition)

(property_declaration
  name: (identifier) @property)

(property_declaration
  type: (identifier) @type)

(nullable_type
  type: (identifier) @type)

(array_type
  type: (identifier) @type)

(ref_type
  type: (identifier) @type)

(pointer_type
  type: (identifier) @type)

(catch_declaration
  type: (identifier) @type)

(interface_declaration
  name: (identifier) @type)

(class_declaration
  name: (identifier) @type)

(record_declaration
  name: (identifier) @type)

(struct_declaration
  name: (identifier) @type)

(enum_declaration
  name: (identifier) @type)

(enum_member_declaration
  name: (identifier) @variable.member)

(operator_declaration
  type: (identifier) @type)

(conversion_operator_declaration
  type: (identifier) @type)

(explicit_interface_specifier
  [
    (identifier) @type
    (generic_name
      (identifier) @type)
  ])

(explicit_interface_specifier
  (identifier) @type)

(primary_constructor_base_type
  type: (identifier) @type)

[
  "assembly"
  "module"
  "this"
  "base"
] @variable.builtin

(constructor_declaration
  name: (identifier) @constructor)

(destructor_declaration
  name: (identifier) @constructor)

(constructor_initializer
  "base" @constructor)

(variable_declaration
  (identifier) @type)

(object_creation_expression
  (identifier) @type)

; Generic Types.
(typeof_expression
  (generic_name
    (identifier) @type))

(type_argument_list
  (generic_name
    (identifier) @type))

(base_list
  (generic_name
    (identifier) @type))

(type_parameter_constraint
  [
    (identifier) @type
    (type
      (generic_name
        (identifier) @type))
  ])

(object_creation_expression
  (generic_name
    (identifier) @type))

(property_declaration
  (generic_name
    (identifier) @type))

(_
  type: (generic_name
    (identifier) @type))

; Generic Method invocation with generic type
(invocation_expression
  function: (generic_name
    .
    (identifier) @function.method.call))

(invocation_expression
  (member_access_expression
    (generic_name
      (identifier) @function.method)))

(base_list
  (identifier) @type)

(type_argument_list
  (identifier) @type)

(type_parameter_list
  (type_parameter) @type)

(type_parameter
  name: (identifier) @type)

(type_parameter_constraints_clause
  "where"
  .
  (identifier) @type)

(attribute
  name: (identifier) @attribute)

(foreach_statement
  type: (identifier) @type)

(goto_statement
  (identifier) @label)

(labeled_statement
  (identifier) @label)

(tuple_element
  type: (identifier) @type)

(tuple_expression
  (argument
    (declaration_expression
      type: (identifier) @type)))

(cast_expression
  type: (identifier) @type)

(lambda_expression
  type: (identifier) @type)

(as_expression
  right: (identifier) @type)

(typeof_expression
  (identifier) @type)

[
  "if"
  "else"
  "switch"
  "break"
  "case"
  "when"
] @keyword.conditional

[
  "while"
  "for"
  "do"
  "continue"
  "goto"
  "foreach"
] @keyword.repeat

[
  "try"
  "catch"
  "throw"
  "finally"
] @keyword.exception

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
  ">>>"
  "<<"
  "<<="
  ">>="
  ">>>="
  "=>"
  "??"
  "??="
  ".."
] @operator

(list_pattern
  ".." @character.special)

(discard) @character.special

[
  ";"
  "."
  ","
  ":"
] @punctuation.delimiter

(conditional_expression
  [
    "?"
    ":"
  ] @keyword.conditional.ternary)

[
  "["
  "]"
  "{"
  "}"
  "("
  ")"
] @punctuation.bracket

(interpolation_brace) @punctuation.special

(type_argument_list
  [
    "<"
    ">"
  ] @punctuation.bracket)

[
  "using"
  "as"
] @keyword.import

(alias_qualified_name
  (identifier
    "global") @keyword.import)

[
  "with"
  "new"
  "typeof"
  "sizeof"
  "is"
  "and"
  "or"
  "not"
  "stackalloc"
  "__makeref"
  "__reftype"
  "__refvalue"
  "in"
  "out"
  "ref"
] @keyword.operator

[
  "lock"
  "params"
  "operator"
  "default"
  "implicit"
  "explicit"
  "override"
  "get"
  "set"
  "init"
  "where"
  "add"
  "remove"
  "checked"
  "unchecked"
  "fixed"
  "alias"
  "file"
  "unsafe"
] @keyword

(attribute_target_specifier
  .
  _ @keyword)

[
  "enum"
  "record"
  "class"
  "struct"
  "interface"
  "namespace"
  "event"
  "delegate"
] @keyword.type

[
  "async"
  "await"
] @keyword.coroutine

[
  "const"
  "extern"
  "readonly"
  "static"
  "volatile"
  "required"
  "managed"
  "unmanaged"
  "notnull"
  "abstract"
  "private"
  "protected"
  "internal"
  "public"
  "partial"
  "sealed"
  "virtual"
  "global"
] @keyword.modifier

(scoped_type
  "scoped" @keyword.modifier)

(query_expression
  (_
    [
      "from"
      "orderby"
      "select"
      "group"
      "by"
      "ascending"
      "descending"
      "equals"
      "let"
    ] @keyword))

[
  "return"
  "yield"
] @keyword.return
