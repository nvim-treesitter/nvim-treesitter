[
  "["
  "]"
  "{"
  "}"
  "("
  ")"
] @punctuation.bracket

[
  ";"
  ";"
  "."
 ] @punctuation.delimiter

;; Methods

(method_declaration
  name: (identifier) @method)

(method_declaration
  type: (type_identifier) @type)

(method_invocation
  name: (identifier) @method.call)

(argument_list
  (identifier) @variable)

(super) @function.builtin

(explicit_constructor_invocation
  arguments: (argument_list
    (identifier) @variable ))

;; Annotations

(annotation
  name: (identifier) @attribute)

(annotation_key_value
  (identifier) @variable)


;; Types

(interface_declaration
  name: (identifier) @type)
(class_declaration
  name: (identifier) @type)
(class_declaration
  (superclass) @type) 
(enum_declaration
  name: (identifier) @type)
(enum_constant
  name: (identifier) @constant)

(interfaces
  (type_list
    (type_identifier) @type));;

(local_variable_declaration
  (type_identifier) @variable)

(expression_statement (_ (identifier)) @variable)

(type_arguments "<" @punctuation.delimiter)
(type_arguments ">" @punctuation.delimiter)

; (identifier) @variable

((field_access
  object: (identifier) @type)) ;; don't know what type of thing it is

(generic_type
  (type_identifier) @type)
(type_arguments (type_identifier) @type)

(field_access
  field: (identifier) @property)

((scoped_identifier
  scope: (identifier) @type)
 (#match? @type "^[A-Z]"))
((method_invocation
  object: (identifier) @type)
 (#match? @type "^[A-Z]"))


(field_declaration
  type: (type_identifier) @type)

(method_declaration
  (formal_parameters
    (formal_parameter
      name: (identifier) @parameter)))

(formal_parameter
  type: (type_identifier) @type
  (identifier) @variable)

(enhanced_for_statement
  type: (type_identifier) @type
  name: (identifier) @variable )

(enhanced_for_statement
  value: (identifier) @variable)

(enhanced_for_statement
  name: (identifier) @variable)

(object_creation_expression
  type: (type_identifier) @type)

(array_creation_expression
  type: (type_identifier) @type)

(array_type
  element: (type_identifier) @type)

(catch_formal_parameter
  (type_identifier) @type
  name: (identifier) @variable)

(return_statement
  (identifier) @variable)

(local_variable_declaration
  (variable_declarator
    name: (identifier) @variable ))

(for_statement
  condition: (binary_expression
    (identifier) @variable))

(for_statement
  update: (update_expression
    (identifier) @variable))

(constructor_declaration
  name: (identifier) @constructor)

(dml_type) @function.builtin;;

(bound_apex_expression
  (identifier) @variable)

(assignment_operator) @operator

(update_expression ["++" "--"] @operator)

(instanceof_expression
  left: (identifier) @variable
  right: (type_identifier) @type )

(cast_expression
  type: (type_identifier) @type
  value: (identifier) @variable)

(switch_expression
  condition: (identifier) @variable)

(switch_label
  (type_identifier) @type
  (identifier) @variable )

(switch_rule
  (switch_label
    (identifier) @variable ))

(trigger_declaration
  name: (identifier) @type
  object: (identifier) @type
  (trigger_event) @keyword
  ("," (trigger_event) @keyword)*)

"@" @operator

(binary_expression
  operator: [
    ">"
    "<"
    ">="
    "<="
    "=="
    "==="
    "!="
    "!=="
    "&&"
    "||"
    "+"
    "-"
    "*"
    "/"
    "&"
    "|"
    "^"
    "%"
    "<<"
    ">>"
    ">>>"] @operator)

(binary_expression
  (identifier) @variable)

(unary_expression
  operator: [
    "+"
    "-"
    "!"
    "~"
  ]) @operator

(map_initializer "=>" @operator)

[
  (boolean_type)
  (void_type)
] @type.builtin;;

; Fields

(field_declaration
  declarator: (variable_declarator
    name: (identifier) @field))

(field_access
  field: (identifier) @field)

; Variables

(field_declaration
  (modifiers (modifier ["final" "static"])(modifier ["final" "static"]))
  (variable_declarator
    name: (identifier) @constant))

(variable_declarator
  (identifier) @property)

((identifier) @constant
  (#lua-match? @constant "^[A-Z][A-Z0-9_]+$")) ; SCREAM SNAKE CASE

(this) @variable.builtin

; Literals

[
  (int)
] @number

[
  (string_literal)
] @string

[
  (line_comment)
  (block_comment)
] @comment

(null_literal) @constant.builtin

;; ;; Keywords

[
 "abstract"
 "final"
 "private"
 "protected"
 "public"
 "static"
 ] @type.qualifier

[
  "if"
  "else"
  "switch"
] @conditional

[
  "for"
  "while"
  "do"
  "break"
] @repeat

[
  "return"
] @keyword.return

[
 "throw"
 "finally"
 "try"
 "catch"
 ] @exception

[
 "new"
] @keyword.operator

[
  "abstract"
  "class"
  "continue"
  "default"
  "enum"
  "extends"
  "final"
  "get"
  "global"
  "implements"
  "instanceof"
  "interface"
  "on"
  "private"
  "protected"
  "public"
  "set"
  "static"
  "testMethod"
  "transient"
  "trigger"
  "virtual"
  "when"
  "with_sharing"
  "without_sharing"
  "inherited_sharing"
] @keyword

(assignment_expression
  left: (identifier) @variable)

; (type_identifier) @type ;; not respecting precedence...
;; I don't love this but couldn't break them up right now
;; can't figure out how to let that be special without conflicting
;; in the grammar
"System.runAs" @type.builtin

(scoped_type_identifier
  (type_identifier) @type)
