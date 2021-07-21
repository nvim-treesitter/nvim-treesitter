; inherits: c

((identifier) @field
 (#match? @field "(^_|^m_|_$)"))

(parameter_declaration
  declarator: (reference_declarator) @parameter)
; function(Foo ...foo)
(variadic_parameter_declaration
  declarator: (variadic_declarator
                (_) @parameter))
; int foo = 0
(optional_parameter_declaration
    declarator: (_) @parameter)

;(field_expression) @parameter ;; How to highlight this?
(template_function
  name: (identifier) @function)

(((field_expression
     (field_identifier) @method)) @_parent
 (#has-parent? @_parent template_method function_declarator call_expression))

(field_initializer
 (field_identifier) @property)

(function_declarator
  declarator: (field_identifier) @method)

(template_function
  name: (scoped_identifier
    name: (identifier) @function))


(namespace_identifier) @namespace
((namespace_identifier) @type
                        (#match? @type "^[A-Z]"))
((namespace_identifier) @constant
                        (#match? @constant "^[A-Z][A-Z_0-9]*$"))
(namespace_definition
  name: (identifier) @namespace)

(using_declaration . "using" . "namespace" . [(scoped_identifier) (identifier)] @namespace)

(destructor_name
  (identifier) @method)

(function_declarator
      declarator: (scoped_identifier
        name: (identifier) @function))
((function_declarator
      declarator: (scoped_identifier
        name: (identifier) @constructor))
 (#match? @constructor "^[A-Z]"))

(operator_name) @function
"static_assert" @function.builtin

(call_expression
  function: (scoped_identifier
              name: (identifier) @function))

(call_expression
  function: (field_expression
              field: (field_identifier) @function))

((call_expression
  function: (identifier) @constructor)
(#match? @constructor "^[A-Z]"))
((call_expression
  function: (scoped_identifier
              name: (identifier) @constructor))
(#match? @constructor "^[A-Z]"))

((call_expression
  function: (field_expression
              field: (field_identifier) @constructor))
(#match? @constructor "^[A-Z]"))

;; constructing a type in a intizializer list: Constructor ():  **SuperType (1)**
((field_initializer
  (field_identifier) @constructor
  (argument_list))
 (#match? @constructor "^[A-Z]"))


; Constants

(this) @variable.builtin
(nullptr) @constant

(true) @boolean
(false) @boolean

; Literals

(raw_string_literal)  @string

; Keywords

[
 "try"
 "catch"
 "noexcept"
 "throw"
] @exception


[
 "class"
 "decltype"
 "constexpr"
 "explicit"
 "final"
 "friend"
 "mutable"
 "namespace"
 "override"
 "private"
 "protected"
 "public"
 "template"
 "typename"
 "using"
 "virtual"
 (auto)
] @keyword

[
 "new"
 "delete"

 ;; these keywords are not supported by the parser
 ;"eq"
 ;"not_eq"
 ;
 ;"compl"
 ;"and"
 ;"or"
 ;
 ;"bitand"
 ;"bitand_eq"
 ;"bitor"
 ;"bitor_eq"
 ;"xor"
 ;"xor_eq"
] @keyword.operator

"::" @operator

; Annotations (not fully supported by parser)

((ERROR) @attribute
         (#vim-match? @attribute  "\[?\[.*\]\]?.*$"))
(attribute) @attribute
