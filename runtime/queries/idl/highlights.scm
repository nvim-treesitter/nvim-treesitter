; https://neovim.io/doc/user/treesitter.html#treesitter-highlight-groups
(comment) @comment @spell

[
  "enum"
  "struct"
  "union"
  "bitmask"
  "bitset"
  "@annotation"
  "exception"
  "typedef"
  "home"
  "typeid"
  "typeprefix"
  (interface_kind)
  (value_kind)
  "component"
  "porttype"
  "connector"
  "eventtype"
  "valuetype"
] @keyword.type

(import_dcl
  "import" @keyword.directive)

[
  "module"
  "attribute"
  "factory"
  "manages"
] @keyword

[
  "const"
  "readonly"
  "abstract"
  "custom"
  "supports"
  "provides"
  "uses"
  "port"
  "mirrorport"
  "emits"
  "publishes"
  "consumes"
  "primarykey"
  "finder"
] @keyword.modifier

[
  "switch"
  "case"
  "default"
] @keyword.conditional

[
  "void"
  (signed_short_int)
  (signed_long_int)
  (signed_longlong_int)
  (unsigned_tiny_int)
  (boolean_type)
  (fixed_pt_const_type)
  (octet_type)
  (signed_tiny_int)
  (unsigned_short_int)
  (unsigned_long_int)
  (unsigned_longlong_int)
  (floating_pt_type)
  (char_type)
  (string_type)
  (any_type)
  (fixed_pt_type)
  (sequence_type)
  (map_type)
  (object_type)
  (value_base_type)
  (wide_string_type)
  (wide_char_type)
] @type.builtin

(escape_sequence) @string.escape

(scoped_name) @type

(boolean_literal) @boolean

(integer_literal) @number

[
  (floating_pt_literal)
  (fixed_pt_literal)
] @number.float

(char_literal) @character

(wide_character_literal) @character

(string_literal) @string

(wide_string_literal) @string

[
  "("
  ")"
  "["
  "]"
  "<"
  ">"
  "{"
  "}"
] @punctuation.bracket

[
  "-"
  "*"
  "+"
  "="
  "<<"
  ">>"
  "%"
  "~"
  "|"
  "^"
  "&"
] @operator

[
  "::"
  ";"
  ":"
  ","
] @punctuation.delimiter

(readonly_attr_declarator
  (simple_declarator) @variable.member)

(attr_declarator
  (simple_declarator) @variable.member)

(annotation_appl
  "@" @attribute)

(annotation_appl_custom_body
  (scoped_name) @attribute)

(op_dcl
  (identifier) @function.method)

(type_declarator
  (simple_type_spec) @type)

(type_declarator
  (any_declarators) @variable.member)

(param_dcl
  (simple_declarator) @variable.parameter)

(raises_expr
  "raises" @keyword.exception
  (scoped_name
    (identifier) @type))

(param_dcl
  (param_attribute) @keyword.modifier)

(preproc_call
  directive: (preproc_directive) @keyword.directive
  argument: (_)? @constant)

(module_dcl
  (identifier) @module)

(struct_def
  (identifier) @type
  parent: (scoped_name)? @type)

(enum_dcl
  (enumerator
    (identifier) @constant))

(annotation_dcl
  (identifier) @type)

(struct_forward_dcl
  (identifier) @type)

(bitmask_dcl
  (identifier) @type)

(bitset_dcl
  (identifier) @type
  (scoped_name)* @type)

(enum_dcl
  (identifier) @type)

(union_forward_dcl
  (identifier) @type)

(interface_forward_dcl
  (identifier) @type)

(interface_header
  (identifier) @type)

(interface_inheritance_spec
  (interface_name) @type)

(union_def
  (identifier) @type
  (switch_type_spec) @type)

(except_dcl
  (identifier) @type)

(annotation_member_type) @type

(bitfield
  (bitfield_spec
    "bitfield" @keyword.modifier
    (positive_int_const) @number
    (destination_type)? @type)
  (identifier)* @variable.member)

(bit_value) @constant

(annotation_member
  (annotation_member_type) @type
  (simple_declarator) @property)

(const_dcl
  (const_type) @type
  (identifier) @constant)

(case_label
  (const_expr) @constant)

(simple_type_spec
  (scoped_name
    (identifier) @type))

(annotation_appl_param
  (identifier) @attribute)

(home_header
  (identifier) @type)

(factory_dcl
  (identifier) @type)

(factory_param_dcl
  "in" @keyword.modifier)

(op_oneway_dcl
  "oneway" @keyword.modifier
  (identifier) @function.method)

(in_param_dcl
  "in" @keyword.modifier)

(context_expr
  "context" @keyword.modifier)

(get_excep_expr
  "getraises" @keyword.exception)

(set_excep_expr
  "setraises" @keyword.exception)

(value_header
  (identifier) @type)

(value_abs_def
  (identifier) @type)

(value_forward_dcl
  (identifier) @type)

(value_box_def
  (identifier) @type)

(provides_dcl
  (interface_type) @type
  (identifier) @variable.member)

(uses_dcl
  (identifier) @variable.member)

(component_forward_dcl
  (identifier) @type)

(component_header
  (identifier) @type)

(porttype_forward_dcl
  (identifier) @type)

(porttype_def
  (identifier) @type)

(port_dcl
  (identifier) @variable.member)

(connector_header
  (identifier) @type)

(emits_dcl
  (identifier) @variable.member)

(publishes_dcl
  (identifier) @variable.member)

(consumes_dcl
  (identifier) @variable.member)

(event_forward_dcl
  (identifier) @type)

(event_header
  (identifier) @type)

(event_abs_def
  (identifier) @type)

(template_module_dcl
  (identifier) @type)

(formal_parameter
  (formal_parameter_type) @type
  (identifier) @variable.member)

(init_param_dcl
  "in" @keyword.modifier
  (simple_declarator) @variable.parameter)

(finder_dcl
  (identifier) @function.method)

(member
  identifier: (declarators) @variable.member)

(factory_param_dcl
  (simple_declarator) @variable.parameter)

(element_spec
  (declarator) @variable.member)

(preproc_include
  (keyword_include) @type
  path: (_) @string)

(system_lib_string
  "<" @string
  ">" @string)

(extend_annotation_appl
  "//@" @attribute
  (annotation_appl_custom_body))

(extend_annotation_appl
  "//@" @attribute.builtin
  (annotation_appl_builtin_body))

[
  (autoid_kind)
  (extensibility_kind)
  (verbatim_language)
  (placement_kind)
  (service_platform)
  (try_construct_fail_action)
  (data_representation_mask)
] @constant

(anno_name) @attribute.builtin

(range_kind) @attribute.builtin
