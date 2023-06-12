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
  "continue"
  "randc"
  "event"
  "global"
  "ref"
  "initial"
  "string"
  (unique_priority)
  (bins_keyword)
  (always_keyword)
] @keyword

[
  "class"
  "endclass"
  "interface"
  "endinterface"
  "enum"
  "struct"
  "union"
  "typedef"
] @keyword.type

[
  "function"
  "endfunction"
  "task"
  "endtask"
] @keyword.function

"return" @keyword.return

[
  "for"
  "foreach"
  "repeat"
  "forever"
  "while"
] @keyword.repeat

; for
(loop_generate_construct
  (generate_block
    [
      "begin"
      "end"
    ] @keyword.conditional))

; foreach
(loop_statement
  (statement
    (statement_item
      (seq_block
        [
          "begin"
          "end"
        ] @keyword.conditional))))

; repeat forever while
(loop_statement
  (statement_or_null
    (statement
      (statement_item
        (seq_block
          [
            "begin"
            "end"
          ] @keyword.conditional)))))

[
  "if"
  "else"
  "iff"
  (case_keyword)
  "endcase"
] @keyword.conditional

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
  "=>"
  "*>"
  ".*"
  (unary_operator)
  (inc_or_dec_operator)
  (queue_dimension)
] @operator

"#" @constructor

[
  ";"
  "::"
  ","
  "."
  ":"
] @punctuation.delimiter

(conditional_expression
  [
    "?"
    ":"
  ] @keyword.conditional.ternary)

[
  "["
  "]"
  "("
  ")"
  "{"
  "}"
  "'{"
] @punctuation.bracket

[
  "or"
  "and"
] @keyword.operator

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
  "directive_include"
] @keyword.import

(comment) @comment @spell

[
  "@"
  (cycle_delay_range)
  (delay_control)
  (cycle_delay)
  (attribute_instance)
] @attribute

(attribute_instance
  (attr_spec
    (simple_identifier) @property))

[
  (integral_number)
  (unbased_unsized_literal)
  (fixed_point_number)
  (unsigned_number)
] @number

[
  (net_type)
  (integer_vector_type)
  (time_unit)
  (integer_atom_type)
  (non_integer_type)
] @type.builtin

(data_type
  (simple_identifier) @type.builtin)

; variable
(list_of_variable_decl_assignments
  (variable_decl_assignment
    name: (simple_identifier) @variable))

(hierarchical_identifier
  (simple_identifier) @variable)

(tf_port_item
  (simple_identifier) @variable)

port_name: (simple_identifier) @variable

(port
  (simple_identifier) @variable)

(list_of_port_identifiers
  (simple_identifier) @variable)

(net_lvalue
  (simple_identifier) @variable)

(sequence_port_item
  (simple_identifier) @variable)

(property_port_item
  (simple_identifier) @variable)

(net_decl_assignment
  (simple_identifier) @variable)

(ERROR
  (simple_identifier) @variable)

; variable.member
(hierarchical_identifier
  (simple_identifier)
  (simple_identifier) @variable.member)

(select
  (simple_identifier) @variable.member)

(named_port_connection
  port_name: (simple_identifier) @variable.member)

(ordered_port_connection
  (expression
    (primary
      (hierarchical_identifier
        (simple_identifier) @variable.member))))

(coverage_option
  (simple_identifier) @variable.member)

