; inherits: ecma

;;; Annotations

(ui_annotation
  "@" @operator
  type_name: [
    (identifier) @attribute
    (nested_identifier (identifier) @attribute)
  ])

;; type
(ui_property 
  type: (type_identifier) @type)

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
  value: (expression_statement (identifier) @variable))

(ui_property
  name: (identifier) @property)

(ui_required
  name: (identifier) @property)

(ui_list_property_type
  ["<" ">"] @punctuation.bracket)

;;; Signals

(ui_signal
  name: (identifier) @function)

(ui_signal_parameter
  (identifier) @variable)

;;; ui_object_definition
(ui_object_definition
	type_name: (identifier) @type)
(ui_object_definition
	type_name: (nested_identifier) @type)


;;; js

; Properties
;-----------

(property_identifier) @property

; Literals
;---------

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



;;; keywrod in qml
[
  "required"
  "property"
  "signal"
] @keyword

; from typescript

(type_identifier) @type
(predefined_type) @type.builtin

((identifier) @type
 (#match? @type "^[A-Z]"))

(type_arguments
  "<" @punctuation.bracket
  ">" @punctuation.bracket)

; Variables

(required_parameter (identifier) @variable)
(optional_parameter (identifier) @variable)

; Keywords

[ "abstract"
  "declare"
  "enum"
  "export"
  "implements"
  "interface"
  "keyof"
  "namespace"
  "private"
  "protected"
  "public"
  "type"
  "readonly"
  "override"
] @keyword

