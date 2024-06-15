; Keywords
[
  "begin"
  "end"
  "generate"
  "endgenerate"
  (module_keyword)
  "endmodule"
  "program"
  "endprogram"
  "package"
  "endpackage"
  "checker"
  "endchecker"
  "config"
  "endconfig"
  "pure"
  "virtual"
  "extends"
  "implements"
  "super"
  (class_item_qualifier)
  "parameter"
  "localparam"
  "defparam"
  "assign"
  "typedef"
  "modport"
  "fork"
  "join"
  "join_none"
  "join_any"
  "default"
  "break"
  "tagged"
  "extern"
  "alias"
  "posedge"
  "negedge"
  "bind"
  "expect"
  "type"
  "void"
  "coverpoint"
  "cross"
  "nettype"
  "export"
  "force"
  "release"
  "timeunit"
  "timeprecision"
  "sequence"
  "endsequence"
  "property"
  "endproperty"
  "clocking"
  "endclocking"
  "iff"
  "covergroup"
  "endgroup"
  "specify"
  "endspecify"
  "primitive"
  "endprimitive"
  "wait"
  "wait_order"
  "const"
  "constraint"
  "unique"
  "do"
  "genvar"
  "inside"
  "rand"
  "new"
  "continue"
  "randc"
  (unique_priority)
  (bins_keyword)
] @keyword

[
  "class"
  "endclass"
  "interface"
  "endinterface"
  "enum"
  "struct"
  "union"
] @keyword.type

[
  "function"
  "endfunction"
  "task"
  "endtask"
] @keyword.function

"return" @keyword.return

[
  (always_keyword)
  "for"
  "foreach"
  "repeat"
  "forever"
  "initial"
  "while"
] @keyword.repeat

[
  "if"
  "else"
  (case_keyword)
  "endcase"
] @keyword.conditional

[
 "?"
 ":"
 "#"
] @keyword.conditional.ternary

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
  "{"
  "}"
  "'{"
  "<="
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
  "|=>"
  "|->"
  ">>>"
  "<<<"
  "->>"
  "->"
  (unary_operator)
  (inc_or_dec_operator)
  (queue_dimension)
] @operator

[
  ";"
  "::"
  ","
  "."
] @punctuation.delimiter

[
  "["
  "]"
  "("
  ")"
] @punctuation.bracket

[
  "or"
  "and"
] @keyword.operator

(cast
  [
    "'"
    "("
    ")"
  ] @operator)

[
  "input"
  "output"
  "inout"
  "signed"
  "unsigned"
  "assert"
  "cover"
  "assume"
  "disable"
  "automatic"
  "static"
  (dpi_function_import_property)
  (dpi_task_import_property)
] @keyword.modifier

[
 "include"
 "import"
] @keyword.import

(comment) @comment @spell

port_name: (simple_identifier) @variable

(port
  (simple_identifier) @variable)

(list_of_port_identifiers
  (simple_identifier) @variable)

(net_lvalue
  (simple_identifier) @variable)

(clocking_event) @attribute

(cycle_delay_range) @attribute

(delay_control) @attribute

(cycle_delay) @attribute

(timescale_compiler_directive) @attribute

(time_literal) @attribute

(attribute_instance) @attribute

(attribute_instance
  (attr_spec
    (simple_identifier) @property))

[
  (integral_number)
  (unbased_unsized_literal)
  (fixed_point_number)
] @number

[
  (net_type)
  (integer_vector_type)
  (integer_atom_type)
] @type.builtin


(list_of_variable_decl_assignments
  (variable_decl_assignment
    name: (simple_identifier) @variable))

(hierarchical_identifier
  (simple_identifier) @variable)

(simulation_control_task) @function.builtin

(system_tf_identifier) @function.builtin

(severity_system_task) @function.builtin

(string_literal
  (quoted_string) @string)

(include_compiler_directive) @keyword.import

(include_compiler_directive
  (quoted_string) @string.special.path)

(seq_block
  (simple_identifier) @label)

(hierarchical_identifier
  (simple_identifier)
  (simple_identifier) @variable.member)

(statement
  block_name: (simple_identifier) @label)

(clocking_declaration
  name: (simple_identifier) @constructor)

(select
  (simple_identifier) @variable.member)

; task and function
(tf_call
  (hierarchical_identifier
    (simple_identifier) @function.call))

(task_body_declaration
  name: (simple_identifier) @function)

(task_body_declaration
  (simple_identifier) @label)

(tf_port_item
  (simple_identifier) @variable)

