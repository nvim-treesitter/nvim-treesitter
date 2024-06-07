; Scopes
;-------
((class_declaration
  name: (name) @local.definition.type) @local.scope
  (#set! definition.type.scope "parent"))

((method_declaration
  name: (name) @local.definition.method) @local.scope
  (#set! definition.method.scope "parent"))

((function_definition
  name: (name) @local.definition.function) @local.scope
  (#set! definition.function.scope "parent"))

(anonymous_function
  (anonymous_function_use_clause
    (variable_name
      (name) @local.definition.var))) @local.scope

; Definitions
;------------
(simple_parameter
  (variable_name
    (name) @local.definition.var))

(foreach_statement
  (pair
    (variable_name
      (name) @local.definition.var)))

(foreach_statement
  (variable_name
    (name) @local.reference
    (#set! reference.kind "var"))
  (variable_name
    (name) @local.definition.var))

(property_declaration
  (property_element
    (variable_name
      (name) @local.definition.field)))

(namespace_use_clause
  (qualified_name
    (name) @local.definition.type))

; References
;------------
(named_type
  (name) @local.reference
  (#set! reference.kind "type"))

(named_type
  (qualified_name) @local.reference
  (#set! reference.kind "type"))

(variable_name
  (name) @local.reference
  (#set! reference.kind "var"))

(member_access_expression
  name: (name) @local.reference
  (#set! reference.kind "field"))

(member_call_expression
  name: (name) @local.reference
  (#set! reference.kind "method"))

(function_call_expression
  function: (qualified_name
    (name) @local.reference
    (#set! reference.kind "function")))

(object_creation_expression
  (qualified_name
    (name) @local.reference
    (#set! reference.kind "type")))

(scoped_call_expression
  scope: (qualified_name
    (name) @local.reference
    (#set! reference.kind "type"))
  name: (name) @local.reference
  (#set! reference.kind "method"))
