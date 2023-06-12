; Scopes
;-------
[
  (compilation_unit)
  (structure)
  (signature)
  (module_binding)
  (functor)
  (let_binding)
  (match_case)
  (class_binding)
  (class_function)
  (method_definition)
  (let_expression)
  (fun_expression)
  (for_expression)
  (let_class_expression)
  (object_expression)
  (attribute_payload)
] @local.scope

; Definitions
;------------
(value_pattern) @local.definition.var

(let_binding
  pattern: (value_name) @local.definition.var
  (#set! definition.var.scope "parent"))

(let_binding
  pattern: (tuple_pattern
    (value_name) @local.definition.var)
  (#set! definition.var.scope "parent"))

(let_binding
  pattern: (record_pattern
    (field_pattern
      (value_name) @local.definition.var))
  (#set! definition.var.scope "parent"))

(external
  (value_name) @local.definition.var)

(type_binding
  (type_constructor) @local.definition.type)

(abstract_type
  (type_constructor) @local.definition.type)

(method_definition
  (method_name) @local.definition.method)

(module_binding
  (module_name) @local.definition.namespace
  (#set! definition.namespace.scope "parent"))

(module_parameter
  (module_name) @local.definition.namespace)

(module_type_definition
  (module_type_name) @local.definition.type)

; References
;------------
(value_path
  .
  (value_name) @local.reference
  (#set! reference.kind "var"))

(type_constructor_path
  .
  (type_constructor) @local.reference
  (#set! reference.kind "type"))

(method_invocation
  (method_name) @local.reference
  (#set! reference.kind "method"))

(module_path
  .
  (module_name) @local.reference
  (#set! reference.kind "type"))

(module_type_path
  .
  (module_type_name) @local.reference
  (#set! reference.kind "type"))