; variable.builtin
(method_call_body
  arguments: (list_of_arguments
    (expression) @variable.builtin
    (#any-of? @variable.builtin "this")))

(implicit_class_handle) @variable.builtin

; variable.parameter
(named_parameter_assignment
  (simple_identifier) @variable.parameter)

(parameter_declaration
  (list_of_param_assignments
    (param_assignment
      (simple_identifier) @variable.parameter)))

(local_parameter_declaration
  (list_of_param_assignments
    (param_assignment
      (simple_identifier) @variable.parameter)))

; function builtin
[
  (simulation_control_task)
  (system_tf_identifier)
  (severity_system_task)
  (randomize_call)
  (array_or_queue_method_name)
  "new"
] @function.builtin

; declaration
(task_body_declaration
  .
  name: (simple_identifier) @function
  (simple_identifier)? @label)

(function_body_declaration
  .
  name: (simple_identifier) @function
  (simple_identifier)? @label)

(function_body_declaration
  .
  (data_type_or_void)
  name: (simple_identifier) @function
  (simple_identifier)? @label)

(clocking_declaration
  .
  name: (simple_identifier) @constructor
  (simple_identifier)? @label)

(sequence_declaration
  .
  name: (simple_identifier) @constructor
  (simple_identifier)? @label)

(property_declaration
  .
  name: (simple_identifier) @constructor
  (simple_identifier)? @label)

(class_declaration
  .
  name: (simple_identifier) @constructor
  (simple_identifier)? @label)

(interface_class_declaration
  .
  name: (simple_identifier) @constructor
  (simple_identifier)? @label)

(covergroup_declaration
  .
  name: (simple_identifier) @constructor
  (simple_identifier)? @label)

(package_declaration
  .
  name: (simple_identifier) @constructor
  (simple_identifier)? @label)

(checker_declaration
  .
  name: (simple_identifier) @constructor
  (simple_identifier)? @label)

(interface_declaration
  .
  [
    (simple_identifier) @constructor
    (interface_nonansi_header
      (simple_identifier) @constructor)
    (interface_ansi_header
      (simple_identifier) @constructor)
  ]
  (simple_identifier)? @label)

(module_declaration
  .
  [
    (simple_identifier) @constructor
    (module_nonansi_header
      (simple_identifier) @constructor)
    (module_ansi_header
      (simple_identifier) @constructor)
  ]
  (simple_identifier)? @label)

(program_declaration
  .
  [
    (simple_identifier) @constructor
    (program_nonansi_header
      (simple_identifier) @constructor)
    (program_ansi_header
      (simple_identifier) @constructor)
  ]
  (simple_identifier)? @label)

(generate_block
  name: (simple_identifier) @label)

; function.call
(method_call_body
  name: (simple_identifier) @function.call)

(tf_call
  (hierarchical_identifier
    (simple_identifier) @function.call))

; instance
(module_instantiation
  instance_type: (simple_identifier) @constructor)

(name_of_instance
  instance_name: (simple_identifier) @module)

(sequence_instance
  (hierarchical_identifier
    (simple_identifier) @module))

(udp_instantiation
  (simple_identifier) @constructor)

(ansi_port_declaration
  (interface_port_header
    interface_name: (simple_identifier) @variable
    modport_name: (simple_identifier) @variable.member)
  port_name: (simple_identifier) @variable)

; bind
(bind_directive
  (bind_target_scope
    (simple_identifier) @constructor))

(bind_target_instance
  (hierarchical_identifier
    (simple_identifier) @module))

; assertion
(concurrent_assertion_item
  (simple_identifier) @label)

; converge
(cover_point
  name: (simple_identifier) @label)

(cover_cross
  name: (simple_identifier) @module)

(list_of_cross_items
  (simple_identifier) @constructor)

;package
(package_import_item
  (simple_identifier) @constructor)

; label
(seq_block
  (simple_identifier) @label)

(statement
  block_name: (simple_identifier) @label)

; dpi
(dpi_spec_string) @string

c_name: (c_identifier) @function

(dpi_import_export
  name: (simple_identifier) @function)

; type def
(class_type
  (simple_identifier) @constructor)

(class_type
  (simple_identifier)
  (simple_identifier) @type)

(data_type
  (class_scope
    (class_type
      (simple_identifier) @constructor)))

(task_prototype
  name: (simple_identifier) @function)

(function_prototype
  name: (simple_identifier) @function)

(type_assignment
  name: (simple_identifier) @type.definition)

(interface_class_type
  (simple_identifier) @type.definition)

(package_scope
  (simple_identifier) @constructor)

(data_declaration
  (type_declaration
    type_name: (simple_identifier) @type.definition))

(net_declaration
  (simple_identifier) @type)

(constraint_declaration
  (simple_identifier) @constructor)

(method_call
  (primary
    (hierarchical_identifier
      (simple_identifier) @constructor)))

(string_literal
  (quoted_string) @string)

; include
(include_statement
  (file_path_spec) @string.special.path)

; directive
[
  "directive_define"
  "directive_default_nettype"
  "directive_resetall"
  "directive_timescale"
  "directive_undef"
  "directive_undefineall"
  "directive_ifdef"
  "directive_ifndef"
  "directive_elsif"
  "directive_endif"
  "directive_else"
] @keyword.directive.define

(include_compiler_directive
  (quoted_string) @string.special.path)

(include_compiler_directive
  (system_lib_string) @string)

(default_nettype_compiler_directive
  (default_nettype_value) @type.builtin)

(text_macro_definition
  (text_macro_name
    (simple_identifier) @keyword.directive))

(text_macro_usage) @keyword.directive

(ifdef_condition
  (simple_identifier) @keyword.directive)

(undefine_compiler_directive
  (simple_identifier) @keyword.directive)
