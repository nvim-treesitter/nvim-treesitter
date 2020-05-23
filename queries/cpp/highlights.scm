((identifier) @field
 (match? @field "^_"))

((identifier) @field
 (match? @field "^m_"))

((identifier) @field
 (match? @field "_$"))

;(field_expression) @parameter ;; How to highlight this?
(template_function
  name: (identifier) @function)

(template_method
  name: (field_identifier) @method)

(template_function
  name: (scoped_identifier
    name: (identifier) @function))

(namespace_identifier) @constant

((namespace_identifier) @type
                        (match? @type "^[A-Z]"))
((namespace_identifier) @constant
                        (match? @constant "^[A-Z][A-Z_1-9]*$"))

(destructor_name
  name: (*) @function)

(function_declarator
      declarator: (scoped_identifier
        name: (identifier) @function))
((function_declarator
      declarator: (scoped_identifier
        name: (identifier) @constructor))
 (match? @constructor "^[A-Z]"))

(call_expression
  function: (scoped_identifier 
              name: (identifier) @function))

(call_expression
  function: (field_expression 
              field: (field_identifier) @function))

((call_expression
  function: (scoped_identifier 
              name: (identifier) @constructor))
(match? @constructor "^[A-Z]"))

((call_expression
  function: (field_expression 
              field: (field_identifier) @function))
(match? @function "^[A-Z]"))

;; constructing a type in a intizializer list: Constructor ():  **SuperType (1)**
((field_initializer
  (field_identifier) @constructor
  (argument_list))
 (match? @constructor "^[A-Z]"))

(auto) @keyword

;; Parameters
; normals
(parameter_list
  (parameter_declaration) @parameter)

; Constants

;(this) @constant.builtin
(this) @keyword
(nullptr) @constant

(true) @boolean
(false) @boolean

; Keywords

"catch" @exception
"class" @keyword
"constexpr" @keyword
"delete" @keyword
"explicit" @keyword
"final" @exception
"friend" @keyword
"mutable" @keyword
"namespace" @keyword
"noexcept" @keyword
"new" @keyword
"override" @keyword
"private" @keyword
"protected" @keyword
"public" @keyword
"template" @keyword
"throw" @keyword
"try" @exception
"typename" @keyword
"using" @keyword
"virtual" @keyword
"::" @operator