(function_body_declaration
  name: (simple_identifier) @function)

(function_body_declaration
  (simple_identifier) @label)

; module
(module_declaration
  name: (simple_identifier) @constructor)

(module_ansi_header
   name: (simple_identifier) @constructor)

(module_nonansi_header
   name: (simple_identifier) @constructor)

(module_instantiation
  instance_type: (simple_identifier) @constructor)

(name_of_instance
 instance_name: (simple_identifier) @label)

(bind_directive
  (bind_target_scope
    (simple_identifier) @constructor))

(bind_target_instance
  (hierarchical_identifier
    (simple_identifier) @label))

(named_port_connection
  port_name: (simple_identifier) @variable.member)

(ordered_port_connection
  (expression
    (primary
      (hierarchical_identifier
        (simple_identifier) @variable.member))))

(named_parameter_assignment
  (simple_identifier) @variable.parameter)

(module_declaration
  (simple_identifier) @label)

(udp_instantiation
  (simple_identifier) @constructor)

; assertion
(sequence_declaration
  name: (simple_identifier) @constructor)

(sequence_port_item
  (simple_identifier) @variable)

(property_declaration
  name: (simple_identifier) @constructor)

(property_port_item
  (simple_identifier) @variable)

(concurrent_assertion_item
  (simple_identifier) @label)

(sequence_instance
  (hierarchical_identifier
    (simple_identifier) @constructor))

; class
(class_declaration
  name: (simple_identifier) @type)

(class_declaration
  (simple_identifier) @label)

(interface_class_declaration
  name: (simple_identifier) @type)

(interface_class_declaration
  (simple_identifier) @label)

(implicit_class_handle) @variable.builtin

(class_type
  (simple_identifier) @type)

(task_prototype
  name: (simple_identifier) @function)

(function_prototype
  name: (simple_identifier) @function)

(type_assignment
  name: (simple_identifier) @type.definition)

(data_type) @type.definition

(interface_class_type
  (simple_identifier) @type.definition)

(method_call_body
  name: (simple_identifier) @function.call)

(class_new) @function.call

; converge
(covergroup_declaration
  name: (simple_identifier) @constructor)

(cover_point
  name: (simple_identifier) @constructor)

(list_of_cross_items
  (simple_identifier) @constructor)

(coverage_option
  (simple_identifier) @variable.member)

(cover_cross
  name: (simple_identifier) @constructor)

;package
(package_declaration
  name: (simple_identifier) @constructor)

(package_declaration
  (simple_identifier) @label)

;interface
(interface_ansi_header
  name: (simple_identifier) @constructor)

(interface_nonansi_header
  name: (simple_identifier) @constructor)

(interface_ansi_header
  (simple_identifier) @label)

(package_import_item
  (simple_identifier) @keyword.import)

(interface_declaration
  name: (simple_identifier) @constructor)

(interface_declaration
  (simple_identifier) @label)

; define
(default_nettype_compiler_directive) @keyword

(default_nettype_compiler_directive
  (default_nettype_value) @keyword.directive)

(text_macro_definition) @keyword

(text_macro_definition
  (text_macro_name
    (simple_identifier) @keyword.directive))

(text_macro_definition
  (macro_text) @keyword.directive)

(text_macro_usage) @keyword.directive

(resetall_compiler_directive) @keyword

(conditional_compilation_directive) @keyword

(conditional_compilation_directive
  (ifdef_condition
    (simple_identifier) @keyword.directive))

(undefine_compiler_directive) @keyword

(undefine_compiler_directive
  (simple_identifier) @keyword.directive)

; dpi
(dpi_spec_string) @string

c_name: (c_identifier) @function

(dpi_import_export
  name: (simple_identifier) @function)

; parameter
(parameter_declaration
  (list_of_param_assignments
    (param_assignment
      (simple_identifier) @variable.parameter)))

(local_parameter_declaration
  (list_of_param_assignments
    (param_assignment
      (simple_identifier) @variable.parameter)))

; program
(program_nonansi_header
  name: (simple_identifier) @constructor)

(program_ansi_header
  name: (simple_identifier) @constructor)

(program_declaration
  name: (simple_identifier) @constructor)

(program_declaration
  (simple_identifier) @label)

(method_call_body) @function.call

(package_scope
  (simple_identifier) @constructor)

(data_declaration
  (type_declaration
    type_name: (simple_identifier) @type.definition))

(net_declaration
  (simple_identifier) @type)

(net_decl_assignment
  (simple_identifier) @variable)

(constraint_declaration
  (simple_identifier) @constructor)
