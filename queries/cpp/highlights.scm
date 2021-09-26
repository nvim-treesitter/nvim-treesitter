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

(template_method
  name: (field_identifier) @method)

(((field_expression
     (field_identifier) @method)) @_parent
 (#has-parent? @_parent template_method function_declarator call_expression))

(field_initializer
 (field_identifier) @property)

(function_declarator
  declarator: (field_identifier) @method)


(namespace_identifier) @namespace
((namespace_identifier) @type
                        (#match? @type "^[A-Z]"))
((namespace_identifier) @constant
                        (#match? @constant "^[A-Z][A-Z_0-9]*$"))
(namespace_definition
  name: (identifier) @namespace)

(using_declaration . "using" . "namespace" . [(qualified_identifier) (identifier)] @namespace)

(destructor_name
  (identifier) @method)

(function_declarator
      declarator: (qualified_identifier
        name: (identifier) @function))
((function_declarator
      declarator: (qualified_identifier
        name: (identifier) @constructor))
 (#match? @constructor "^[A-Z]"))

(operator_name) @function
"static_assert" @function.builtin

(call_expression
  function: (qualified_identifier
              name: (identifier) @function))

(call_expression
  function: (field_expression
              field: (field_identifier) @function))

((call_expression
  function: (identifier) @constructor)
(#match? @constructor "^[A-Z]"))
((call_expression
  function: (qualified_identifier
              name: (identifier) @constructor))
(#match? @constructor "^[A-Z]"))

((call_expression
  function: (field_expression
              field: (field_identifier) @constructor))
(#match? @constructor "^[A-Z]"))

;; constructing a type in an initializer list: Constructor ():  **SuperType (1)**
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
 "co_await"
 (auto)
] @keyword

[
 "co_yield"
 "co_return"
] @keyword.return

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

(attribute_declaration) @attribute
