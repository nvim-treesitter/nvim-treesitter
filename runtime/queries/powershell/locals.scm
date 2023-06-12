; Scopes
;-------
(class_statement) @local.scope

(class_method_definition) @local.scope

(statement_block) @local.scope

(function_statement) @local.scope

; Definitions
;------------
(class_statement
  (simple_name) @local.definition.type
  (#set! definition.var.scope "parent"))

(class_property_definition
  (variable) @local.definition.field
  (#set! definition.var.scope "parent"))

(class_method_definition
  (simple_name) @local.definition.method
  (#set! definition.var.scope "parent"))

(function_statement
  (function_name) @local.definition.function
  (#set! definition.var.scope "parent"))

; function, script block parameters
(parameter_list
  (script_parameter
    (attribute_list
      (attribute
        (type_literal
          (type_spec) @local.definition.associated)))
    (variable) @local.definition.parameter))

; variable assignment
(assignment_expression
  (left_assignment_expression
    (logical_expression
      (bitwise_expression
        (comparison_expression
          (additive_expression
            (multiplicative_expression
              (format_expression
                (range_expression
                  (array_literal_expression
                    (unary_expression
                      (variable) @local.definition.var)))))))))))

; variable with type assignment
(assignment_expression
  (left_assignment_expression
    (logical_expression
      (bitwise_expression
        (comparison_expression
          (additive_expression
            (multiplicative_expression
              (format_expression
                (range_expression
                  (array_literal_expression
                    (unary_expression
                      (expression_with_unary_operator
                        (cast_expression
                          (type_literal
                            (type_spec) @local.definition.associated)
                          (unary_expression
                            (variable) @local.definition.var))))))))))))))

; data sections
(data_name
  (simple_name) @local.definition.var)

; References
;-----------
(variable) @local.reference

(command_name) @local.reference

(invokation_expression
  (variable) @_variable
  (member_name
    (simple_name) @local.reference)
  (#eq? @_variable "$this"))
