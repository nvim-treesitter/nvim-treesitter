;;; Annotations

(ui_annotation
  "@" @operator
  type_name: [
    (identifier) @attribute
    (nested_identifier (identifier) @attribute)
  ])

;;; Properties

(ui_object_definition_binding
  name: [
    (identifier) @property
    (nested_identifier (identifier) @property)
  ])

(ui_binding
  name: [
    (identifier) @property
    (nested_identifier (identifier) @property)
  ])

;; locals query appears not working unless id: <ref> isn't a parameter.
(ui_binding
  name: (identifier) @property
  (#eq? @property "id")
  value: (expression_statement (identifier) @variable.parameter))

(ui_property
  name: (identifier) @property)

(ui_required
  name: (identifier) @property)

(ui_list_property_type
  ["<" ">"] @punctuation.bracket)

;;; Signals

(ui_signal
  name: (identifier) @function.signal)

(ui_signal_parameter
  (identifier) @variable.parameter)

;;; ui_object_definition
(ui_object_definition
	type_name: (identifier) @type)
(ui_object_definition
	type_name: (nested_identifier) @type)


;;; js
; Special identifiers
;--------------------


(function
  name: (identifier) @function)
(function_declaration
  name: (identifier) @function)
(method_definition
  name: (property_identifier) @function.method)

(pair
  key: (property_identifier) @function.method
  value: [(function) (arrow_function)])

(assignment_expression
  left: (member_expression
    property: (property_identifier) @function.method)
  right: [(function) (arrow_function)])

(variable_declarator
  name: (identifier) @function
  value: [(function) (arrow_function)])

(assignment_expression
  left: (identifier) @function
  right: [(function) (arrow_function)])

; Function and method calls
;--------------------------

(call_expression
  function: (identifier) @function)

(call_expression
  function: (member_expression
    property: (property_identifier) @function.method))

; Variables
;----------

;;;(identifier) @variable

; Properties
;-----------

(property_identifier) @property

; Literals
;---------

(this) @variable.builtin
(super) @variable.builtin

[
  (true)
  (false)
  (null)
  (undefined)
] @constant.builtin

(comment) @comment

[
  (string)
  (template_string)
] @string

(regex) @string.special
(number) @number

; Tokens
;-------

(template_substitution
  "${" @punctuation.special
  "}" @punctuation.special) @embedded

[
  ";"
  "?."
  "."
  ","
] @punctuation.delimiter

[
  "-"
  "--"
  "-="
  "+"
  "++"
  "+="
  "*"
  "*="
  "**"
  "**="
  "/"
  "/="
  "%"
  "%="
  "<"
  "<="
  "<<"
  "<<="
  "="
  "=="
  "==="
  "!"
  "!="
  "!=="
  "=>"
  ">"
  ">="
  ">>"
  ">>="
  ">>>"
  ">>>="
  "~"
  "^"
  "&"
  "|"
  "^="
  "&="
  "|="
  "&&"
  "||"
  "??"
  "&&="
  "||="
  "??="
] @operator

[
  "("
  ")"
  "["
  "]"
  "{"
  "}"
]  @punctuation.bracket

[
  "as"
  "async"
  "await"
  "break"
  "case"
  "catch"
  "class"
  "const"
  "continue"
  "debugger"
  "default"
  "delete"
  "do"
  "else"
  "export"
  "extends"
  "finally"
  "for"
  "from"
  "function"
  "get"
  "if"
  "import"
  "in"
  "instanceof"
  "let"
  "new"
  "of"
  "return"
  "set"
  "static"
  "switch"
  "target"
  "throw"
  "try"
  "typeof"
  "var"
  "void"
  "while"
  "with"
  "yield"
] @keyword


