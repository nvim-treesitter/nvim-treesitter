; Keywords

[
  "module"
  "endmodule"
  "function"
  "endfunction"
  "task"
  "endtask"
  "parameter"
  "localparam"
  "assign"
  "typedef"
  "class"
  "endclass"
  "return"
] @keyword

[
  (always_keyword)
  "generate"
  "for"
  "foreach"
  "repeat"
  "forever"
  "while"
] @repeat

[
  "if"
  "else"
] @conditional

[
  "begin"
  "end"
  "fork"
  "join"
  "join_none"
  "join_any"
] @label

(comment) @comment

(include_compiler_directive) @constant.macro
(package_import_declaration
 "import" @include)
(package_import_declaration
 (package_import_item
  (package_identifier
   (simple_identifier) @constant)))

(text_macro_identifier
 (simple_identifier) @constant.macro)

(package_scope
 (package_identifier
  (simple_identifier) @constant))

[
  "="
  "-"
  "+"
  "/"
  "*"
  "^"
  "&"
  "|"
  "&&"
  "||"
  ":"
  (unary_operator)
  "{"
  "}"
  "'{"
  "<="
  "@"
  "or"
  "and"
  "=="
  "!="
  "==="
  "!=="
  "-:"
  "<"
  ">"
  ">="
  "%"
  ">>"
  "<<"
  "|="
] @operator

(cast
 ["'" "(" ")"] @operator)

(edge_identifier) @attribute

(port_direction) @label
(port_identifier
 (simple_identifier) @variable)

[
  (net_type)
  (integer_vector_type)
  (integer_atom_type)
] @type.builtin

[
  "signed"
  "unsigned"
] @label

(data_type
 (simple_identifier) @type)

(method_call_body
  (method_identifier) @field)

(double_quoted_string) @string

[
  (include_compiler_directive)
  (default_nettype_compiler_directive)
  (timescale_compiler_directive)
] @constant.macro

(seq_block
 (simple_identifier) @comment)

[
  "::"
] @punctuation.delimiter
(default_nettype_compiler_directive
 (default_nettype_value) @string)

(text_macro_identifier
 (simple_identifier) @constant)

(module_declaration
 (module_header
  (simple_identifier) @constructor))

(parameter_identifier
 (simple_identifier) @parameter)

[
  (integral_number)
  (unsigned_number)
  (unbased_unsized_literal)
] @number

(time_unit) @attribute

(checker_instantiation
 (checker_identifier
  (simple_identifier) @constructor))

(module_instantiation
 (simple_identifier) @constructor)

(name_of_instance
 (instance_identifier
  (simple_identifier) @variable))

(interface_port_declaration
 (interface_identifier
  (simple_identifier) @type))

(net_declaration
 (simple_identifier) @type)

(lifetime) @label

(function_identifier 
 (function_identifier 
  (simple_identifier) @function))

(function_subroutine_call 
 (subroutine_call
  (tf_call
   (simple_identifier) @function)))

(function_subroutine_call 
 (subroutine_call
  (system_tf_call
   (system_tf_identifier) @function.builtin)))

(assignment_pattern_expression
 (assignment_pattern
  (parameter_identifier) @field))

(type_declaration
  (data_type) @label)
(struct_union) @type

(type_declaration
 (simple_identifier) @type)

[
  (integer_atom_type)
  (non_integer_type)
] @type.builtin

(struct_union_member
 (list_of_variable_decl_assignments
  (variable_decl_assignment
   (simple_identifier) @field)))

(member_identifier
 (simple_identifier) @field)

(struct_union_member
 (data_type_or_void
  (data_type
   (simple_identifier) @type)))

(type_declaration
 (simple_identifier) @type)
