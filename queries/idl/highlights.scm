; https://neovim.io/doc/user/treesitter.html#treesitter-highlight-groups
(comment) @comment @spell

[
  "enum"
  "struct"
  "union"
  "bitmask"
  "bitset"
  "@annotation"
  "interface"
  "exception"
  "typedef"
] @keyword.type

[
  "module"
  "attribute"
] @keyword

[
  "const"
  "readonly"
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
  (scoped_name)
  (string_type)
  (any_type)
  (fixed_pt_type)
  (sequence_type)
  (map_type)
] @type.builtin

(boolean_literal) @boolean

(number_literal) @number

(char_literal) @character

(string_literal) @string

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
  "$"
] @operator

[
  "::"
  ";"
  ":"
  ","
] @punctuation.delimiter

(readonly_attr_declarator
  (simple_declarator) @variable.member)

(attr_declarator) @variable.member

(annotation_appl
  "@" @attribute
  (scoped_name) @attribute)

(op_dcl
  (identifier) @function.method)

(type_declarator
  (simple_type_spec) @type
  (any_declarators) @type)

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
  argument: (_) @constant)

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
    (destination_type)* @type)
  (identifier) @variable.parameter)

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

(simple_declarator
  (identifier) @attribute)

(array_declarator
  (identifier) @attribute)

(annotation_appl_param
  (identifier) @attribute)
