;;; SOQL 

(field_identifier
  (identifier) @property)

(field_identifier
  (dotted_identifier
    (identifier) @property))

(type_of_clause
  (identifier) @property)

(when_expression
  (identifier) @type)

(when_expression
  (field_list
    (identifier) @property))

(when_expression
  (field_list
    (dotted_identifier
      (identifier) @property )))

(else_expression
  (field_list
    (identifier) @property ))

(else_expression
  (field_list
    (dotted_identifier
      (identifier) @property )))

(alias_expression
  (identifier) @label)

(storage_identifier) @storageclass
(function_name) @function
(date_literal) @string.special

(value_comparison_operator  [ "<" ">" ] @operator)

(set_comparison_operator "IN" @keyword.operator)

(date) @variable.readonly
(date_time) @variable.readonly

[
  "TRUE"
  "FALSE"
] @boolean

[
  "ABOVE"
  "ABOVE_OR_BELOW"
  "ALL_ROWS"
  "ALL"
  "AS"
  "ASC"
  "AT"
  "BELOW"
  "CUSTOM"
  "DATA_CATEGORY"
  "DESC"
  "END"
  "FIELDS"
  "FOR"
  "FROM"
  "GROUP_BY"
  "HAVING"
  "LIMIT"
  "NULLS_FIRST"
  "NULLS_LAST"
  "OFFSET"
  "ORDER_BY"
  "REFERENCE"
  "SELECT"
  "STANDARD"
  "TRACKING"
  "TYPEOF"
  "UPDATE"
  "USING_SCOPE"
  "VIEW"
  "VIEWSTAT"
  "WITH"
] @keyword

[
  "WHERE"
  "WHEN"
  "ELSE"
  "THEN"
] @conditional

; Using Scope
[
  "delegated"
  "everything"
  "mine"
  "mine_and_my_groups"
  "my_territory"
  "my_team_territory"
  "team"
] @keyword

; With
[
  "maxDescriptorPerRecord"
  "RecordVisibilityContext"
  "Security_Enforced"
  "supportsDomains"
  "supportsDelegates"
  "System_Mode"
  "User_Mode"
  "UserId"
] @keyword

;;; Apex + SOQL

[
  "["
  "]"
  "{"
  "}"
  "("
  ")"
] @punctuation.bracket

[
  ","
  "."
  ":"
  "?"
  ";"
  "."
 ] @punctuation.delimiter

;; Default general color defination

(identifier) @variable

(type_identifier) @type

;; Methods

(method_declaration
  name: (identifier) @method)

(method_invocation
  name: (identifier) @method.call)

(super) @function.builtin

;; Annotations

(annotation
  name: (identifier) @attribute)

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

(type_arguments "<" @punctuation.delimiter)
(type_arguments ">" @punctuation.delimiter)

((field_access
  object: (identifier) @type))

(field_access
  field: (identifier) @property)

((scoped_identifier
  scope: (identifier) @type)
 (#match? @type "^[A-Z]"))

((method_invocation
  object: (identifier) @type)
 (#match? @type "^[A-Z]"))

(method_declaration
  (formal_parameters
    (formal_parameter
      name: (identifier) @parameter)))

(constructor_declaration
  name: (identifier) @constructor)

(dml_type) @function.builtin

(assignment_operator) @operator

(update_expression ["++" "--"] @operator)

(trigger_declaration
  name: (identifier) @type
  object: (identifier) @type
  (trigger_event) @keyword
  ("," (trigger_event) @keyword)*)

[
  "@" 
  "="
  "!="
  "<="
  ">="
] @operator

(binary_expression
  operator: [
    ">"
    "<"
    "=="
    "==="
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
  (decimal)
  (currency_literal)
] @number

(string_literal) @string

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
  "WHERE"
  "WHEN"
  "ELSE"
  "THEN"
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
  "AND"
  "OR"
  "NOT"
  "LIKE"
  "NOT_IN"
  "INCLUDES"
  "EXCLUDES"
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

"System.runAs" @type.builtin
