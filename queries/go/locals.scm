(
    (comment)* @definition.doc
    (function_declaration
        name: (identifier) @definition.function) ;@function 
    (#strip! @definition.doc "^//\\s*") ; <- does nothing at the moment
)

(
    (comment)* @definition.doc
    (method_declaration
        name: (field_identifier) @definition.method); @method
    (#strip! @definition.doc "^//\\s*") ; <- does nothing at the moment
)


(short_var_declaration 
  left: (expression_list
          (identifier) @definition.var)) 

(var_spec 
  name: (identifier) @definition.var)

(parameter_declaration (identifier) @definition.var)
(variadic_parameter_declaration (identifier) @definition.var)

(for_statement
 (range_clause
   left: (expression_list
           (identifier) @definition.var)))

(type_declaration 
  (type_spec
    name: (type_identifier) @definition.type))

;; reference
(identifier) @reference
(type_identifier) @reference
(field_identifier) @reference

;; Call references
(call_expression
    function: (identifier) @reference.call) @call

(call_expression
    function: (selector_expression
        field: (field_identifier) @reference.call)) @call

(call_expression
    function: (parenthesized_expression
        (identifier) @reference.call)) @call

(call_expression
    function: (parenthesized_expression
        (selector_expression
            field: (field_identifier) @reference.call))) @call

;; Scopes

(source_file) @scope
(function_declaration) @scope
(if_statement) @scope
(block) @scope
(expression_switch_statement) @scope
(for_statement) @scope
(method_declaration) @scope
