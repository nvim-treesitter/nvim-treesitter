(function_declaration
  name: (identifier) @local.definition.function) ;@function

(var_declaration
  var_list:
    (expression_list
      (reference_expression
        (identifier) @local.definition.var)))

(function_declaration
  name: (identifier) @local.definition.function)

(const_declaration
  (const_definition
    name: (identifier) @local.definition.var))

(identifier) @local.reference

((call_expression
  name:
    (reference_expression
      (identifier)) @local.reference)
  (#set! reference.kind "call"))

((call_expression
  name:
    (selector_expression
      field:
        (reference_expression
          (identifier) @local.definition.function)))
  (#set! reference.kind "call"))

(source_file) @local.scope

(function_declaration) @local.scope

(if_expression) @local.scope

(block) @local.scope

(for_statement) @local.scope
