; inherits: c

;; Parameters
(variadic_parameter_declaration
  declarator: (variadic_declarator
                (identifier) @definition.parameter))
(optional_parameter_declaration
  declarator: (identifier) @definition.parameter)

;; Class / struct defintions
(class_specifier) @scope

(reference_declarator
  (identifier) @definition.var)

(variadic_declarator
  (identifier) @definition.var)

(struct_specifier
  name: (scoped_type_identifier
          name: (type_identifier) @definition.type))

(class_specifier
  name: (type_identifier) @definition.type)

(class_specifier
  name: (scoped_type_identifier
          name: (type_identifier) @definition.type))

(alias_declaration
  name: (type_identifier) @definition.type)

;template <typename T>
(type_parameter_declaration
  (type_identifier) @definition.type)
(template_declaration) @scope

;; Namespaces
(namespace_definition
  name: (identifier) @definition.namespace
  body: (_) @scope)

((namespace_identifier) @reference
                        (set! reference.kind "namespace"))

;; Function defintions
(template_function
  name: (identifier) @definition.function) @scope

(template_method
  name: (field_identifier) @definition.method) @scope

(template_function
  name: (scoped_identifier
    name: (identifier) @definition.function)) @scope

(function_declarator
  declarator: (scoped_identifier
                name: (type_identifier) @definition.function)) @scope

(field_declaration
        declarator: (function_declarator
                       (field_identifier) @definition.method))

(lambda_expression) @scope

;; Control structures
(try_statement
  body: (_) @scope)

(catch_clause) @scope

(destructor_name
  name: (_) @constructor)
