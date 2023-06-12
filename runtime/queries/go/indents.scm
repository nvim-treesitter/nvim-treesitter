[
  (import_declaration)
  (const_declaration)
  (var_declaration)
  (type_declaration)
  (func_literal)
  (literal_value)
  (expression_case)
  (communication_case)
  (type_case)
  (default_case)
  (block)
  (call_expression)
  (parameter_list)
  (field_declaration_list)
  (interface_type)
] @indent.begin

(literal_value
  "}" @indent.branch)

(block
  "}" @indent.branch)

(field_declaration_list
  "}" @indent.branch)

(interface_type
  "}" @indent.branch)

(const_declaration
  ")" @indent.branch)

(import_spec_list
  ")" @indent.branch)

(var_spec_list
  ")" @indent.branch)

[
  "}"
  ")"
] @indent.end

(parameter_list
  ")" @indent.branch)

(comment) @indent.ignore
